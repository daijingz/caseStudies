function control(fname)

% Slope Stability Analysis Program
% control.m
%
% 20 August 2015
% 
% Code originally developed by:
% Brandon Karchewski
% c/o Department of Civil Engineering - JHE-301
% McMaster University
% E: karcheba@mcmaster.ca
% 
% Code reimplemented by:
% Henry Frankis
% McMaster University
% E: frankihc@mcmaster.ca
%
% ---------------------
%
%  - Descriptions of the theory and equations implemented in the software 
% can be found in the Software Requirements Specification [SRS]
% (../Documentation Files/SRS_SSP.pdf)
%
% - A description of the secrets and services of the modules that the
% program is composed of can be found in the Module Guide [MG]. 
% (../Documentation Files/MG_SSP.pdf)
%
% - A description of the input/output relationship can be found in the 
% Module Interface Specification [MIS].
% (../Documentation Files/MIS_SSP.pdf)
%
% ---------------------
% Description:
% ---------------------
% 
% The overall program analyzes a slope stability problem given a formatted 
% data file containing a description of the stratigraphy, material 
% properties, and piezometric surface for the slope. The critical slip 
% surface is sought through a genetic algorithm (see GenAlg) using the
% Morgenstern-Price method as the objective function (see MorgPriceSolver). 
% Once the critical surface is located, it is re-analyzed using the rigid 
% finite element method (see RFEMSolver) and plots are generated showing 
% the displacement of slices, global and local factors of safety, and the
% distribution of interslice forces.
% 
% -------------------------------------------------------------------------


% -------------------------------------------------------------------------
% GET INPUT DATA (GEOMETRY, STRATIGRAPHY, MATL PROPS, ETC.) FROM USER
% -------------------------------------------------------------------------

[params_layers, params_piez, params_search,... % Get input data
    params_soln, params_load] = load_params(fname);

verify_params(params_layers, params_piez, params_search, params_soln, params_load);


% ------------------------------------------------------------------------- 
% ANALYZE SLOPE USING GENETIC ALGORITHM
% -------------------------------------------------------------------------

[cslip, F, Nint, Tint] = ... % run genetic algorithm search
    genetic_alg(params_layers, params_piez, params_search, params_soln, params_load);


% -------------------------------------------------------------------------
% OUTPUT RESULTS OF MORG-PRICE ANALYSIS (WITH PLOTS)
% -------------------------------------------------------------------------

verify_output(F);

output(cslip, F, Nint, Tint, params_layers, params_piez,... % Reanalyze and plot
params_search, params_soln, params_load, fname);
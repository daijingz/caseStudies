function tests = verify_output_test
    tests = functiontests(localfunctions);
end

function test_output_file(testCase)
    verifyEqual(testCase, exist('outputtest.out', 'file'), 2)
end

function test_output_inputXetrMin(testCase)
    global params_search;
    xEtrMin = dlmread('outputtest.out', ' ', [13 2 13 2]);
    verifyEqual(testCase, xEtrMin, params_search.Xetr(1))
end

function test_output_inputXetrMax(testCase)
    global params_search;
    xEtrMax = dlmread('outputtest.out', ' ', [14 2 14 2]);
    verifyEqual(testCase, xEtrMax, params_search.Xetr(2))
end

function test_output_inputXextMin(testCase)
    global params_search;
    xExtMin = dlmread('outputtest.out', ' ', [13 6 13 6]);
    verifyEqual(testCase, xExtMin, params_search.Xext(1))
end

function test_output_inputXextMax(testCase)
    global params_search;
    xExtMax = dlmread('outputtest.out', ' ', [14 6 14 6]);
    verifyEqual(testCase, xExtMax, params_search.Xext(2))
end

function test_output_inputYlimMin(testCase)
    global params_search;
    yLimMin = dlmread('outputtest.out', ' ', [13 11 13 11]);
    verifyEqual(testCase, yLimMin, params_search.Ylim(1))
end

function test_output_inputYlimMax(testCase)
    global params_search;
    yLimMax = dlmread('outputtest.out', ' ', [14 10 14 10]);
    verifyEqual(testCase, yLimMax, params_search.Ylim(2))
end

function test_output_inputFtype(testCase)
    global params_soln outputText;
    if params_soln.ftype
        textToSearchFor = 'constant (Spencer)';
    else
        textToSearchFor = 'half-sine (Morgenstern-Price)';
    end
    verifyEqual(testCase, isempty(strfind(outputText, textToSearchFor)), false)
end

function test_output_Fs(testCase)
    global F;
    actF = dlmread('outputtest.out', ' ', [32 0 32 0]);
    verifyEqual(testCase, actF, F)
end

function test_output_cslip(testCase)
    global cslip;
    cslipX = dlmread('outputtest.out', ' ', [23 2 27 2]);
    cslipY = dlmread('outputtest.out', ' ', [23 6 27 6]);
    verifyEqual(testCase, all(cslipX == cslip(1,:)') && all(cslipY == cslip(2,:)'), true)
end

function test_output_normal(testCase)
    global Nint;
    Nint = Nint./1000;
    normForces = dlmread('outputtest.out', ' ', [38 9 40 9]);
    verifyEqual(testCase, all(normForces == Nint'), true)
end

function test_output_shear(testCase)
    global Tint;
    Tint = Tint./1000;
    shearForces = dlmread('outputtest.out', ' ', [38 15 40 15]);
    verifyEqual(testCase, all(shearForces == Tint'), true)
end

function setupOnce(testCase)
    addpath(genpath('dataFiles/'), '../src/');
    global params_search params_soln F cslip Nint Tint outputText;
    [params_layers, params_piez, params_search, params_soln, params_load] = ...
        load_params('ValidInput.txt');
    cslip = [10 20 30 40 50; 25 20 10 15 20];
    F = 1;
    Nint = [50000 25000 75000];
    Tint = [-25000 -75000 -50000];
    output(cslip, F, Nint, Tint, params_layers, params_piez, params_search, ...
        params_soln, params_load, 'outputtest.dat');
    outputText = fileread('outputtest.out');
end

function teardownOnce(testCase)
    delete 'outputtest.out';
    delete 'outputtest.png';
end
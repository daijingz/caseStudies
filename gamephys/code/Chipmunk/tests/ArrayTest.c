#define UNITY_INCLUDE_CONFIG_H
#define UNIT_TEST

#include "Chipmunk.h"
#include "unity.h"

// UNIT TESTS FOR ARRAY MODULE //

/**
 * Tests for default size condition specified in the MIS
 * if 0 is passed max size by default must be 4
 */
void test_default_size() {
  Array * test_array = arrayNew(0);
  TEST_ASSERT_TRUE(test_array->max==4);
}

/**
 * Tests max size is what specified value should be
 * when not default
 */
void test_size_n() {
  Array * test_array1 = arrayNew(1);
  Array * test_array2 = arrayNew(5);
  Array * test_array3 = arrayNew(13);
  Array * test_array4 = arrayNew(23);
  Array * test_array5 = arrayNew(47);
  Array * test_array6 = arrayNew(97);
  TEST_ASSERT_TRUE(test_array1->max==1);
  TEST_ASSERT_TRUE(test_array2->max==5);
  TEST_ASSERT_TRUE(test_array3->max==13);
  TEST_ASSERT_TRUE(test_array4->max==23);
  TEST_ASSERT_TRUE(test_array5->max==47);
  TEST_ASSERT_TRUE(test_array6->max==97);
}

/**
 * Test that start index is 0, regardless of initial size
 */
void test_start_index() {
  Array * test_array1 = arrayNew(0);
  Array * test_array2 = arrayNew(1);
  Array * test_array3 = arrayNew(5);
  Array * test_array4 = arrayNew(97);
  TEST_ASSERT_TRUE(test_array1->num==0);
  TEST_ASSERT_TRUE(test_array2->num==0);
  TEST_ASSERT_TRUE(test_array3->num==0);
  TEST_ASSERT_TRUE(test_array4->num==0);
}

/**
 * Test object pointer is being pushed to the array
 */
void test_push() {
  Array * test_array = arrayNew(0);
  int test_val = 196613;
  void * test_ptr = &test_val;
  arrayPush(test_array, test_ptr);
  TEST_ASSERT_TRUE(test_ptr==test_array->arr[0]);
}

/**
 * Test multiple object pointers being pushed to the array
 */
void test_push_n() {
  Array * test_array = arrayNew(4);
  int test_val1 = 196613;
  void * test_pointer1 = &test_val1;
  arrayPush(test_array, test_pointer1);
  arrayPush(test_array, test_pointer1);
  arrayPush(test_array, test_pointer1);
  arrayPush(test_array, test_pointer1);
  TEST_ASSERT_TRUE(test_pointer1==test_array->arr[0]);
  TEST_ASSERT_TRUE(test_pointer1==test_array->arr[1]);
  TEST_ASSERT_TRUE(test_pointer1==test_array->arr[2]);
  TEST_ASSERT_TRUE(test_pointer1==test_array->arr[3]);
}

/**
 * test push of different pointers to array
 */
void test_push_n_diff() {
  Array * test_array = arrayNew(4);
  int test_val1 = 196613;
  char test_val2 = 'a';
  void * test_pointer1 = &test_val1;
  void * test_pointer2 = &test_val2;
  arrayPush(test_array, test_pointer1);
  arrayPush(test_array, test_pointer2);
  arrayPush(test_array, test_pointer2);
  arrayPush(test_array, test_pointer1);
  TEST_ASSERT_TRUE(test_pointer1==test_array->arr[0]);
  TEST_ASSERT_TRUE(test_pointer2==test_array->arr[1]);
  TEST_ASSERT_TRUE(test_pointer2==test_array->arr[2]);
  TEST_ASSERT_TRUE(test_pointer1==test_array->arr[3]);
}

int main() {
  UNITY_BEGIN();
  RUN_TEST(test_default_size);
  RUN_TEST(test_size_n);
  RUN_TEST(test_start_index);
  RUN_TEST(test_push);
  RUN_TEST(test_push_n);
  RUN_TEST(test_push_n_diff);
  return UNITY_END();
}

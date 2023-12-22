test_generatePermutation <- function() {
  # Test 1: Check if the function returns a list of length 2
  result <- generatePermutation(c(2, 3), list(
    c(trait1 = 1, trait2 = 2),
    c(trait1 = 1, trait2 = 2, trait3 = 3)
  ), 2)
  expect_type(result, "list")
  expect_equal(length(result), 2)

  # Test 2: Check if the matrices have the correct dimensions
  expect_equal(dim(result[[1]]), c(2, 2),
    label = "Test 2: Correct dimensions of test matrix"
  )
  expect_equal(dim(result[[2]]), c(2, 2),
    label = "Test 2: Correct dimensions of validation matrix"
  )

  # Test 3: Check if the function works correctly with one trait
  result <- generatePermutation(c(1), list(c(1)), 2)
  expect_equal(result[[1]], matrix(c(1, 1), nrow = 1),
    label = "Test 3: Correct test matrix with one trait"
  )
  expect_equal(result[[2]], matrix(c(1, 1), nrow = 1),
    label = "Test 3: Correct validation matrix with one trait"
  )
}

# Run the tests
test_generatePermutation()

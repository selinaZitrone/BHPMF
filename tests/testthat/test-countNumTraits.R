# FILEPATH: /home/selina/Repos/04_other_people/BHPMF/tests/testthat/test-count_num_traits.R

test_that("countNumTraits counts traits correctly when there are no missing or zero values", {
  X_test <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2, dimnames = list(
    NULL,
    c("trait1", "trait2", "trait3")
  ))
  result <- countNumTraits(X_test, keep_zeroes = FALSE)

  expect_equal(result$noTraits, c(3, 3))
  expect_equal(result$indObs, c(1, 2))
  expect_equal(result$traitIds, list(
    c(trait1 = 1, trait2 = 2, trait3 = 3),
    c(trait1 = 1, trait2 = 2, trait3 = 3)
  ))
})

test_that("countNumTraits counts traits correctly when there are missing values and flagNan is TRUE", {
  X_test <- matrix(c(1, 2, NA, 4, 5, NA), nrow = 2, dimnames = list(
    NULL,
    c("trait1", "trait2", "trait3")
  ))
  result <- countNumTraits(X_test, keep_zeroes = TRUE)

  expect_equal(result$noTraits, c(2, 2))
  expect_equal(result$indObs, c(1, 2))
  expect_equal(result$traitIds, list(
    c(trait1 = 1, trait3 = 3),
    c(trait1 = 1, trait2 = 2)
  ))
})

test_that("countNumTraits counts traits correctly when there are zero values and flagNan is FALSE", {
  X_test <- matrix(c(1, 2, 0, 4, 5, 0), nrow = 2, , dimnames = list(
    NULL,
    c("trait1", "trait2", "trait3")
  ))
  result <- countNumTraits(X_test, keep_zeroes = FALSE)

  expect_equal(result$noTraits, c(2, 2))
  expect_equal(result$indObs, c(1, 2))
  expect_equal(result$traitIds, list(
    c(trait1 = 1, trait3 = 3),
    c(trait1 = 1, trait2 = 2)
  ))
})

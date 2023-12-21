# Write a test that tests the function CheckPreprocessFilesExist
# one test case creates the dummy data before and then the test should return TRUE
# The other test case is missing the data and should return FALSE

# Function to create a dummy data set in a tmp folder
create_dummy_data <- function(tmp_dir, num_folds, num_hierarchy_levels,
                              prediction_levels) {
  # create the tmp.dir
  if (file.exists(tmp_dir)) {
    unlink(tmp_dir, recursive = TRUE, force = TRUE)
  }
  dir.create(tmp_dir)
  # Put all needed preprocessing files in the tmp.dir
  # Create empty dummy files with the names
  # num_parents.txt, num_children.txt, hierarchy_info.txt
  #  processed_hierarchy_info.Rda
  file.create(paste(tmp_dir, "/num_parents.txt", sep = ""))
  file.create(paste(tmp_dir, "/num_children.txt", sep = ""))
  file.create(paste(tmp_dir, "/hierarchy_info.txt", sep = ""))
  file.create(paste(tmp_dir, "/processed_hierarchy_info.Rda", sep = ""))

  # Create folders for every fold and include training and test data
  sapply(
    paste0(tmp_dir, "/fold", 1:num_folds),
    function(x) {
      dir.create(x)
      # Add dummy training data
      sapply(
        paste0(x, "/Ytrain", 1:num_hierarchy_levels, ".txt"),
        file.create
      )
      # Add dummy test data
      sapply(
        paste0(x, "/Ytest", 1:prediction_levels, ".txt"),
        file.create
      )
    }
  )
}

create_test_infrastructure <- function(tmp_dir) {
  # Create a temporary directory with 2 subdirectories: 1 empty and one with
  # some dummy test files
  dir.create(tmp_dir)
  dir.create(paste0(tmp_dir, "/empty"))
  dir.create(paste0(tmp_dir, "/full"))
  # Add some dummy data to the /full folder
  create_dummy_data(
    tmp_dir = paste0(tmp_dir, "/full/"), num_folds = 2,
    num_hierarchy_levels = 4,
    prediction_levels = 4
  )
}

create_test_infrastructure(tmp_dir = paste0(tempdir(), "/BHPMFtests/"))

# Write a test to test the function CheckPreprocessFilesExist
test_that("CheckPreprocessFilesExist returns TRUE if all files exist", {
  expect_equal(
    CheckPreprocessFilesExist(
      tmp.dir = paste0(tempdir(), "/BHPMFtests/full"), num.folds = 2,
      num.hierarchy.levels = 4, prediction.level = 4
    ),
    TRUE
  )
})

test_that("CheckPreprocessFilesExist returns FALSE if not all files exist", {
  expect_equal(
    CheckPreprocessFilesExist(
      tmp.dir = paste0(tempdir(), "/BHPMFtests/empty"), num.folds = 2,
      num.hierarchy.levels = 4, prediction.level = 4
    ),
    FALSE
  )
})

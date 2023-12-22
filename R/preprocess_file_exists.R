#' Check Preprocess Files Exist
#'
#' This function checks if the necessary preprocessing files exist in the specified directory.
#'
#' @param tmp_dir A string representing the directory where the preprocessing files are stored.
#' @param num_folds An integer representing the number of folds in the cross-validation.
#' @param hierarchy_levels An integer representing the number of hierarchy levels.
#' @param prediction_level An integer representing the level at which predictions are made.
#'
#' @return A boolean value indicating whether all necessary preprocessing files exist.
#'         Returns TRUE if all files exist, FALSE otherwise.
#'
#' @examples
#' # Add examples here
#'
#' @export
CheckPreprocessFilesExist <- function(tmp_dir,
                                      num_folds,
                                      hierarchy_levels,
                                      prediction_level) {
    files_to_search <- c(
        "num_parents.txt",
        "num_children.txt",
        "hierarchy_info.txt",
        "processed_hierarchy_info.Rda"
    )
    # if not all files could be found return FALSE
    if (!all(files_to_search %in% list.files(tmp_dir))) {
        return(FALSE)
    }

    # Check training files
    training_files_to_search <- paste0(
        "Ytrain",
        1:hierarchy_levels,
        ".txt"
    )

    # If not all training files are found in all fold folders return FALSE
    for (fold in 1:num_folds) {
        if (!all(training_files_to_search %in% list.files(
            paste0(tmp_dir, "/fold", fold)
        ))) {
            return(FALSE)
        }
    }

    # Check th test files
    test_files_to_search <- paste0(
        "Ytest",
        1:prediction_level,
        ".txt"
    )

    # If not all test files are found in all fold folders return FALSE
    for (fold in 1:num_folds) {
        if (!all(test_files_to_search %in% list.files(
            paste0(tmp_dir, "/fold", fold)
        ))) {
            return(FALSE)
        }
    }
    return(TRUE)
}

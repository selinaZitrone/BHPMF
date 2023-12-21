#' Check Preprocess Files Exist
#'
#' This function checks if the necessary preprocessing files exist in the specified directory.
#'
#' @param tmp.dir A string representing the directory where the preprocessing files are stored.
#' @param num.folds An integer representing the number of folds in the cross-validation.
#' @param num.hierarchy.levels An integer representing the number of hierarchy levels.
#' @param prediction.level An integer representing the level at which predictions are made.
#'
#' @return A boolean value indicating whether all necessary preprocessing files exist.
#'         Returns TRUE if all files exist, FALSE otherwise.
#'
#' @examples
#' # Add examples here
#'
#' @export
CheckPreprocessFilesExist <- function(tmp.dir,
                                      num.folds,
                                      num.hierarchy.levels,
                                      prediction.level) {
    # Check if hierarchy related files exist
    if (!file.exists(paste(tmp.dir, "/num_parents.txt", sep = ""))) {
        return(FALSE)
    }
    if (!file.exists(paste(tmp.dir, "/num_children.txt", sep = ""))) {
        return(FALSE)
    }
    if (!file.exists(paste(tmp.dir, "/hierarchy_info.txt", sep = ""))) {
        return(FALSE)
    }
    if (!file.exists(paste(tmp.dir, "/processed_hierarchy_info.Rda", sep = ""))) {
        return(FALSE)
    }

    # Check training files
    for (fold in 1:num.folds) {
        for (level in 1:num.hierarchy.levels) {
            if (!file.exists(paste(tmp.dir, "/fold", fold, "/Ytrain",
                level, ".txt",
                sep = ""
            ))) {
                return(FALSE)
            }
        }
    }

    # Check test file
    for (fold in 1:num.folds) {
        if (!file.exists(paste(tmp.dir, "/fold", fold, "/Ytest",
            prediction.level, ".txt",
            sep = ""
        ))) {
            return(FALSE)
        }
    }

    return(TRUE)
}

#' Generate Permutations of Trait IDs
#'
#' This function generates permutations of trait IDs for each observation across a specified number of folds.
#'
#' @param noTraits A vector containing the number of traits for each observation.
#' @param traitIds A list where each element is a vector of trait IDs for a specific observation.
#' @param numFolds The number of folds for which to generate permutations.
#'
#' @return A list containing two matrices:
#' \itemize{
#'   \item permutMatTest: A matrix where each row corresponds to an observation and each column corresponds to a fold. The element in the i-th row and j-th column is the j-th element of the permutation of trait IDs for the i-th observation for testing.
#'   \item permutMatV: A matrix with the same structure as permutMatTest, but the permutations are shifted by one position for validation.
#' }
generatePermutation <- function(noTraits, traitIds, numFolds) {
    numObs <- length(noTraits)
    permutMatV <- matrix(numeric(0), nrow = numObs, ncol = numFolds)
    permutMatTest <- matrix(numeric(0), nrow = numObs, ncol = numFolds)

    # generate all test, and validation
    for (id in 1:numObs) {
        traitId <- traitIds[[id]]
        len <- length(traitId)
        # if there is only one trait, just take this trait and repeate it numFolds times
        if (len == 1) {
            permt <- rep(traitId, numFolds)
            permv <- rep(traitId, numFolds)
        } else {
            # scramble the order of traits for the observation
            permt <- sample(traitId, len, replace = FALSE)
            # shift the order of traits for the observation
            # move the first trait to the end of the vec
            permv <- c(permt[2:len], permt[1])
        }

        permutMatTest[id, ] <- permt[1:numFolds]
        permutMatV[id, ] <- permv[1:numFolds]
    }
    return(list(permutMatTest, permutMatV))
}

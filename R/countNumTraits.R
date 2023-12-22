#' Count the number of traits per observation
#'
#' This function counts the number of traits for each observation in a given matrix.
#' It can either count all traits (excluding NA values) or only non-zero traits.
#'
#' @param X A matrix where each row represents an observation and each column represents a trait.
#' @param keep_zeroes A logical value. If TRUE, zero values are counted as traits. If FALSE, only non-zero values are counted.
#'
#' @return A list with three components:
#' noTraits: a vector of size observation containing number of available trait per observation
#' indObs:  a vector containing index of observation with at least one available trait
#' traitIds: containing index of available trait per observation
#'
countNumTraits <- function(X, keep_zeroes) {

    # find trait ids of all aviable traits per observation
    if (keep_zeroes) {
        traitIds <- lapply(seq_len(nrow(X)), function(i) which(!is.na(X[i, ])))
    } else {
        traitIds <- lapply(seq_len(nrow(X)), function(i) which(X[i, ] != 0))
    }

    noTraits <- lengths(traitIds)
    indObs <- which(noTraits > 0)


    return(list(noTraits = noTraits, indObs = indObs, traitIds = traitIds))
}

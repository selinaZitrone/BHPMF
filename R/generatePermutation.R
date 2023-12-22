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

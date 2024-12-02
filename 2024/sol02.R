input <- readLines(con = "input02.txt") |> strsplit(input, split = " ")


# Part I ------------------------------------------------------------------

isSafe <- function(report) {
  diffs <- report[-1] - report[-length(report)]
  all(diffs > 0) && all(diffs < 4) ||
  all(diffs < 0) && all(diffs > -4)
}

input <- sapply(input, as.integer)

part1 <- sum(sapply(input, isSafe))

# Part II -----------------------------------------------------------------

checkSafe <- function(ind, r) {
  isSafe(r[-ind])
}

canBeSafed <- function(report) {
  any(unlist(lapply(1:length(report), checkSafe, report)))
}

sum(sapply(input[!sapply(input, isSafe)], canBeSafed)) + part1



input <- readLines(con = "input03.txt")

# Part I ------------------------------------------------------------------

matches <- gregexpr(pattern = "mul\\([0-9]+,[0-9]+\\)", input)
muls <- regmatches(input, matches)

muls <- unlist(muls)

muls <- regmatches(muls, gregexpr(pattern = "[0-9]+", muls)) 

multiply <- function(pair) {
  pair |> as.integer() |> prod()
}

sum(sapply(muls, multiply))

# Part II -----------------------------------------------------------------

one_input <- paste0(input, collapse = "")
matches_enabled <- gregexpr(pattern = "do\\(\\)|don't\\(\\)", one_input)

dodonts <- regmatches(one_input, matches_enabled)
matches_enabled


dos <- which(dodonts[[1]] == "do()")
donts <- which(dodonts[[1]] == "don't()")

d = 1
dn = 1
pairs <- list()
while (d <= length(dos)) {
  while(dn <= length(donts)) {
    if (dos[d] < donts[dn]) {
      pairs <- append(pairs, list(c(dos[d], donts[dn])))
      d <- d + 1
      break
    } else dn <- dn + 1
  }
  while(d <= length(dos) && dos[d] < donts[dn]) {
    d <- d + 1
  }
}

pairs
lapply(pairs, function(p) { c(matches_enabled[[1]][p[1]], matches_enabled[[1]][p[2]]-1)}) -> enabled_inds
enabled_inds <- append(list(c(1, matches_enabled[[1]][donts[1]]-1)), enabled_inds)

enabled_inds |> 
  lapply(function(inds) {
    substr(one_input, inds[1], inds[2])
  }) -> enabled_strings

matches <- gregexpr(pattern = "mul\\([0-9]+,[0-9]+\\)", enabled_strings)
enables_muls <- regmatches(enabled_strings, matches)

enables_muls <- unlist(enables_muls)

enables_muls <- regmatches(enables_muls, gregexpr(pattern = "[0-9]+", enables_muls)) 

multiply <- function(pair) {
  pair |> as.integer() |> prod()
}

sum(sapply(enables_muls, multiply))


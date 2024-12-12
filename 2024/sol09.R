input = scan(file = "input09.txt", what = character())


IDs = 0:(ceiling(nchar(input[1]) / 2) - 1)
blocks <- as.integer(strsplit(input, "")[[1]])
blocks_nr = sum(blocks)

#fs <- rep(NA, blocks_nr)
# fs[10] = 5
#for resulting checksum sum(fs * pos, na.rm = TRUE)
pos <- 0:(length(fs)-1)

fs <- sapply(1:(length(IDs)-1), function(ind) {
  c(rep(IDs[ind], blocks[2 * ind - 1]), rep(NA, blocks[2 * ind]))  
}) |> unlist() |> c(rep(IDs[length(IDs)], blocks[2 * length(IDs) - 1]))
head(fs, 50)
tail(fs, 50)

firstNA <- function(fs_vec) {
  which(is.na(fs_vec))[1]
}
firstNA(fs)

lastFile <- function(fs_vec) {
  tail(which(!is.na(fs_vec)),1)
}

lastFile(fs)
swap_fs_entries <- function(fs_vec, ind1, ind2) {
  temp <- fs_vec[ind1]
  fs_vec[ind1] <- fs_vec[ind2]
  fs_vec[ind2] <- temp
  fs_vec
}
while (firstNA(fs) < lastFile(fs)) {
  fs <- swap_fs_entries(fs, firstNA(fs), lastFile(fs))
}

#result
print(sum(fs * pos, na.rm = TRUE), 20)

sum(is.na(fs))

# Part II -----------------------------------------------------------------

fs2 <- rep(NA, blocks_nr)
fs2 <- sapply(1:(length(IDs)-1), function(ind) {
  c(rep(IDs[ind], blocks[2 * ind - 1]), rep(NA, blocks[2 * ind]))  
}) |> unlist() |> c(rep(IDs[length(IDs)], blocks[2 * length(IDs) - 1]))

blocks_files <- blocks[seq.int(from = 1, to = 19999, by = 2)]
blocks_empty <- blocks[seq.int(from = 2, to = 19999, by = 2)]
files_starts <- c(1, cumsum(blocks_empty + blocks_files[-length(blocks_files)]) + 1)
empty_starts <- (files_starts + blocks_files)[-length(files_starts)]

# Let's backup file system cause we are doing global assignment,
# so we can break it.
fs2_backup <- fs2
firstFit <- function(size) {
  which(blocks_empty >= size)[1]
}

# We have to do init, cause we are doing global assignemnt for speed

init <- function() {
  fs2 <<- fs2_backup
  blocks_empty <<- blocks[seq.int(from = 2, to = 19999, by = 2)]
  empty_starts <<- (files_starts + blocks_files)[-length(files_starts)]
}

run <- function() {
  for (ind in length(IDs):2) {
    # browser()
    # For blocks_files[ind] find first from left empty block >= blocks_files[ind]
    found <- firstFit(blocks_files[ind])
      if (empty_starts[found] < files_starts[ind]) {
      # Calculate left place: block_empty[found] - block_files[ind] and update block_empty[found]
      blocks_empty[found] <<- blocks_empty[found] - blocks_files[ind]
      # copy ID[ind] to fs2[empty_starts[found]:...] of block_files[ind] length
      fs2[empty_starts[found]:(empty_starts[found] + blocks_files[ind] - 1)] <<- IDs[ind]
      # update with NAs fs2[files_starts[ind]:...] of block_files[ind] length
      fs2[files_starts[ind]:(files_starts[ind] + blocks_files[ind] - 1)] <<- NA
      # update empty_starts[found] to empty_starts[found] + block_files[ind]
      empty_starts[found] <<- empty_starts[found] + blocks_files[ind]
      # if new blocks_empty[found] will be equal zero, won't be found anymore and empty_starts[found]
      # will point to next ID in fs2 but no matter
    }
  }
}

init()
run()
print(sum(fs2 * pos, na.rm = TRUE), 20)

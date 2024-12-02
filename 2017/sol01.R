input <- scan("input01.txt", what = character()) |> 
  strsplit(input, split = "") |> 
  unlist() |> 
  as.integer()

# Part I ------------------------------------------------------------------

circ_diff <- c(diff(input), input[1] - input[length(input)])
sum(input[which(circ_diff == 0)])

# Part II -----------------------------------------------------------------
input2 <- rep(input, 2)

circ_diff_half <- diff(input2, length(input)/2)

sum(input[which(circ_diff_half[1:length(input)] == 0)])





input <- read.csv(file = "input01.txt", sep = "", header = FALSE)
library(dplyr)

# Part I ------------------------------------------------------------------
sum(abs(sort(input[,1]) - sort(input[,2])))


# Part II -----------------------------------------------------------------


inds_in <- which(input[,1] %in% input[,2])



# check if left numbers are duplicated.
data_frame(left = sort(input[inds_in,1])) |> 
  group_by(left) |> 
  count() |> 
  filter(n > 1) |> nrow()

# they are not so just count how many time they appear in right col

data_frame(C1 = sort(input[which(input[,2] %in% input[inds_in,1]),2])) |> 
  group_by(C1) |> 
  count() |> 
  mutate(score = C1 * n) -> result

sum(result$score)
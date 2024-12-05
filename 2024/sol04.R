library(dplyr)
input <- readLines(con = "input04.txt") |> strsplit(split = "")

mat_xmas <- matrix(unlist(input), nrow = 140, byrow = TRUE)

# Part I ------------------------------------------------------------------

dirs <- list(
  right = c(row=0, col=1),
  left = c(row=0, col=-1),
  down = c(row=1, col=0),
  up = c(row=-1, col=0),
  top_right = c(row=-1, col=1),
  top_left = c(row=-1, col=-1),
  bot_right = c(row=1, col=1),
  bot_left = c(row=1, col=-1)
)

search <- function(dir, mat) {
  start_point <- c(row = max(1, 1-3*dir["row"]), col = max(1, 1-3*dir["col"]))
  end_point <- c(row = min(140, 140-3*dir["row"]), col = min(140, 140-3*dir["col"]))

  grid <- expand.grid(col = start_point["col"]:end_point["col"], row = start_point["row"]:end_point["row"])
  grid <- grid[c(2,1)]
  
  adds <- matrix(0:3) %*% dir
  grid <- grid |> mutate(
    x = mat[matrix(c(row, col), ncol = 2) + matrix(rep(adds[1,], length(row)), ncol = 2, byrow = TRUE)],
    m = mat[matrix(c(row, col), ncol = 2) + matrix(rep(adds[2,], length(row)), ncol = 2, byrow = TRUE)],
    a = mat[matrix(c(row, col), ncol = 2) + matrix(rep(adds[3,], length(row)), ncol = 2, byrow = TRUE)],
    s = mat[matrix(c(row, col), ncol = 2) + matrix(rep(adds[4,], length(row)), ncol = 2, byrow = TRUE)],
  )
  grid |> mutate(xmas = (x == "X" & m == "M" & a == "A" & s == "S"))
}

result <- lapply(dirs, search, mat_xmas)

lapply(result, function(x) {
  sum(x$xmas)
}) -> sumy

sum(unlist(sumy))

# Part II -----------------------------------------------------------------

search_mas <- function(mat) {
  start_point <- c(row = 2, col = 2)
  end_point <- c(row = 139, col = 139)
  
  grid <- expand.grid(col = start_point["col"]:end_point["col"], row = start_point["row"]:end_point["row"])
  grid <- grid[c(2,1)]
 
  grid <- grid |> mutate(
    a = mat[matrix(c(row, col), ncol = 2)]
  ) |> mutate(
    is_a = (a == "A")
  ) |> mutate(
    top_left = mat[matrix(c(row, col), ncol = 2) + matrix(rep(dirs$top_left, length(row)), ncol = 2, byrow = TRUE)],
    bot_right = mat[matrix(c(row, col), ncol = 2) + matrix(rep(dirs$bot_right, length(row)), ncol = 2, byrow = TRUE)],
    top_right = mat[matrix(c(row, col), ncol = 2) + matrix(rep(dirs$top_right, length(row)), ncol = 2, byrow = TRUE)],
    bot_left = mat[matrix(c(row, col), ncol = 2) + matrix(rep(dirs$bot_left, length(row)), ncol = 2, byrow = TRUE)],
    x_mas = (is_a & ((top_left == "M" & bot_right == "S") | (top_left == "S" & bot_right == "M")) &
                       ((bot_left == "M" & top_right == "S") | (bot_left == "S" & top_right == "M")))
  )
  grid
}

sum(search_mas(mat_xmas)$x_mas)


input <- readLines(con = "input06.txt") |> strsplit(split = "")

mat_map <- matrix(unlist(input), nrow = 130, byrow = TRUE)


# Part I ------------------------------------------------------------------
dirs <- list(
  right = matrix(c(row=0, col=1)),
  left = matrix(c(row=0, col=-1)),
  down = matrix(c(row=1, col=0)),
  up = matrix(c(row=-1, col=0)),
  top_right = matrix(c(row=-1, col=1)),
  top_left = matrix(c(row=-1, col=-1)),
  bot_right = matrix(c(row=1, col=1)),
  bot_left = matrix(c(row=1, col=-1))
)

rot <- matrix(c(0,-1,1,0), ncol = 2)

start_point <- which(mat_map == "^", arr.ind =  TRUE)
start_dir <- dirs$up
cur_dir <- start_dir
cur_pos <- start_point

go <- function(pos, dir, mapa) {
  track <- list()
  ind <- 1
  while (!any(pos + t(dir) < c(1,1) | pos + t(dir) > c(130,130)) && mapa[pos + t(dir)] != "#")
  {
    pos <- pos + t(dir)
    track[[ind]] <- pos
    ind <- ind + 1
  }
  track
}

check_end <- function(pos, dir) {
  # return if on pos looking in dir seeing end
  any(pos + t(dir) < c(1,1) | pos + t(dir) > c(130,130))
}

#do walking:
mat_map[cur_pos] <- "X"
repeat {
  list_pos <- go(cur_pos, cur_dir, mat_map)
  mat_map[matrix(unlist(list_pos), ncol=2, byrow=TRUE)] <- "X"
  cur_pos <- list_pos[[length(list_pos)]]
  if(check_end(cur_pos, cur_dir))
    break
  cur_dir <- rot %*% cur_dir
} 

result_p1 <- sum(mat_map == "X") 
                    
                    
  

# Part II -----------------------------------------------------------------

# empty map with starting point
mat_map_initial <- matrix(unlist(input), nrow = 130, byrow = TRUE)

# Potential places for obstacles are where guard normally walks except the starting point
track_points <- which(mat_map == "X", arr.ind = TRUE)
row_st_point <- which(apply(track_points, 1, function(r) all(r == start_point)))
obstacles <- track_points[-row_st_point,]

# place an obstacle on the empty_map, walk checking for loop
check_loop <- function(obstacle, new_map) {
  # browser()
  cur_pos <- start_point
  cur_dir <- dirs$up
  # browser()
  new_map[matrix(obstacle, ncol=2)] <- "#"
  #do walking:
  new_map[cur_pos] <- "X"
  loops <- 0
  walk <- 1
  x_number <- list()
  x_number[[walk]] <- sum(new_map == "X")
  repeat {
    loops <- loops + 1
    list_pos <- go(cur_pos, cur_dir, new_map)
    #browser(expr = length(list_pos) == 0)
    if (length(list_pos) > 0) {
      walk <- walk + 1
      new_map[matrix(unlist(list_pos), ncol=2, byrow=TRUE)] <- "X"
      cur_pos <- list_pos[[length(list_pos)]]
      x_number[[walk]] <- sum(new_map == "X")
      # browser(expr = (loops == 160))
      if(walk > 3 && x_number[[walk]] == x_number[[walk - 1]] &&
        x_number[[walk - 1]] == x_number[[walk - 2]]) {
        # browser()
        # quartz()
        # plot_mapa(new_map, cur_pos)
        # print(x_number)
        return(TRUE)
      }
    }
    if(check_end(cur_pos, cur_dir)) {
      # browser()
      return(FALSE)
    }
    cur_dir <- rot %*% cur_dir
  } 
}

# Maybe too long, try parallel code lower
looped_all <- apply(obstacles, 1, check_loop, mat_map_initial)
result_p2_long <- sum(looped_all)

library(parallel)
detectCores()
# mclapply needs list, so we convert our matrix of obstacles
list_obstacles <- list()
for (i in 1:nrow(obstacles)) {
  list_obstacles[[i]] <- obstacles[i,,drop=FALSE]
}
system.time(looped_par2 <- mclapply(list_obstacles, check_loop, mat_map_initial,
                                    mc.cores = detectCores()),gcFirst = FALSE)

result_p2 <- sum(unlist(looped_par2))


# Visualization -----------------------------------------------------------
# You can also run check_loop with visualization which will generate the map of current
# guard walk for given obstacle. Blue "O" is used to show last position 
# so you can check if guard would loop or not.

# visualization function, you can open your preferred graphics device before it
# Look at commented code, you can uncomment it to make visualization if you encounter looping
# But you can put it in another part of the code as you wish
plot_mapa <- function(mapa, end_point) {
  track_points <- which(mapa == "X", arr.ind = TRUE)
  ob_points <- which(mapa == "#", arr.ind = TRUE)
  plot.new()
  plot.window(c(1,130), c(130,1))
  par(cex=1, cex.main=2, cex.lab = 2, cex.sub=0.8)
  plot(track_points[,2], track_points[,1], xlim =c(1,130), ylim=c(130,1), 
       lwd = 1, pch=4, 
       xlab = "col", ylab = "row", col = "Red")
  points(ob_points[,2], ob_points[,1], 
         lwd = 1, pch="#", 
         xlab = "col", ylab = "row", col = "Black")
  
  abline(v = c(1,130), h = c(1,130))
  points(end_point[,2],end_point[,1], pch = "O", col = "Blue")
}


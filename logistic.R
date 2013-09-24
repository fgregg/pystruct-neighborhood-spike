js_age <- read.csv('data/js_age.csv')$x
js_family <- read.csv('data/js_family.csv')$x
js_race <- read.csv('data/js_race.csv')$x
js_housing <- read.csv('data/js_housing.csv')$x

#rail <- read.csv('data/rail_intersects.csv')$x
rail <- read.csv('data/rail_distance.csv')$x^(1/2)
#highway <- read.csv('data/highway_intersects.csv')$x
highway <- read.csv('data/highway_distance.csv')$x^(1/2)
#grid_street <- read.csv('data/grid_intersects.csv')$x
grid_street <- read.csv('data/grid_distance.csv')$x^(1/2)
#water <- read.csv('data/water_intersects.csv')$x
water <- read.csv('data/water_distance.csv')$x^(1/2)

zoning <- read.csv('data/zoning_crosses.csv')$x
#elementary_school <- read.csv('data/elementary_schools_crosses.csv')$x
elementary_school <- read.csv('data/elementary_schools_distances.csv')$x
elementary_school <- elementary_school^(1/2)
#high_school <- read.csv('data/high_schools_crosses.csv')$x
high_school <- read.csv('data/high_schools_distances.csv')$x
high_school <- high_school^(1/2)

block_angle <- read.csv('data/block_angles.csv')$x

population <- read.csv('data/min_population.csv')$x
sufficent_pop <- as.numeric(population > 30)

features <- data.frame()

node_labels <- read.csv('data/border.csv')$border

best_F = 0
m1 = NA
for (w in seq(0.1, 1, .1)) {

  m <- glm(node_labels ~ (sufficent_pop:(
                             js_age + 
                             js_family +
                             js_race +
                             js_housing) +
                           sufficent_pop*( 
                             rail +
                             highway +
                             water +
                             #zoning +
                             elementary_school +
                             high_school +
                             block_angle)),
            weights = ifelse(node_labels, 1.0, w),
            family=binomial)

  precision <- sum(m$fitted > 0.5 & node_labels)/sum(m$fitted > 0.5)
  recall <- sum(m$fitted > 0.5 & node_labels)/sum(node_labels > 0.5)
  F = precision*recall/(0.5^2*precision + recall)
  print(F)
  if (F > best_F) {
    best_precision = precision
    best_recall = recall
    m1 <- m
    best_F <- F
  }
}


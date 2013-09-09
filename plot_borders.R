library(rgeos)
library(spdep)


nb2edgelist <- function(nb) {
  el <- c()
  for (i in 1:length(nb)) {
    neighbors <- nb[[i]]
    new.neighbors <- neighbors[neighbors > i]
    if (length(new.neighbors) > 0) {
      el <- rbind(el, cbind(i, new.neighbors))
    }
  }
  return(el)
}

extractBorder <- function(border_edgelist, polys) {
  border_lines <- apply(border_edgelist,
                        1,
                        FUN=function(x) {
                          inter <- rgeos::gIntersection(polys[x[1],],                                                                       polys[x[2],])
                        })
  border_lines <- border_lines[unlist(lapply(border_lines, class)) == "SpatialLines"]

  border_lines <- lapply(border_lines,
                         FUN=function(x) {
                           sp::spChFIDs(x,
                                        as.character(sample(10000000,
                                                            length(x))))
                         })

  border_lines <- do.call(rbind, border_lines)

  return(border_lines)
}

load('populate_blocks.Rdata')

nodes <- populated.blocks

nodes@data = data.frame(nodes@data,
                        bordering = rep(FALSE, dim(nodes@data)[1]))

predicted <- read.table("predicted_borders.csv", skip=0)

# Topology of Block Connectivity
neighbors <-spdep::poly2nb(nodes,
                           foundInBox=rgeos::gUnarySTRtreeQuery(nodes))

# Calculate 'edge features' will be node features in training
edgelist <- nb2edgelist(neighbors)

borders <- edgelist[predicted == TRUE,]


border_lines <- extractBorder(borders, nodes)

png("predicted_borders.png")
plot(nodes,
     col="black",
     border=rgb(0,0,0,0.04),
     lwd=0.01)

lines(border_lines, col="red", lwd=2)
dev.off()
                 




I'm trying to predict where people are likely to perceive that a transition between two neighborhoods.
I have been collecting data from Craiglists about which neighborhood real estate listings claim to be in. I take
these data, do some processing, and identify different neighborhood areas. I then find the borders between these areas
and that is my target data. (the 'pixels' in this case are populated US Census blocks). 

![Target borders](images/target.png)

Ultimately, this is a vector that has the length of the number of edges between adjoining census blocks. [This vector](images/data/border.csv) 
takes a value of 1 if this edge is a border between two different neighborhoods and a 0 otherwise. 

I then calculated a number feaures about these edges: do they intersect a [railroad line](images/data/rail_intersects.csv), what is the [difference in 
the racial distribution of the blocks](images/data/js_race.csv), etc. I then use pystruct to try to build a model of where these borders will occur
based on these features and pairwise connections between edges to encourage longer lines. 

However, as you can see in the figure below, this is not working very well. 

![Current Output](images/predicted_borders.png)

I believe that this is, in part, because of the sharpness of the default hamming loss in pystruct. I would like to use a
loss function that gave some credit for partitions that were 'close' to training data. I'm not quite decided on how
to best operationalize closeness.

## Visualizations of features
### Elementary School Attendance Areas: 
* Blue -- border of attendance area
* Green -- border of neighborhood
* Cyan -- overlap of feature and border
 

![Elementary Schools](images/elementary_schools.png)

### High School Attendance Areas: 
* Blue -- border of attendance area
* Green -- border of neighborhood
* Cyan -- overlap of feature and border
 

![High Schools](images/high_schools.png)

### Major Streets: 
* Blue -- Major street
* Green -- border of neighborhood
* Cyan -- overlap of feature and border
 

![Major Streets](images/major_streets.png)
 
### River: 
* Blue -- River
* Green -- border of neighborhood
* Cyan -- overlap of feature and border
 

![River](images/water.png)

### Railroad: 
* Blue -- Rail Line
* Green -- border of neighborhood
* Cyan -- overlap of feature and border
 

![Railroad](images/railroad.png)


### Land use zoning 
* Blue -- Edge of land use zone (commerical, industrial, residential)
* Green -- border of neighborhood
* Cyan -- overlap of feature and border
 


![Zoning](images/zoning.png)

### Race 
Low--tan to High--red

Distance is [Jensen Shannon Divergence](http://en.wikipedia.org/wiki/Jensen%E2%80%93Shannon_divergence)

Percent Hispanic

![Hispanic](images/hispanic.png) 

Percent Black

![Black](images/black.png)

Percent White

![White](images/white.png)

Percent Asian

![Asian](images/asian.png)

### Age
Low--tan to High--red

Distance is [Jensen Shannon Divergence](http://en.wikipedia.org/wiki/Jensen%E2%80%93Shannon_divergence)


Percent Preschool Age

![Preschool](images/preschool.png) 

Percent School Age

![School](images/school.png)

Percent College Age

![College](images/college.png)

Percent Young Adult

![Young Adult](images/young_adult.png)

Percent Middle Age

![Middle Age](images/middle_age.png)

Percent Retirement Age

![Retirement Age](images/retired.png)

### Family Type
Low--tan to High--red

Distance is [Jensen Shannon Divergence](http://en.wikipedia.org/wiki/Jensen%E2%80%93Shannon_divergence)


Percent Husband and Wife

![Husband and Wife](images/husband_wife.png) 

Percent Single Dad

![Single Dad](images/single_dad.png) 

Percent Single Mom

![Single Mom](images/single_mom.png) 

Percent Live alone

![Single Mom](images/living_along.png) 

Percent Living with Roommates

![Single Mom](images/roommates.png) 

### Block Orientation

Distance is absolute difference in angles (radians)

![Block Orientation](images/block_orientation.png) 

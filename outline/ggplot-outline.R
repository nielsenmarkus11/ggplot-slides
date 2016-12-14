# ggplot
# https://mnielsen.shinyapps.io/ggplot-slides

## Geoms (One Variable)
library(ggplot2)
ccdat <- read.csv("../chronic-conditions.csv")

new.theme <- theme_update(axis.text = element_text(size=14),
                          axis.title=element_text(size=18))
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
ccdat$state <- trim(ccdat$state)
ccdat$year <- as.numeric(ccdat$year)

alldat <- ccdat[ccdat$age=="All" & ccdat$state=="National",]

ggplot(alldat,aes(x=prevalence)) + geom_histogram()

ggplot(alldat,aes(x=prevalence)) + geom_histogram(binwidth=5)

ggplot(alldat,aes(x=prevalence)) + geom_density()

ggplot(alldat,aes(x=prevalence,color=gender)) + geom_density()

ggplot(alldat,aes(x=prevalence,color=gender,fill=gender)) + geom_density(alpha=0.35)


## Geoms (Two Variables)
ggplot(alldat,aes(x=year,y=prevalence)) + geom_point()

ggplot(alldat,aes(x=as.factor(year),y=prevalence)) + geom_boxplot()

ggplot(alldat,aes(x=year,y=prevalence)) + geom_smooth(method=lm)

ggplot(alldat,aes(x=year,y=prevalence)) + geom_point() + geom_smooth(method=lm)

ggplot(alldat,aes(x=year,y=prevalence,color=chronicCondition)) + geom_point() + geom_line()


## Geoms (Two Variables) cont.
ut.diabetes <- ccdat[ccdat$state=="Utah" &
                     ccdat$age=="All" & 
                     ccdat$chronicCondition=="Diabetes",]

ggplot(ut.diabetes,aes(x=year,y=prevalence,fill=gender)) + geom_bar(stat="identity",position="dodge")

ggplot(ut.diabetes,aes(x=year,y=prevalence,color=gender)) + geom_line()


## Faceting
ggplot(alldat,aes(x=year,y=prevalence,color=chronicCondition)) + geom_point() + geom_line()

ggplot(alldat,aes(x=year,y=prevalence,color=chronicCondition)) + geom_point() + geom_line() + facet_wrap(~gender)

ggplot(alldat,aes(x=year,y=prevalence,color=gender)) + geom_point() + geom_line() + facet_wrap(~chronicCondition)

ggplot(alldat,aes(x=year,y=prevalence,color=gender)) + geom_point() + geom_line() + facet_grid(gender~chronicCondition)


## Citation

# [ggplot2 Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf)
# CMS Medicare Chronic Conditions data from [cms.gov](https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Chronic-Conditions/index.html)
# [R Graphics Cookbook](http://www.cookbook-r.com/Graphs/) by Winston Chang


# Questions?
library(openxlsx)
library(reshape2)
library(dplyr)

alldat <- NULL
for (sheets in c("2007_m","2007_f","2008_m","2008_f","2009_m","2009_f","2010_m","2010_f","2011_m","2011_f","2012_m","2012_f","2013_m","2013_f","2014_m","2014_f")){
  
  names.dat <- read.xlsx('State_Report_Chronic_Conditions_by_Sex_and_Age_2007_2014.xlsx', sheet = sheets,colNames=F,rows = 5:7)
  names.dat2 <- as.data.frame(t(names.dat))[,-3]
  names(names.dat2) <- c("age","chronicCondition")
  names.dat2$id <- rownames(names.dat2)
  names.dat2<- names.dat2[!is.na(names.dat2$age),]
  names.dat2$age <- gsub("\\s*(Males|Females)\\s*","",names.dat2$age)
  
  dat <- read.xlsx('State_Report_Chronic_Conditions_by_Sex_and_Age_2007_2014.xlsx', sheet = sheets,colNames = F, startRow = 8)
  dat2 <- melt(dat,id=c("X1","X2"))
  dat2$value <- as.numeric(dat2$value)
  names(dat2) <- c("state","fips","id","prevalence")
  dat2$gender <- ifelse(substr(sheets,6,7)=='m',"Male","Female")
  dat2$year <- substr(sheets,1,4)
  
  tmpdat <- left_join(names.dat2,dat2,by="id")
  
  alldat <- rbind(alldat,tmpdat)
}
alldat$id <- NULL
alldat$fips <- NULL
alldat$chronicCondition <- gsub("\\s+"," ",alldat$chronicCondition)

library(Hmisc)
describe(alldat)

write.csv(alldat,"chronic-conditions.csv",row.names = F)
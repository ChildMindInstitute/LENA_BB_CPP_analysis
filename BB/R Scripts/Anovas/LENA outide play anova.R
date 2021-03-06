##LENA OUTSIDE PLAY ANOVA##

library(car)

setwd("/Volumes/data/Research/CDB/Progress Monitoring:LENA/Brave Buddies/LENA Outputs")
sub_folders=dir(path = "/Volumes/data/Research/CDB/Progress Monitoring:LENA/Brave Buddies/LENA Outputs", pattern = "M00*", ignore.case = TRUE)
sub_folders_paths=dir(path = "/Volumes/data/Research/CDB/Progress Monitoring:LENA/Brave Buddies/LENA Outputs", pattern = "M00*", ignore.case = TRUE, full.names = TRUE)

days=c("Mon", "Tue", "Wed", "Thur")

###Vocalization Duration####

durAll=c()

for (i in 1:length(sub_folders_paths) ){
  setwd(paste(sub_folders_paths[i], "/Event View", sep = ""))
  dailyFile=dir(pattern="*_OutsidePlay", full.names = FALSE)
  bravebuds_counts= read.csv(dailyFile)
  durAll=rbind(durAll, bravebuds_counts$Child_Voc_Duration[1:length(days)])
}
durAll <- na.omit(durAll)

write.csv(durAll, "durAllOutsidePlay.csv")

durAllOutsidePlay <- read.csv("durAllOutsidePlay.csv")

days <- c(1, 2, 3, 4)
daysFactor <- as.factor(days)
daysFrame <- data.frame(daysFactor)
durBind <- cbind(durAllOutsidePlay$V1, durAllOutsidePlay$V2, durAllOutsidePlay$V3, durAllOutsidePlay$V4)
durModel <- lm(durBind~1)

durAnova <- Anova(durModel, idata = daysFrame, idesign =~ daysFactor)
summary(durAnova)

##Segment Duration##

segAll=c()

for (i in 1:length(sub_folders_paths) ){
  setwd(paste(sub_folders_paths[i], "/Event View", sep = ""))
  dailyFile=dir(pattern="*_OutsidePlay", full.names = FALSE)
  bravebuds_counts= read.csv(dailyFile)
  segAll=rbind(segAll, bravebuds_counts$CHN[1:length(days)])
}
segAll <- na.omit(segAll)

write.csv(segAll, "segAllOutsidePlay.csv")

segAllOutsidePlay <- read.csv("segAllOutsidePlay.csv")

days <- c(1, 2, 3, 4)
daysFactor <- as.factor(days)
daysFrame <- data.frame(daysFactor)
segBind <- cbind(segAllOutsidePlay$V1, segAllOutsidePlay$V2, segAllOutsidePlay$V3, segAllOutsidePlay$V4)
segModel <- lm(segBind~1)

segAnova <- Anova(segModel, idata = daysFrame, idesign =~ daysFactor)
summary(segAnova)

##Vocalizations##

wordsAll=c()

for (i in 1:length(sub_folders_paths) ){
  setwd(paste(sub_folders_paths[i], "/Event View", sep = ""))
  dailyFile=dir(pattern="*_OutsidePlay", full.names = FALSE)
  bravebuds_counts= read.csv(dailyFile)
  wordsAll=rbind(wordsAll, bravebuds_counts$Child_Voc_Count[1:length(days)])
}
wordsAll <- na.omit(wordsAll)

write.csv(wordsAll, "wordsAllOutsidePlay.csv")

wordsAllOutsidePlay <- read.csv("wordsAllOutsidePlay.csv")

days <- c(1, 2, 3, 4)
daysFactor <- as.factor(days)
daysFrame <- data.frame(daysFactor)
wordsBind <- cbind(wordsAllOutsidePlay$V1, wordsAllOutsidePlay$V2, wordsAllOutsidePlay$V3, wordsAllOutsidePlay$V4)
wordsModel <- lm(wordsBind~1)

wordsAnova <- Anova(wordsModel, idata = daysFrame, idesign =~ daysFactor)
summary(wordsAnova)

##Conversational Turns##

turnsAll=c()

for (i in 1:length(sub_folders_paths) ){
  setwd(paste(sub_folders_paths[i], "/Event View", sep = ""))
  dailyFile=dir(pattern="*_OutsidePlay", full.names = FALSE)
  bravebuds_counts= read.csv(dailyFile)
  turnsAll=rbind(turnsAll, bravebuds_counts$Turn_Count[1:length(days)])
}
turnsAll <- na.omit(turnsAll)

write.csv(turnsAll, "turnsAllOutsidePlay.csv")

turnsAllOutsidePlay <- read.csv("turnsAllOutsidePlay.csv")

days <- c(1, 2, 3, 4)
daysFactor <- as.factor(days)
daysFrame <- data.frame(daysFactor)
turnsBind <- cbind(turnsAllOutsidePlay$V1, turnsAllOutsidePlay$V2, turnsAllOutsidePlay$V3, turnsAllOutsidePlay$V4)
turnsModel <- lm(turnsBind~1)

turnsAnova <- Anova(turnsModel, idata = daysFrame, idesign =~ daysFactor)
summary(turnsAnova)


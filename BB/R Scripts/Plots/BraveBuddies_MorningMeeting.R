#LENA Data Analysis: Morning Meeting data
#Jacob Stroud

setwd("/Volumes/data/Research/CDB/Progress Monitoring:LENA/Brave Buddies/LENA Outputs")
sub_folders=dir(path = "/Volumes/data/Research/CDB/Progress Monitoring:LENA/Brave Buddies/LENA Outputs", pattern = "M00*", ignore.case = TRUE)
sub_folders_paths=dir(path = "/Volumes/data/Research/CDB/Progress Monitoring:LENA/Brave Buddies/LENA Outputs", pattern = "M00*", ignore.case = TRUE, full.names = TRUE)

mycolors=rainbow(n= length(sub_folders))
groupColor= c()

days=c("Mon", "Tue", "Wed", "Thur")

################# child vocalization###################


png(filename ="/Volumes/data/Research/CDB/Progress Monitoring:LENA/Brave Buddies/Plots and Results/child-voc-morningmeeting.png",width=1400, height=600) #Opens a PNG file#
par(mfrow=c(1,2)) #Splits png into 2 sections


#Creates data matrices with all zeroes
sum_counts=  c(rep(0, length(days))) 
day_diff_words= matrix(c(rep(0, (length(days)+1)*length(sub_folders))),nrow= length(sub_folders), ncol= length(days)+1)
colorcheck=matrix(c(rep(0, (length(days)+1)*length(sub_folders))),nrow= length(sub_folders), ncol= length(days)+1)
wordsAll= c()

#Creates a plot for the data
plot(c(0,length(days)+1), c(0, 10), type="n" , xlab ="Day", main = "Child Vocalizations During Morning Meeting", cex.main=2, xaxt = "n",ylab = "Average vocalizations per 5 minute segment", cex.lab=1.3)
axis(side = 1,at= c(1:length(days)),labels =days,  las=1)


for (i in 1:length(sub_folders_paths) ){
  setwd(paste(sub_folders_paths[i], "/Event View", sep=""))
  
  
  if (identical(sub_folders[i], "M00445929")) {
    groupColor="red"
  } else if (identical(sub_folders[i], "M00412434") || identical( sub_folders[i],"M00441664") || identical(sub_folders[i],"M00402344")|| identical(sub_folders[i],"M00440011") || identical( sub_folders[i],"M00494954" ) ){
    groupColor="green"
    
  } else if  (identical(sub_folders[i], "M00475465") || identical(sub_folders[i], "M00413464") || identical (sub_folders[i],"M00490907") || identical(sub_folders[i],"M00495999") || identical(sub_folders[i],"M00472399" )) {
    groupColor="blue"
  }
  
  
  dayfiles=dir(pattern=paste(sub_folders[i], "_MorningMeeting.csv", sep = ""), full.names = FALSE)
  bravebuds_counts= read.csv(dayfiles)
  
  
  points(x= 1:length(days), y= bravebuds_counts$Child_Voc_Count[1:length(days)], pch=19, col= groupColor,type = "o",lty=3)
  wordsAll=rbind(wordsAll, bravebuds_counts$Child_Voc_Count[1:length(days)])
  for (j in 1:length(days)) {
    day_diff_words[i,j] =bravebuds_counts$Child_Voc_Count[j]-bravebuds_counts$Child_Voc_Count[1]
    colorcheck[i,j]=bravebuds_counts$Child_Voc_Count[j]-bravebuds_counts$Child_Voc_Count[1]
  }
  colorcheck[i,length(days)+1]=dayfiles
  
}

#ave_counts= sum_counts/length(sub_folders)
lines(x= 1:length(days) , y=apply(wordsAll,2,mean), type="o", pch=19, lwd=3)

arrows(x0=1:4, y0=apply(wordsAll,2,mean), x1=1:4, y1=apply(wordsAll,2,mean)+apply(wordsAll,2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)
arrows(x0=1:4, y0=apply(wordsAll,2,mean), x1=1:4, y1=apply(wordsAll,2,mean)-apply(wordsAll,2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)
legend(x=0, y= 20, c("group 1 ", "group 2", "group 3"), lty=0 ,col = c("red", "green", "blue") ,pch=20, text.font = 10, bty = "n", cex = 1)

#progress
plot(c(0,length(days)), c(-10,10), type="n" , main ="Vocalizations During Morning Meeting Across the Week", cex.main=2, xaxt = "n", xlab=NA, ylab = "Differences in child vocalization count per 5 minutes compared to Monday", cex.lab=1.3, cex.main=2)
axis(side = 1,at= 1:3,labels = c( "Tue-Mon", "Wed-Mon", "Thur-Mon"),  las=1)

for (q in 1:dim(day_diff_words)[1]){
  
  if (identical(sub_folders[q], "M00445929")) {
    groupColor="red"
  } else if (identical(sub_folders[q], "M00412434") || identical( sub_folders[q],"M00441664") || identical(sub_folders[q],"M00402344")|| identical(sub_folders[q],"M00440011") || identical( sub_folders[q],"M00494954" ) ){
    groupColor="green"
    
  } else if  (identical(sub_folders[q], "M00475465") || identical(sub_folders[q], "M00413464") || identical (sub_folders[q],"M00490907") || identical(sub_folders[q],"M00495999") || identical(sub_folders[q],"M00472399" )) {
    groupColor="blue"
  }
  
  
  points(x=1:3, y= day_diff_words[q,2:length(days)], pch=15 , col=groupColor, type = "o", lty=3  )
  lines(x= 1:3 , y=apply(day_diff_words[,2:4],2,mean), type="o", pch=19, lwd=3)
  
  arrows(x0=1:3, y0= apply(day_diff_words[,2:4],2,mean), x1=1:3, y1=apply(day_diff_words[,2:4],2,mean)+apply(day_diff_words[,2:4],2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)
  arrows(x0=1:3, y0=apply(day_diff_words[,2:4],2,mean), x1=1:3, y1=apply(day_diff_words[,2:4],2,mean)-apply(day_diff_words[,2:4],2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)
  
}


dev.off()

######################## Vocalization Duration###############

png(filename ="/Volumes/data/Research/CDB/Progress Monitoring:LENA/Brave Buddies/Plots and Results/child-voc-dur-MorningMeeting.png",width=1400, height=600)
par(mfrow=c(1,2))

durAll=c()
sum_durs=  c(rep(0, length(days)))
day_diff_durs= matrix(c(rep(0, length(days)*length(sub_folders))),nrow= length(sub_folders), ncol= length(days))
colorcheck=matrix(c(rep(0, (length(days)+1)*length(sub_folders))),nrow= length(sub_folders), ncol= length(days)+1)

plot(c(0,length(days)+1), c(0, 10), type="n" , xlab ="Day", main = "Child Vocalization Duration During Morning Meeting", cex.main=2, xaxt = "n",ylab = "Average Vocalization Duration per 5 Minute Segment", cex.lab=1.3)
axis(side = 1,at= c(1:length(days)),labels =days,  las=1)

for (i in 1:length(sub_folders_paths) ){
  setwd(paste(sub_folders_paths[i], "/Event View", sep = ""))
  dayfiles=dir(pattern=paste(sub_folders[i], "_MorningMeeting.csv", sep = ""), full.names = FALSE)
  bravebuds_counts= read.csv(dayfiles)
  durAll <- na.omit(durAll)
  if (identical(sub_folders[i], "M00445929")) {
    groupColor="red"
  } else if (identical(sub_folders[i], "M00412434") || identical( sub_folders[i],"M00441664") || identical(sub_folders[i],"M00402344")|| identical(sub_folders[i],"M00440011") || identical( sub_folders[i],"M00494954" ) ){
    groupColor="green"
    
  } else if  (identical(sub_folders[i], "M00475465") || identical(sub_folders[i], "M00413464") || identical (sub_folders[i],"M00490907") || identical(sub_folders[i],"M00495999") || identical(sub_folders[i],"M00472399" )) {
    groupColor="blue"
  }
  points(x= 1:length(days), y= bravebuds_counts$Child_Voc_Duration[1:length(days)], type = "o", pch=19, col= groupColor,lty=3)
  #sum_durs= sum_durs+bravebuds_counts$Child_Voc_Duration
  durAll=rbind(durAll, bravebuds_counts$Child_Voc_Duration[1:length(days)])
  
  for (j in 1:length(days)) {
    day_diff_durs[i,j] =bravebuds_counts$Child_Voc_Duration[j]-bravebuds_counts$Child_Voc_Duration[1]
    colorcheck[i,j]=    bravebuds_counts$Child_Voc_Duration[j]-bravebuds_counts$Child_Voc_Duration[1]
  }
  colorcheck[i,length(days)+1]=dayfiles
  
}

#ave_counts= sum_counts/length(sub_folders)
lines(x= 1:length(days) , y=apply(durAll,2,mean), type="o", pch=19, lwd=3)
#legend(x=3, y= 600, c("Subject's word count per day during lunch", "Average word count across subjects per day during lunch"), lty=c(0,1),col = c(mycolors[1], "black") ,pch=20, text.font = 10, bty = "n", cex = .7, lwd = 3)
arrows(x0=1:4, y0=apply(durAll,2,mean), x1=1:4, y1=apply(durAll,2,mean)+apply(durAll,2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)
arrows(x0=1:4, y0=apply(durAll,2,mean), x1=1:4, y1=apply(durAll,2,mean)-apply(durAll,2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)

legend(x=0, y= 20, c("group 1 ", "group 2", "group 3"), lty=0 ,col = c("red", "green", "blue") ,pch=20, text.font = 10, bty = "n", cex = 1)

plot(c(0,length(days)), c(-10, 10), type="n" , main ="Child's Vocalization Duration Progress During Morning Meeting", cex.main=2, xaxt = "n", xlab=NA,ylab = "Differences in child vocalization duration per 5 minutes compared to Monday", cex.lab=1.3, cex.main=2)
axis(side = 1,at= 1:3,labels = c( "Tue-Mon", "Wed-Mon", "Thur-Mon"),  las=1)

for (q in 1:dim(day_diff_durs)[1]){
  day_diff_durs <- na.omit(day_diff_durs)
  
  if (identical(sub_folders[q], "M00445929")) {
    groupColor="red"
  } else if (identical(sub_folders[q], "M00412434") || identical( sub_folders[q],"M00441664") || identical(sub_folders[q],"M00402344")|| identical(sub_folders[q],"M00440011") || identical( sub_folders[q],"M00494954" ) ){
    groupColor="green"
    
  } else if  (identical(sub_folders[q], "M00475465") || identical(sub_folders[q], "M00413464") || identical (sub_folders[q],"M00490907") || identical(sub_folders[q],"M00495999") || identical(sub_folders[q],"M00472399" )) {
    groupColor="blue"
  }
  points(x=1:3, y= day_diff_durs[q,2:length(days)], pch=15 , col=groupColor, type = "o", lty=3  )
  lines(x= 1:3 , y=apply(day_diff_durs[,2:4],2,mean), type="o", pch=19, lwd=3)
  
  arrows(x0=1:3, y0= apply(day_diff_durs[,2:4],2,mean), x1=1:3, y1=apply(day_diff_durs[,2:4],2,mean)+apply(day_diff_durs[,2:4],2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)
  arrows(x0=1:3, y0=apply(day_diff_durs[,2:4],2,mean), x1=1:3, y1=apply(day_diff_durs[,2:4],2,mean)-apply(day_diff_durs[,2:4],2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)
  
}




dev.off()

################### CONVERSATIONAL TURNS #################



png(filename ="/Volumes/data/Research/CDB/Progress Monitoring:LENA/Brave Buddies/Plots and Results/child-conv-turns-morningmeeting.png",width=1400, height=600)
par(mfrow=c(1,2))

sum_turns=  c(rep(0, length(days)))
day_diff_turns= matrix(c(rep(0, 5*length(sub_folders))),nrow= length(sub_folders), ncol= 5)
turnsAll=c()
colorcheck=matrix(c(rep(0, (length(days)+1)*length(sub_folders))),nrow= length(sub_folders), ncol= length(days)+1)

plot(c(0,length(days)+1), c(0, 10), type="n" , xlab ="Day", main = "Conversational Turns During Morning Meeting", cex.main=2, xaxt = "n",ylab = "Turns per 5 Minute Block"  , cex.lab=1.3)
axis(side = 1,at= c(1:length(days)),labels =days,  las=1)

for (i in 1:length(sub_folders_paths) ){
  setwd(paste(sub_folders_paths[i], "/Event View", sep = ""))
  dailyFile=dir(pattern="_MorningMeeting", full.names = FALSE)
  bravebuds_counts= read.csv(dailyFile)
  if (identical(sub_folders[i], "M00445929")) {
    groupColor="red"
  } else if (identical(sub_folders[i], "M00412434") || identical( sub_folders[i],"M00441664") || identical(sub_folders[i],"M00402344")|| identical(sub_folders[i],"M00440011") || identical( sub_folders[i],"M00494954" ) ){
    groupColor="green"
    
  } else if  (identical(sub_folders[i], "M00475465") || identical(sub_folders[i], "M00413464") || identical (sub_folders[i],"M00490907") || identical(sub_folders[i],"M00495999") || identical(sub_folders[i],"M00472399" )) {
    groupColor="blue"
  }
  points(x= 1:length(days), y= bravebuds_counts$Turn_Count[1:length(days)], type = "o",lty=3, pch=19, col= groupColor)
  turnsAll=rbind(turnsAll, bravebuds_counts$Turn_Count[1:length(days)])
  
  #sum_turns= sum_turns+bravebuds_counts$Turn_Count
  for (j in 1:length(days)) {
    day_diff_turns[i,j] =bravebuds_counts$Turn_Count[j]-bravebuds_counts$Turn_Count[1]
    colorcheck[i,j]=    bravebuds_counts$Child_Voc_Duration[j]-bravebuds_counts$Child_Voc_Duration[1]
  }
  colorcheck[i,length(days)+1]=dailyFile
  
}
#sum_turns= sum_turns/length(sub_folders)
lines(x= 1:length(days) , y=apply(turnsAll, 2, mean), type="o", pch=19, lwd=3)
#legend(x=4, y= 200, c("Subject's conversational turns per day", "Average conversational turns across subjects per day"), lwd=c(1,3),lty=c(0,1),col = c(mycolors[1], "black") ,pch=20, text.font = 10, bty = "n", cex = .6)
#legend(x=0, y= 200, sub_folders, lty=0 ,col = mycolors ,pch=20, text.font = 10, bty = "n", cex = .7)
arrows(x0=1:4, y0=apply(turnsAll,2,mean), x1=1:4, y1=apply(turnsAll,2,mean)+apply(turnsAll,2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)
arrows(x0=1:4, y0=apply(turnsAll,2,mean), x1=1:4, y1=apply(turnsAll,2,mean)-apply(turnsAll,2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)
legend(x=0, y= 10, c("group 1 ", "group 2", "group 3"), lty=0 ,col = c("red", "green", "blue") ,pch=20, text.font = 10, bty = "n", cex = 1)


#barplot(apply(day_diff_turns[,2:length(days)],2,mean), col="yellow", main ="Child's conversational turns Progress", ylim = c(-50,150) ,ylab = "Modulations in child's conversational turns Compared to Monday's", names.arg  = c("Tue-Mon", "Wed-Mon", "Thur-Mon"),cex.lab=1.5, cex.main=2, cex.names = 1.5)
#arrows(x0=1:3, y0= apply(day_diff_turns[,2:4],2,mean), x1=1:3, y1=apply(day_diff_turns[,2:4],2,mean)+apply(day_diff_turns[,2:4],2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)
#arrows(x0=1:3, y0=apply(day_diff_turns[,2:4],2,mean), x1=1:3, y1=apply(day_diff_turns[,2:4],2,mean)-apply(day_diff_turns[,2:4],2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)

plot(c(0,length(days)), c(-10,10), type="n" , main ="Child's conversational turns Progress During Morning Meeting", cex.main=2, xaxt = "n", xlab=NA,ylab = "Differences in conversational turns per 5 minutes compared to Monday", cex.lab=1.3, cex.main=2)
axis(side = 1,at= 1:3,labels = c( "Tue-Mon", "Wed-Mon", "Thur-Mon"),  las=1)

for (q in 1:dim(day_diff_turns)[1]){
  if (identical(sub_folders[q], "M00445929")) {
    groupColor="red"
  } else if (identical(sub_folders[q], "M00412434") || identical( sub_folders[q],"M00441664") || identical(sub_folders[q],"M00402344")|| identical(sub_folders[q],"M00440011") || identical( sub_folders[q],"M00494954" ) ){
    groupColor="green"
    
  } else if  (identical(sub_folders[q], "M00475465") || identical(sub_folders[q], "M00413464") || identical (sub_folders[q],"M00490907") || identical(sub_folders[q],"M00495999") || identical(sub_folders[q],"M00472399" )) {
    groupColor="blue"
  }
  
  points(x=1:3, y= day_diff_turns[q,2:length(days)], pch=15 , col=groupColor, type = "o", lty=3  )
  lines(x= 1:3 , y=apply(day_diff_turns[,2:4],2,mean), type="o", pch=19, lwd=3)
  
  arrows(x0=1:3, y0= apply(day_diff_turns[,2:4],2,mean), x1=1:3, y1=apply(day_diff_turns[,2:4],2,mean)+apply(day_diff_turns[,2:4],2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)
  arrows(x0=1:3, y0=apply(day_diff_turns[,2:4],2,mean), x1=1:3, y1=apply(day_diff_turns[,2:4],2,mean)-apply(day_diff_turns[,2:4],2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)
  
}

dev.off()

#################### SEGMENT DURATION############


png(filename ="/Volumes/data/Research/CDB/Progress Monitoring:LENA/Brave Buddies/Plots and Results/child-segment-dur-morningmeeting.png",width=1400, height=600)
par(mfrow=c(1,2))


sum_seg=  c(rep(0, length(days)))
day_diff_seg= matrix(c(rep(0, length(days)*length(sub_folders))),nrow= length(sub_folders), ncol= length(days))
segAll=c()
colorcheck=matrix(c(rep(0, (length(days)+1)*length(sub_folders))),nrow= length(sub_folders), ncol= length(days)+1)

plot(c(0,length(days)+1), c(0, 10), type="n" , xlab ="Day", main = "Segment Duration per 5 Minute Block During Morning Meeting", cex.main=2, xaxt = "n",ylab = "Time (s)"  , cex.lab=1.3)
axis(side = 1,at= c(1:length(days)),labels =days,  las=1)

for (i in 1:length(sub_folders_paths) ){
  setwd(paste(sub_folders_paths[i], "/Event View", sep = ""))
  dailyFile=dir(pattern="_MorningMeeting.csv", full.names = FALSE)
  bravebuds_counts= read.csv(dailyFile)
  if (identical(sub_folders[i], "M00445929")) {
    groupColor="red"
  } else if (identical(sub_folders[i], "M00412434") || identical( sub_folders[i],"M00441664") || identical(sub_folders[i],"M00402344")|| identical(sub_folders[i],"M00440011") || identical( sub_folders[i],"M00494954" ) ){
    groupColor="green"
    
  } else if  (identical(sub_folders[i], "M00475465") || identical(sub_folders[i], "M00413464") || identical (sub_folders[i],"M00490907") || identical(sub_folders[i],"M00495999") || identical(sub_folders[i],"M00472399" )) {
    groupColor="blue"
  }
  points(x= 1:length(days), y= bravebuds_counts$CHN[1:length(days)], type = "o", pch=19, col= groupColor, lty=3)
  #sum_seg= sum_seg+bravebuds_counts$CHN
  segAll=rbind(segAll, bravebuds_counts$CHN[1:length(days)])
  
  for (j in 1:length(days)) {
    day_diff_seg[i,j] =bravebuds_counts$CHN[j]-bravebuds_counts$CHN[1]
    
    colorcheck[i,j]=    bravebuds_counts$Child_Voc_Duration[j]-bravebuds_counts$Child_Voc_Duration[1]
  }
  colorcheck[i,length(days)+1]=dailyFile
}
#sum_seg= sum_seg/length(sub_folders)
lines(x= 1:length(days) , y=apply(segAll, 2, mean), type="o", pch=20, lwd=3)
#legend(x=4, y= 600, c("Subject's segment duration per day", "Average segment durations across subjects per day"), lwd=c(1,3),lty=c(0,1),col = c(mycolors[1], "black") ,pch=20, text.font = 10, bty = "n", cex = .6)
#legend(x=0, y= 600, sub_folders, lty=0 ,col = mycolors ,pch=20, text.font = 10, bty = "n", cex = .7)
arrows(x0=1:4, y0=apply(segAll,2,mean), x1=1:4, y1=apply(segAll,2,mean)+apply(segAll,2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)
arrows(x0=1:4, y0=apply(segAll,2,mean), x1=1:4, y1=apply(segAll,2,mean)-apply(segAll,2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)
legend(x=0, y= 20, c("group 1 ", "group 2", "group 3"), lty=0 ,col = c("red", "green", "blue") ,pch=20, text.font = 10, bty = "n", cex = 1)



#barplot(apply(day_diff_seg[,2:length(days)],2,mean), col="orange", main ="Child's  Segment Duration Progress", ylim = c(-100,600) ,ylab = "Modulations in child's segment duration Compared to Monday's", names.arg  = c("Tue-Mon", "Wed-Mon", "Thur-Mon"),cex.lab=1.5, cex.main=2, cex.names = 1.5)
#arrows(x0=1:3, y0= apply(day_diff_seg[,2:4],2,mean), x1=1:3, y1=apply(day_diff_seg[,2:4],2,mean)+apply(day_diff_seg[,2:4],2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)
#arrows(x0=1:3, y0=apply(day_diff_seg[,2:4],2,mean), x1=1:3, y1=apply(day_diff_seg[,2:4],2,mean)-apply(day_diff_seg[,2:4],2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)


plot(c(0,length(days)), c(-10,10), type="n" , main ="Child's Segment Duration Progress During Morning Meeting", cex.main=2, xaxt = "n", xlab=NA,ylab = "Differences in child segment duration per 5 minutes compared to Monday", cex.lab=1.3, cex.main=2)
axis(side = 1,at= 1:3,labels = c( "Tue-Mon", "Wed-Mon", "Thur-Mon"),  las=1)

for (q in 1:dim(day_diff_seg)[1]){
  if (identical(sub_folders[q], "M00445929")) {
    groupColor="red"
  } else if (identical(sub_folders[q], "M00412434") || identical( sub_folders[q],"M00441664") || identical(sub_folders[q],"M00402344")|| identical(sub_folders[q],"M00440011") || identical( sub_folders[q],"M00494954" ) ){
    groupColor="green"
    
  } else if  (identical(sub_folders[q], "M00475465") || identical(sub_folders[q], "M00413464") || identical (sub_folders[q],"M00490907") || identical(sub_folders[q],"M00495999") || identical(sub_folders[q],"M00472399" )) {
    groupColor="blue"
  }
  
  points(x=1:3, y= day_diff_seg[q,2:length(days)], pch=15 , col=groupColor, type = "o", lty=3  )
  lines(x= 1:3 , y=apply(day_diff_seg[,2:4],2,mean), type="o", pch=19, lwd=3)
  
  arrows(x0=1:3, y0= apply(day_diff_seg[,2:4],2,mean), x1=1:3, y1=apply(day_diff_seg[,2:4],2,mean)+apply(day_diff_seg[,2:4],2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)
  arrows(x0=1:3, y0=apply(day_diff_seg[,2:4],2,mean), x1=1:3, y1=apply(day_diff_seg[,2:4],2,mean)-apply(day_diff_seg[,2:4],2,sd)/sqrt(length(sub_folders)),length=.05,angle = 90,lty=1,lwd=2)
  
}
dev.off()




getInfValue <- function(var,Target,dPlot=F){
  library(tidyverse)
  library(ggthemes)
  
  #get woe and Inf values
  # +0.000001 is added to avoid log(0)
  iVdf <- as.data.frame.matrix(prop.table(table(df[,var],df[,Target]),2)) %>%
    rownames_to_column('VarTypes') %>% mutate(woe= log(Yes+0.000001) -log(No+0.000001), InfVal=(Yes-No)*woe ) 
  
  
  if(dPlot){
    ivdfLong <- gather(iVdf[,1:3],key=Target,value="Prop",-VarTypes)
    
    p1 <- ggplot(ivdfLong,aes(x=VarTypes,y=Prop,fill=Diabetes))+
      geom_bar(stat="identity", position=position_dodge(),size=2)+
      geom_text(aes(label=round(Prop,2)), vjust=1.6, color="Black",
                position = position_dodge(0.9), size=3.5)+
      ggtitle(paste("Proportion of ", var,"values for",Target))+
      scale_fill_brewer(palette="Paired")+theme_economist_white()+
      theme(legend.title=element_blank())+theme(axis.title=element_blank())+
      theme(axis.text.x = element_text( size = 10))
    
    p2 <- ggplot(iVdf,aes(x=VarTypes,y=InfVal))+geom_bar(stat="identity",fill="steelblue",width=0.7)+
      geom_text(aes(label=round(InfVal,2)), vjust=1.6, color="Black",
                position = position_dodge(0.9), size=3.5)+
      ggtitle(paste("Information values for ", var))+
      theme_economist_white()+theme(axis.title=element_blank())+
      theme(axis.text.x = element_text( size = 10))
    
    print(p1)
    print(p2)
  }
  
  return(sum(iVdf$InfVal) ) 
  
}

getInfValue(var,Target,dPlot = T)


#get Crammer
getV <- function(var1,var2){
  myTbl <- table(df[,var1],df[,var2])
  
  chiSQ = chisq.test(myTbl, correct=F)
  
  
  #c(chiSQ$p.value,sqrt(chiSQ$statistic / sum(myTbl)))
  sqrt(chiSQ$statistic / sum(myTbl))
}




#zero var removal
rmZeroVars <- function(df){
  zeroVarCols <- c()
  
  for(var in names(df)){
    
    if (length((unique(df[,var])))<=1){
      zeroVarCols <- c(zeroVarCols,var)
    }
  }
  
  #dropping vars
  df <- select(df,-zeroVarCols)
  
  df
}


#Get missing values in R
getMiss <- function(var,missVector=c(NA,"Missing")){
  filter(df,{{var}} %in% missVector) %>% count() %>%  data.frame() %>%  `[`(,1) 
}


MissList <- lapply(df,getMiss)



catProp <- function(var,Target) {
  round(prop.table(table(df[,Target],df[,var]),2)*100,2)
}




#Get Confusion Matrix
library(caret)
(cRf<-confusionMatrix(as.factor(tempDf$Pred),
                      as.factor(tempDf$Orig),mode= "everything",positive = "1"))





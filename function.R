get_outlier<-function (data,date_col,val_col){
  data[[date_col]]<-as.Date(as.character(data[[date_col]]),"%m/%d/%Y")
  ts_data<-zoo(data[[val_col]],data[[date_col]])
  ts_data<-ts(ts_data)
  t<-tso(ts_data,types = c("AO"),cval=2.5)
  check<-cbind.data.frame(data,adj_survey_count=round(as.numeric(t$yadj),0)) %>% 
    mutate(outlier=ifelse(data[[val_col]]>=adj_survey_count,0,1))
  return(check)
}
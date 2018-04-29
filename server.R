#dyn.load('/libs/project/libsatlas.so.3')
#dyn.load('/libs/project/libgslcblas.so.0')
#dyn.load('/libs/project/libgsl.so.0')
library(tsoutliers)
library(zoo)
library(dplyr)
library(readr)
source('function.R')

server <- function(input, output) {
  
  filedata<- reactive({
    read_csv("data.csv")
  })

#___________________________________________OMNI TAB__________________________________________________    
  t <- reactive({
    filedata_omni<-filedata() %>% 
      filter(Survey=='Omni')
    
    get_outlier(filedata_omni,"skdatecompletedqx","complete_total")
  })

  output$lastdayanomaly <- renderValueBox({
    check=tail(t()$outlier,1)
    check_d=tail(t()$skdatecompletedqx,1)
    if(check==1){lastanom="Yes"} else {lastanom="No"}
    valueBox(
      lastanom, "Was Yesterday Anomaly?", icon = icon("question-sign", lib = "glyphicon"),
      if(lastanom!="Yes"){color = "green"} else {color="maroon"}
    )
  })
  
  output$avgsurvey <- renderValueBox({
    avg_sur<-round(mean(tail(t()$complete_total,7)),0)
    valueBox(
      avg_sur, "Avg Daily Count (Last 7 Days)", icon = icon("comments"),
      color = "blue"
    )
  })
  
  output$totalanomaly <- renderValueBox({
    ct<-sum(tail(t()$outlier,7))
    valueBox(
      if(ct!=0){ct} else {0}, "# Anomalies (Last 7 Days)", icon = icon("exclamation-sign", lib = "glyphicon"),
      color = "yellow"
    )
  })
  
  output$hplot <- renderHighchart({
    hc<-highchart() %>% 
      hc_chart(type="line") %>% 
      hc_title(text = "<b>GMP Daily Surveys</b>",align = "center") %>% 
      hc_subtitle(text="Survey Completes (Last 60 Days)") %>% 
      hc_yAxis(title = list(text = "<b>Survey Count</b>"),labels = list(format = "{value}")) %>% 
      hc_add_series_times_values(name="Actual",date=t()$skdatecompletedqx, values=t()$complete_total, dataLabels=list(enabled = FALSE, format='{point.y}'),tooltip = list(pointFormat = '{series.name}: {point.y}')) %>% 
      hc_add_series_times_values(name="Adjusted",date=t()$skdatecompletedqx, values=t()$adj_survey_count, dataLabels=list(enabled = FALSE, format='{point.y}'),tooltip = list(pointFormat = '{series.name}: {point.y}')) %>% 
      hc_tooltip() %>% 
      hc_exporting(enabled = TRUE) 
    hc
    })
  
  output$plot<-renderDataTable(server = FALSE,{
    f<-t()[,-1]
    #colnames(f) <- c("Response Date", "#Surveys","#Surveys(Adjusted)","Outlier Flag")
    datatable(f,rownames=FALSE,extensions = c('Buttons','Scroller'),
              options = list(deferRender = TRUE,scrollCollapse = TRUE,scroller = TRUE,scrollY = 300,
                             order=list(list(0,'desc')),dom = c('Bfrtip'),
                             buttons = c('copy', 'csv')))
  })
  

  
  
  
  
  
  
  
  
  
  
}

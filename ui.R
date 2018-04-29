library(shiny)
library(shinydashboard)
library(DT)
library(highcharter)
ui <- dashboardPage(skin = "blue",
  dashboardHeader(title = tags$b("OET Survey: Anomaly Detection"),titleWidth = 350),
  dashboardSidebar(width=350,
    sidebarMenu(
      menuItem(tags$b("GMP"), tabName = "omni"),
      menuItem(tags$b("OGP"), tabName = "ogp"),
      menuItem(tags$b("S2H"), tabName = "s2h"),
      menuItem(tags$b("ET"), tabName = "et")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "omni",
        fluidRow(
            valueBoxOutput("lastdayanomaly"),
            valueBoxOutput("avgsurvey"),
            valueBoxOutput("totalanomaly")
        ),
        fluidRow(highchartOutput("hplot")),hr(),
        dataTableOutput("plot")
    ),
    tabItem(tabName = "ogp",h2("Coming Soon!")),
    tabItem(tabName = "s2h",h2("Coming Soon!")),
    tabItem(tabName = "et",h2("Coming Soon!"))
    )
  )
)
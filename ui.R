library(shiny)
library(shinydashboard)
library(DT)
library(highcharter)
ui <- dashboardPage(skin = "blue",
  dashboardHeader(title = tags$b("CX Platform Health")),
  dashboardSidebar(
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
       # fluidRow(
       #     valueBoxOutput("lastdayanomaly"),
       #     valueBoxOutput("avgsurvey"),
       #     valueBoxOutput("totalanomaly")
      #  ),
        fluidRow(
          box(
            title="Orders", status = "success", width = 4,
            highchartOutput("hplot_orders",height = 350)
          ),
          box(
              title="Emails", status = "success", width = 4, 
              highchartOutput("hplot_email",height = 350)
             ),
          box(
            title="Clicks", status = "success", width = 4,
            highchartOutput("hplot_clicks",height = 350)
             )
          ),
      fluidRow(
        box(
          title="Completes",status = "success", width = 4,
          highchartOutput("hplot_comp",height = 350)
        ),
        box(
          title="Click Rate",status = "success", width = 4,
          highchartOutput("hplot_ctr",height = 350)
        ),
        box(
          title="Complete Rate", status = "success", width = 4, 
          highchartOutput("hplot_cpe",height = 350)
        )
      ),
        dataTableOutput("plot")
    ),
    tabItem(tabName = "ogp",h2("Coming Soon!")),
    tabItem(tabName = "s2h",h2("Coming Soon!")),
    tabItem(tabName = "et",h2("Coming Soon!"))
    )
  )
)
library(shiny)
Sys.setlocale(category = "LC_ALL", locale = "hebrew")

# library(ggplot2)
# library(ggmap)

# Define UI for miles per gallon application
shinyUI(fluidPage(
  
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ## Application title
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  titlePanel(h1("הורה נדלנים",align="right" ),windowTitle = "הורה נדלנים"),

  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ## Sidebar Panel
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 sidebarLayout(position="right",
  sidebarPanel(
    
    wellPanel(
      helpText(HTML("<b>פתיחה</b>"),align="right"),
      h6(HTML(' אפליקציה המאפשרת ניתוח נתוני נדל"ן <br> <i>גיאוהיבסטר</i>'),align="right" )
      ),
    
    wellPanel(
      helpText(HTML("<b>אופן השימוש</b>"),align="right"),
      h6(HTML('יש למלא את הנתונים ואחר כך ללחוץ על <b>טעינת הנתונים</b>.'),align="right" ),
	  submitButton("טעינת הנתונים")
           ),
    
     wellPanel(
      helpText(HTML("<b>נתונים בסיסיים</b>"),align="right"),
      uiOutput("roomsdropdown"),
	  uiOutput("floordropdown"),
	  textInput("type", "סוג הנכס:", "דירה"),align="right"
      ),
        
    wellPanel(   
      helpText(HTML("<b>סימן מים</b>")),
      checkboxInput("watermark", "האם להשתמש בסימן", TRUE)
     # helpText("Note: automatically disabled when 'Facet' is used.")
    ),
        
    wellPanel(
      helpText(HTML("<b>ABOUT ME</b>")),
      HTML('geo-heeb-ster'),
      HTML('<br>'),
      HTML('Mega Geek'),
      HTML('<br>')
     
    ),
    
    wellPanel(
      helpText(HTML("<b>VERSION CONTROL</b>")),
      HTML('Version 0.0.1 - Prototype')
    )
    
 ,align="right"
  ),
  
  
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ## Main Panel
  ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  mainPanel(
    tabsetPanel(
      tabPanel("מידע", dataTableOutput("datatable")),
      tabPanel("מפה", plotOutput("map")),
	  tabPanel("צפיפות דירות", plotOutput("heat_map")),
      tabPanel("מגמות", plotOutput("trends"))
    ) 
  )
 )
  
)
)

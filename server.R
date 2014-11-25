Sys.setlocale(category = "LC_ALL", locale = "hebrew")
library(shiny)
library(rgdal)
library(akima) 
library(reshape2)
library(ggmap)
library(raster)
options(shiny.maxRequestSize = -1)
# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output,session) {
  userdata <- reactive(function(){
    	Sys.setlocale(category = "LC_ALL", locale = "hebrew")
       read.csv("netanya.csv", header=F, stringsAsFactors =F)
	
  })
  #this is the search bar
   output$datatable <- renderDataTable({
       data1<-userdata()
	   data1[[5]]<-enc2utf8(data1[[5]])
	   data1[[1]]<-substr(data1[[1]],0,nchar(data1[[1]])-3)
    return(data1)
  })
})

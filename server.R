library(shiny)
library(leaflet)
library(ggplot2)
library(ggthemes)

shinyServer(function(input, output) {
  output$stateList = renderUI({
    stateList = unique(business_data$state)
    stateList = sort(stateList)
    selectInput("stateList", "Select Your State", choices = stateList, selected = stateList[3])
  })
  output$categoryList = renderUI({
    datos = subset(business_data, state == input$stateList)
    categories.st = as.character(unique(unlist(datos$categories)))
    categories.st = sort(categories.st)
    if (!is.null(categories.st)) {
      selectInput("categoryList", "Select Your Category", choices = categories.st, selected = categories.st[1] )  
    }
  })
  coordenadas = reactive({
    estado = subset(business_data, state == input$stateList)
    if (!is.null(input$categoryList)){
      categoria = estado[grepl(input$categoryList, estado$categories),]
      categoria = categoria[,c(1,2,4,5,6,7,8,10,11,12,13)]
      categoria
    }
  })
  output$mymap = renderLeaflet({
    if (!is.null(input$categoryList)){
      estado = subset(business_data, state == input$stateList)
      categoria = estado[grepl(input$categoryList, estado$categories),]
      categoria = categoria[,c(1,2,4,5,6,7,8,10,11,12,13)]
      leaflet(categoria) %>% addProviderTiles("Stamen.Toner") %>% addMarkers(popup = paste("Name :",categoria$name," | ","Stars :",categoria$stars))  
    }
  })
    output$bizStar = renderPlot({
      if (!is.null(input$categoryList)){
        estado = subset(business_data, state == input$stateList)
        categoria = estado[grepl(input$categoryList, estado$categories),]
        ggplot(categoria, aes(as.factor(stars))) + geom_bar() + theme_minimal() + xlab("Star Distribution") + ylab("")
      }
      
    })
})
library(shiny)
library(DBI)
library(water)



shinyServer(function(input, output, session) {
  
  ######### Downloading data from the DB ##################################
  
  #### Datos METEO
  
  datos.WS <- reactive({
    connWS = dbConnect(MySQL(), user='shiny', password='561234', dbname='METEO1',
                       host='172.21.116.72')
    on.exit(dbDisconnect(connWS), add = TRUE)
    datos <- dbGetQuery(connWS, paste0("SELECT * FROM Current WHERE FechaHora BETWEEN '", input$start1, "' AND '", paste(input$stop1, "23:59:59"), "'" ))
    # datos$FechaHora <- as.POSIXct(strptime(datos$FechaHora, format= "%Y-%m-%d %H:%M:%S", tz="ART"))
    #dbDisconnect(datosWS)
    if(length(datos)>1){
      datos <- read.WSdata(WSdata = datos, 
                           datetime.format =  "%Y-%m-%d %H:%M:%S", columns = c("datetime", "temp", 
                           "RH", NA, "rain", "radiation", "wind"), lat=-33.00513, 
                           long= -68.86469, elev=927, height= 2)
      } else {datos <-  NA}
  })
  
  ### Parcelas y riego
  
  datos.goteo <- reactive({
    connRiego = dbConnect(MySQL(), user='shiny', password='561234', dbname='RIEGO',
                          host='172.21.116.72')
    on.exit(dbDisconnect(connRiego), add = TRUE)
    datos <- dbGetQuery(connRiego, "SELECT * FROM GOTEO")
  })
  
  datos.superf <- reactive({
    connRiego = dbConnect(MySQL(), user='shiny', password='561234', dbname='RIEGO',
                          host='172.21.116.72')
    on.exit(dbDisconnect(connRiego), add = TRUE)
    datos <- dbGetQuery(connRiego, "SELECT * FROM SUPERFICIAL")
  })
  
  datos.Kc <- reactive({
    connRiego = dbConnect(MySQL(), user='shiny', password='561234', dbname='RIEGO',
                          host='172.21.116.72')
    on.exit(dbDisconnect(connRiego), add = TRUE)
    datos <- dbGetQuery(connRiego, "SELECT * FROM KC")
  })
  
  datos.riego <- reactive({
    connRiego = dbConnect(MySQL(), user='shiny', password='561234', dbname='RIEGO',
                          host='172.21.116.72')
    on.exit(dbDisconnect(connRiego), add = TRUE)
    datos <- dbGetQuery(connRiego, "SELECT * FROM RIEGOS")
  })
  
  ################### RESULTS ###################################
  
  ### Sync dates
  
  observe({
    start <- input$start1
    stop <- input$stop1
    updateDateInput(session, "start2",
                    value = start)
    updateDateInput(session, "stop2",
                    value = stop)
    updateDateInput(session, "start3",
                    value = start)
    updateDateInput(session, "stop3",
                    value = stop)
  })
  
  observe({
    start <- input$start2
    stop <- input$stop2
    updateDateInput(session, "start1",
                    value = start)
    updateDateInput(session, "stop1",
                    value = stop)
    updateDateInput(session, "start3",
                    value = start)
    updateDateInput(session, "stop3",
                    value = stop)
  })
  
  observe({
    start <- input$start3
    stop <- input$stop3
    updateDateInput(session, "start2",
                    value = start)
    updateDateInput(session, "stop2",
                    value = stop)
    updateDateInput(session, "start1",
                    value = start)
    updateDateInput(session, "stop1",
                    value = stop)
  })
  
  observe({
    Parcela <- input$Parcela1
    updateSelectInput(session, "Parcela2", selected = Parcela)
  })
  
  observe({
    Parcela <- input$Parcela2
    updateSelectInput(session, "Parcela1", selected = Parcela)
  })
  
  observe({
    Parcela <- input$Parcela1
    if(input$Parcela1 != ""){
      ## TODO: Esto ando solo para goteos..!
      parcelaSelected <- strsplit(input$Parcela1, split=" ")[[1]][1]  #Extraigo el N_PARCELA
      datos.goteo <- datos.goteo()[datos.goteo()$N_PARCELA == parcelaSelected,]
      updateSelectInput(session, "Kc", selected = datos.Kc()$Nombre[datos.Kc()$ID==datos.goteo$KC_default])
    }
  })
  
  
  ######### Agromet ####
  
  output$WSplot <- renderPlot({
    plot(datos.WS(), hourly=!input$todos.los.datos)
  })
  
  output$downloadWS <- downloadHandler(
    filename = function() {
      paste("INTA-Meteo-", input$start1, "-", input$stop1, ".csv", sep="")
    },
    content = function(file) {
      write.csv(datos.WS()$hourly, file)
    }
  )
  
  
  ########## ET ####
  ETo_values <- reactive({
    datos <- datos.WS()
    dias <- unique(datos$hourly$date)
    ETo_values <- vector()
    for(i in 1:nrow(datos$hourly)){
      date <- as.POSIXlt(datos$hourly[i,1], format="%Y-%m-%d %H:%M:%S")
      ETo_values <- c(ETo_values, hourlyET(datos$hourly[i,], lat=-33.00513, 
                                           long = -68.86469, elev=927, ET="ETr", 
                                           height = 2))
    }
    ETo_dailys <- vector()
    for(j in 1:length(dias)){
      ETo_dailys <- c(ETo_dailys, sum(ETo_values[datos$hourly$date==dias[j]]))
    }
    ETo_dailys <- round(ETo_dailys,2)
    ETo_values <- list()
    ETo_values$dias <- dias  
    ETo_values$ETo <- ETo_dailys
    return(ETo_values)
  })
  
  Kc_values <- reactive({
    if(input$Parcela1 != ""){
      Kc_values <- list()
      IDKc <- datos.Kc()$ID[datos.Kc()$Nombre==input$Kc] ## Solo el ID
      meses <- as.POSIXlt(ETo_values()$dias)$mon
      meses_names <- c("enero", "febrero", "marzo", "abril", "mayo", "junio", 
                       "julio", "agosto", "setiembre", "octubre", "noviembre", "diciembre") #Seguro que esta en Constants
      Kc_values <-data.frame(n_mes=meses, mes=meses_names[meses+1], Kc=as.numeric(datos.Kc()[IDKc,meses+3]))
      ### TODO: Hace un bucle nabo
      u_Kc_values <- unique(Kc_values)
      updateSliderInput(session, "Kc_mes1", label = paste("Kc" , u_Kc_values$mes[1]), value = u_Kc_values$Kc[1])
      updateSliderInput(session, "Kc_mes2", label = paste("Kc" , u_Kc_values$mes[2]), value = u_Kc_values$Kc[2])
      updateSliderInput(session, "Kc_mes3", label = paste("Kc" , u_Kc_values$mes[3]), value = u_Kc_values$Kc[3])
      updateSliderInput(session, "Kc_mes4", label = paste("Kc" , u_Kc_values$mes[4]), value = u_Kc_values$Kc[4])
      updateSliderInput(session, "Kc_mes5", label = paste("Kc" , u_Kc_values$mes[5]), value = u_Kc_values$Kc[5])
      updateSliderInput(session, "Kc_mes6", label = paste("Kc" , u_Kc_values$mes[6]), value = u_Kc_values$Kc[6])
      updateSliderInput(session, "Kc_mes7", label = paste("Kc" , u_Kc_values$mes[7]), value = u_Kc_values$Kc[7])
      updateSliderInput(session, "Kc_mes8", label = paste("Kc" , u_Kc_values$mes[8]), value = u_Kc_values$Kc[8])
      updateSliderInput(session, "Kc_mes9", label = paste("Kc" , u_Kc_values$mes[9]), value = u_Kc_values$Kc[9])
      updateSliderInput(session, "Kc_mes10", label = paste("Kc" , u_Kc_values$mes[10]), value = u_Kc_values$Kc[10])
      updateSliderInput(session, "Kc_mes11", label = paste("Kc" , u_Kc_values$mes[11]), value = u_Kc_values$Kc[11])
      updateSliderInput(session, "Kc_mes12", label = paste("Kc" , u_Kc_values$mes[12]), value = u_Kc_values$Kc[12])
      ### End update sliders
      return(Kc_values)
    }
  })
  
  output$n_meses <- renderText({length(unique(Kc_values()$mes))})
  
  output$ETo_acum <- renderText({paste("ETo acumulada", sum(ETo_values()$ETo), "mm.")})
  
  output$ETc_acum <- renderText({
    if(input$Parcela1 != ""){
      Kc_slider <- as.numeric(as.factor(Kc_values()$mes))  
      Kc_value <- as.numeric(as.factor(Kc_values()$mes))
      Kc_value[Kc_slider==1] <- input$Kc_mes1
      Kc_value[Kc_slider==2] <- input$Kc_mes2
      Kc_value[Kc_slider==3] <- input$Kc_mes3
      Kc_value[Kc_slider==4] <- input$Kc_mes4
      Kc_value[Kc_slider==5] <- input$Kc_mes5
      Kc_value[Kc_slider==6] <- input$Kc_mes6
      Kc_value[Kc_slider==7] <- input$Kc_mes7
      Kc_value[Kc_slider==8] <- input$Kc_mes8
      Kc_value[Kc_slider==9] <- input$Kc_mes9
      Kc_value[Kc_slider==10] <- input$Kc_mes10
      Kc_value[Kc_slider==11] <- input$Kc_mes11
      Kc_value[Kc_slider==12] <- input$Kc_mes12
      ETc <- ETo_values()$ETo * Kc_value
      paste("ETc acumulada", round(sum(ETc),2), "mm.")
    }
    })
  
  output$EToplot <- renderPlot({
    bp <- barplot(ETo_values()$ETo, names.arg=ETo_values()$dias, ylab="ETo (mm)", col="blue")
    text(bp, ETo_values()$ETo-0.3, labels=as.character(ETo_values()$ETo), xpd=TRUE)
  })
  
  output$ETcplot <- renderPlot({
    if(input$Parcela1 != ""){
      Kc_slider <- as.numeric(as.factor(Kc_values()$mes))
      Kc_value <- as.numeric(as.factor(Kc_values()$mes))
      Kc_value[Kc_slider==1] <- input$Kc_mes1
      Kc_value[Kc_slider==2] <- input$Kc_mes2
      Kc_value[Kc_slider==3] <- input$Kc_mes3
      Kc_value[Kc_slider==4] <- input$Kc_mes4
      Kc_value[Kc_slider==5] <- input$Kc_mes5
      Kc_value[Kc_slider==6] <- input$Kc_mes6
      Kc_value[Kc_slider==7] <- input$Kc_mes7
      Kc_value[Kc_slider==8] <- input$Kc_mes8
      Kc_value[Kc_slider==9] <- input$Kc_mes9
      Kc_value[Kc_slider==10] <- input$Kc_mes10
      Kc_value[Kc_slider==11] <- input$Kc_mes11
      Kc_value[Kc_slider==12] <- input$Kc_mes12
      bp <- barplot(ETo_values()$ETo * Kc_value, names.arg=ETo_values()$dias, 
                    ylab="ETc (mm)", col="dark green", ylim=c(0, max(ETo_values()$ETo)))
      text(bp, ETo_values()$ETo * Kc_value -0.3, labels=as.character(round(ETo_values()$ETo  * Kc_value,2)), xpd=TRUE)
    }
  })
  
  output$downloadET <- downloadHandler(
    filename = function() {
      paste("INTA-Meteo-", input$start1, "-", input$stop1, ".csv", sep="")
    },
    content = function(file) {
      write.csv(datos.WS()$hourly, file)
    }
  )
  
  ######### Riego ####
  
  lamina_aplicada <- reactive({
    connRiego = dbConnect(MySQL(), user='shiny', password='561234', dbname='RIEGO',
                          host='172.21.116.72')
    on.exit(dbDisconnect(connRiego), add = TRUE)
    ## TODO: Esto ando solo para goteos..!
    parcelaSelected <- strsplit(input$Parcela2, split=" ")[[1]][1]  #Extraigo el N_PARCELA
    
    datos.goteo <- datos.goteo()[datos.goteo()$N_PARCELA == parcelaSelected,]  # Hago una tabla con la fila que me interesa
    datos <- dbGetQuery(connRiego, paste0("SELECT * FROM RIEGOS WHERE Fecha BETWEEN '", input$start3, "' AND '", input$stop3, 
                                          "' AND N_PARCELA = ", datos.goteo$N_PARCELA)) ## Traigo los riegos
    # Lámina aplicada=CAUDAL_GOT*Horas de Riego*((100/DIST_HIL)*(100/DIST_GOT))/1000/10 Formula para goteo
    lamina_aplicada <- list()
    lamina_aplicada$riegos <- datos.goteo$CAUDAL_GOT*datos$`Horas de Riego`*((100/datos.goteo$DIST_HILERAS)*(100/datos.goteo$DIST_GOT))/1000/10 #Calculo las laminas
    lamina_aplicada$fechas <- datos$Fecha #Guardo las fechas
    return(lamina_aplicada)
  })
  
  
  output$Lam_acum <- renderText({paste("Lámina de riego acumulada", round(sum(lamina_aplicada()$riegos),0), "mm.")})
  output$ppT_acum <- renderText({paste("Precipitación acumulada", sum(datos.WS()$hourly$rain), "mm.")})
  output$ppE_acum <- renderText({paste("Precipitación efectiva acumulada", round(sum(datos.WS()$hourly$rain)*0.6,0), "mm.")})
  
  output$riegoPlot <- renderPlot({
    if(input$Parcela2 != ""){
      df1 <- data.frame(fechas=as.character(seq.Date(input$start3, input$stop3, by=1)))
      df2 <- data.frame(fechas=lamina_aplicada()$fechas, riegos=lamina_aplicada()$riegos)
      result <- base::merge(df1,df2, all.x=T)
      bp <- barplot(result$riegos, names.arg=result$fechas, col="light blue")
      text(bp, result$riegos-0.5, labels=as.character( round(result$riegos, 2)), xpd=TRUE)
    }
  })
  
  
  output$downloadRiego <- downloadHandler(
    filename = function() {
      paste("INTA-Meteo-", input$start1, "-", input$stop1, ".csv", sep="")
    },
    content = function(file) {
      write.csv(datos.WS()$hourly, file)
    }
  )
  
})

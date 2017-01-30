library(shiny)
library(water)
library(RMySQL)

connRiego = dbConnect(MySQL(), user='shiny', password='561234', dbname='RIEGO',
                        host='172.21.116.72')
datos.goteo <- dbGetQuery(connRiego, "SELECT * FROM GOTEO")
datos.superficial <- dbGetQuery(connRiego, "SELECT * FROM SUPERFICIAL")
datos.kc <- dbGetQuery(connRiego, "SELECT * FROM KC")
dbDisconnect(connRiego)

listaParcelas <- list('Goteo' = paste(datos.goteo$N_PARCELA, datos.goteo$PARCELA), "Superficie" = paste(datos.superficial$N_PARCELA, datos.superficial$PARCELA))

listaKc <- datos.kc$Nombre


navbarPage("Riego EEA Mendoza!",
           tabPanel("Agrometeorología",
                    sidebarLayout(
                      sidebarPanel(
                        dateInput("start1", "Desde:", value = NULL, min = NULL, max = NULL,
                                  format = "yyyy-mm-dd", startview = "month", weekstart = 0,
                                  language = "es", width = NULL),
                        dateInput("stop1", "Hasta:", value = NULL, min = NULL, max = NULL,
                                  format = "yyyy-mm-dd", startview = "month", weekstart = 0,
                                  language = "es", width = NULL),
                        checkboxInput("todos.los.datos", "Todos los datos", FALSE),
                        downloadButton("downloadWS", "Descargar")
                      ),
                      
                      # Show a plot of the generated distribution
                      mainPanel(
                        #tableOutput("table")
                        plotOutput("WSplot")
                      )
                    )  
           ),
           tabPanel("Evapotranspiración",
                    sidebarLayout(
                      sidebarPanel(
                        dateInput("start2", "Desde:", value = NULL, min = NULL, max = NULL,
                                  format = "yyyy-mm-dd", startview = "month", weekstart = 0,
                                  language = "es", width = NULL),
                        dateInput("stop2", "Hasta:", value = NULL, min = NULL, max = NULL,
                                  format = "yyyy-mm-dd", startview = "month", weekstart = 0,
                                  language = "es", width = NULL),
                        selectInput("Parcela1", "Parcela:", c("", listaParcelas), selected = NULL, multiple = FALSE,
                                    selectize = TRUE, width = NULL, size = NULL),
                        selectInput("Kc", "Kc:", listaKc, selected = NULL, multiple = FALSE,
                                    selectize = TRUE, width = NULL, size = NULL),
                        sliderInput("Kc_medio", "Kc medio:", value = 0,  min = 0, max = 1.3, step = 0.01)
                      ),
                      
                      # Show a plot of the generated distribution
                      mainPanel(
                       textOutput("ETo_acum"),
                       plotOutput("EToplot"),
                       plotOutput("ETcplot")
                      )
                    )  
           ),
           tabPanel("Riego",
                    sidebarLayout(
                      sidebarPanel(
                        dateInput("start3", "Desde:", value = NULL, min = NULL, max = NULL,
                                  format = "yyyy-mm-dd", startview = "month", weekstart = 0,
                                  language = "es", width = NULL),
                        dateInput("stop3", "Hasta:", value = NULL, min = NULL, max = NULL,
                                  format = "yyyy-mm-dd", startview = "month", weekstart = 0,
                                  language = "es", width = NULL),
                        selectInput("Parcela2", "Parcela:", c("", listaParcelas), selected = NULL, multiple = FALSE,
                                    selectize = TRUE, width = NULL, size = NULL)
                      ),
                      
                      # Show a plot of the generated distribution
                      mainPanel(
                        textOutput("Lam_acum"),
                        textOutput("ppT_acum"),
                        textOutput("ppE_acum"),
                        plotOutput("riegoPlot")
                        # #tableOutput("table")
                       
                      )
                    )  
           )
           
) #END
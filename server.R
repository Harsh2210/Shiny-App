#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(data.table)
library(RCurl)
library(neuralnet)
library(psych)
library(caret)

dataset <- read.csv("shinyData.csv",sep = ',')
model <- readRDS("model.rds")
#softplus <- function(x) log(1+exp(x))
#model <- neuralnet(treatment~., data = dataset,stepmax=1e+08,threshold = 0.5,rep = 1,linear.output = FALSE, act.fct = softplus)

shinyServer(function(input, output, session) {
    autoInvalidate <- reactiveTimer(10000)
    observe({
        autoInvalidate()
        cat(".")
    })
    
    # Input Data
    datasetInput <- reactive({  
        
        # outlook,temperature,humidity,windy,play
        df <- data.frame(
            Value = as.numeric(c(input$Age,
                                 input$Gender,
                                 input$self_employed,
                                 input$family_history,
                                 input$work_interfere,
                                 input$no_employees,
                                 input$remote_work,
                                 input$tech_company,
                                 input$benefits,
                                 input$care_options,
                                 input$wellness_program,
                                 input$seek_help,
                                 input$anonymity,
                                 input$leave,
                                 input$mental_health_consequence,
                                 input$phys_health_consequence,
                                 input$coworkers,
                                 input$supervisor,
                                 input$mental_health_interview,
                                 input$phys_health_interview,
                                 input$mental_vs_physical,
                                 input$obs_consequence)),
            stringsAsFactors = FALSE)
        df <- transpose(df)
        names <- c("Age",
                   "Gender",
                   "self_employed",
                   "family_history",
                   "work_interfere",
                   "no_employees",
                   "remote_work",
                   "tech_company",
                   "benefits",
                   "care_options",
                   "wellness_program",
                   "seek_help","anonymity","leave","mental_health_consequence",
                   "phys_health_consequence","coworkers","supervisor","mental_health_interview",
                   "phys_health_interview","mental_vs_physical","obs_consequence")         
        colnames(df) <- names
        #play <- "play"
        #df <- rbind(df, play)
        #input <- transpose(df)
        #write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
        
        #test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
        
        #test$outlook <- factor(test$outlook, levels = c("overcast", "rainy", "sunny"))
        
        #Output <- predict(model,df)
        #pred_nn <- data.frame(Prediction=as.factor(ifelse(Output>1.5, "You Sought treatment", "You Should Seek Treatment")))
        
        #print(pred_nn)
        
        nn_predictions <- compute(model, df)
        net_results <- nn_predictions$net.result
        pred_nn <- data.frame(Prediction=as.factor(ifelse(net_results > 1.5, "You Sought treatment", "You Should Seek Treatment")))
        print(pred_nn)
        
    })
    
    # Status/Output Text Box
    output$contents <- renderPrint({
        if (input$submitbutton>0) { 
            isolate("Calculation complete.") 
        } else {
            return("Server is ready for calculation.")
        }
    })
    
    # Prediction results table
    output$tabledata <- renderTable({
        if (input$submitbutton>0) { 
            isolate(datasetInput()) 
        } 
    })
    
})
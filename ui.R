#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(data.table)
library(RCurl)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("united"),
                  
                  # Page header
                  headerPanel('Mental Health Survey Form'),
                  
                  # Input values
                  sidebarPanel(
                      HTML("<h3>Input parameters</h3>"),
                      
                      selectInput("Gender", label = "Gender:", 
                                  choices = list("male" = 2, "female" = 1, "queer" = 3), 
                                  selected = "male"),
                      sliderInput("Age", "Age:",
                                  min = 17, max = 60,
                                  value = 30),
                      selectInput("self_employed", label = "Self-Employed:", 
                                  choices = list("yes" = 2, "no" = 1), 
                                  selected = "no"),
                      selectInput("family_history", label = "Family-history:", 
                                  choices = list("yes" = 2, "no" = 1), 
                                  selected = "no"),
                      selectInput("work_interfere", label = "work_interfere:", 
                                  choices = list("Never" = 1, "Often" = 2,"Rarely"=3,"Sometimes"=4), 
                                  selected = "Never"),
                      selectInput("no_employees", label = "no_employees:", 
                                  choices = list("1-5" = 1, "100-500" = 2,"26-100"=3,"500-1000"=4,
                                                 "6-25"=5,"More than 1000"=6), 
                                  selected = "26-100"),
                      selectInput("remote_work", label = "remote_work:", 
                                  choices = list("yes" = 2, "no" = 1), 
                                  selected = "no"),
                      selectInput("tech_company", label = "tech_company:", 
                                  choices = list("yes" = 2, "no" = 1), 
                                  selected = "no"),
                      selectInput("benefits", label = "benefits:", 
                                  choices = list("yes" = 3, "no" = 2,"Don't know"=1), 
                                  selected = "no"),
                      selectInput("care_options", label = "care_options:", 
                                  choices = list("yes" = 3, "no" = 1,"Not sure"=2), 
                                  selected = "no"),
                      selectInput("wellness_program", label = "wellness_program:", 
                                  choices = list("yes" = 3, "no" = 2,"Don't know"=1), 
                                  selected = "no"),
                      selectInput("seek_help", label = "seek_help:", 
                                  choices = list("yes" = 3, "no" = 2,"Don't know"=1), 
                                  selected = "no"),
                      selectInput("anonymity", label = "anonymity:", 
                                  choices = list("yes" = 3, "no" = 2,"Don't know"=1), 
                                  selected = "no"),
                      selectInput("leave", label = "leave:", 
                                  choices = list("Very easy" = 5, "Very difficult" = 4,
                                                 "Somewhat easy"=3,"Somewhat difficult"=2,"Don't know"=1), 
                                  selected = "Don't know"),
                      selectInput("mental_health_consequence", label = "mental_health_consequence:", 
                                  choices = list("yes" = 3, "no" = 2,"Maybe"=1), 
                                  selected = "no"),
                      selectInput("phys_health_consequence", label = "phys_health_consequence:", 
                                  choices = list("yes" = 3, "no" = 2,"Maybe"=1), 
                                  selected = "no"),
                      selectInput("coworkers", label = "coworkers:", 
                                  choices = list("yes" = 3, "no" = 1,"Some of them"=2), 
                                  selected = "no"),
                      selectInput("supervisor", label = "supervisor:", 
                                  choices = list("yes" = 3, "no" = 1,"Some of them"=2), 
                                  selected = "no"),
                      selectInput("mental_health_interview", label = "mental_health_interview:", 
                                  choices = list("yes" = 3, "no" = 2,"Maybe"=1), 
                                  selected = "no"),
                      selectInput("phys_health_interview", label = "phys_health_interview:", 
                                  choices = list("yes" = 3, "no" = 2,"Maybe" = 1), 
                                  selected = "no"),
                      selectInput("mental_vs_physical", label = "mental_vs_physical:", 
                                  choices = list("yes" = 3, "no" = 2,"Don't know" = 1), 
                                  selected = "no"),
                      selectInput("obs_consequence", label = "obs_consequence:", 
                                  choices = list("yes" = 2, "no" = 1), 
                                  selected = "no"),
                      
                      
                      actionButton("submitbutton", "Submit", class = "btn btn-primary")
                  ),
                  
                  mainPanel(
                      tags$label(h3('Status/Output')), # Status/Output Text Box
                      verbatimTextOutput('contents'),
                      tableOutput('tabledata') # Prediction results table
                      
                  )
))

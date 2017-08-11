library(shiny)
library(DBI)
library(RMySQL)
library(water)
library(yaml)

config = yaml.load_file("config.yml")
if(config$general$language != "SPA"){warning("Language not supported yet")}
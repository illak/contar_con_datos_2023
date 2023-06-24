library(tidyverse)

datos <- read_csv("data/museos_datosabiertos.csv")


glimpse(datos)

datos %>% 
  select(nombre)
  
# Análisis

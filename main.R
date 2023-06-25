library(tidyverse)

datos <- read_csv("data/museos_datosabiertos.csv")


glimpse(datos)


machine <- "#061939"
human <- "#e25470"
monochromeR::generate_palette(machine, 
                              blend_colour = human, 
                              n_colours = 6, 
                              view_palette = TRUE) %>% as_tibble()

datos_gmap_url <- datos %>% 
  mutate(gmap_url = str_glue("https://www.google.com/maps?q={Latitud},{Longitud}")) %>% 
  mutate(categoria_antig = case_when(
    between(año_inauguracion, 1820, 1859) ~ "1820-1859",
    between(año_inauguracion, 1860, 1899) ~ "1860-1899",
    between(año_inauguracion, 1900, 1939) ~ "1900-1939",
    between(año_inauguracion, 1940, 1979) ~ "1940-1979",
    between(año_inauguracion, 1980, 2019) ~ "1989-2019",
    año_inauguracion > 2020 ~ "2020 en adelante",
    TRUE ~ "sin datos"
  )) %>% 
  mutate(categoria_antig = as.factor(categoria_antig))
  
write_csv(datos_gmap_url, "data/museos_abiertos_updated.csv")

# Análisis


datos_gmap_url %>% 
  select(nombre, provincia, localidad, año_inauguracion, actualizacion) %>% 
  filter(!is.na(año_inauguracion)) %>% 
  filter(año_inauguracion > 0) %>% 
  arrange(año_inauguracion) %>% 
  View()

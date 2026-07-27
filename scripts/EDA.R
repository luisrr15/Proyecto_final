###############################################################
# PROYECTO FINAL
# RAMOS ROSALES LUIS ALBERTO
# Análisis Exploratorio de Datos (EDA)
# Base de datos:
# EP_Distribucion_Geografica_Gasto.csv
# Fuente: Ministerio de Economía y Finanzas (MEF)
###############################################################

###############################################################
# 1. CARGA DE LIBRERÍAS
###############################################################

install.packages("sf")
install.packages("geodata")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("viridis")
install.packages("patchwork")
install.packages("stringi")
library(patchwork)
library(tidyverse)
library(sf)
library(geodata)
library(ggplot2)
library(dplyr)
library(viridis)
library(stringi)
###############################################################
# 2. IMPORTACIÓN DE LA BASE DE DATOS
###############################################################

gasto <- read.csv(
  "data/EP_Distribucion_Geografica_Gasto.csv",
  stringsAsFactors = FALSE
)

###############################################################
# 3. EXPLORACIÓN INICIAL DE LOS DATOS
###############################################################

# Directorio de trabajo
getwd()

# Primeras observaciones
head(gasto)

# Últimas observaciones
tail(gasto)

# Dimensiones de la base
dim(gasto)

# Estructura de la base
str(gasto)

# Nombre de las variables
names(gasto)

###############################################################
# 4. LIMPIEZA Y PREPARACIÓN DE DATOS
###############################################################

# Renombrar variables

gasto <- gasto %>%
  rename(
    anio = ANO_EJE,
    mes = MES_EJE,
    nivel_gobierno = NIVEL_GOBIERNO_NOMBRE,
    nivel = NIVEL,
    nombre_nivel = NIVEL_NOMBRE,
    pliego = PLIEGO,
    nombre_pliego = PLIEGO_NOMBRE,
    codigo_departamento = DEPARTAMENTO_AP4,
    departamento = DEPARTAMENTO_AP4_NOMBRE,
    pim = PIM,
    ejecucion = EJECUCIÓN
  )

# Crear nueva variable

gasto <- gasto %>%
  mutate(
    porcentaje_ejecucion = (ejecucion / pim) * 100
  )
# Base solo para el mapa
gasto_mapa <- gasto %>%
  filter(departamento != "EXTERIOR")

# Agrupación por departamento
ejecucion_departamento <- gasto_mapa %>%
  group_by(departamento) %>%
  summarise(
    porcentaje_promedio = mean(porcentaje_ejecucion, na.rm = TRUE)
  )
###############################################################
# 5. CALIDAD DE LOS DATOS
###############################################################

# Valores faltantes
colSums(is.na(gasto))

# Registros duplicados
sum(duplicated(gasto))

###############################################################
# 6. EXPLORACIÓN DE VARIABLES
###############################################################

# Tipos de datos
sapply(gasto, class)

# Frecuencia por nivel de gobierno
table(gasto$nivel_gobierno)

# Frecuencia por año
table(gasto$anio)

# Frecuencia por mes
table(gasto$mes)

###############################################################
# 7. ESTADÍSTICAS DESCRIPTIVAS
###############################################################

# Resumen general
summary(gasto)

# Resumen de variables numéricas
summary(gasto[, c("pim",
                  "ejecucion",
                  "porcentaje_ejecucion")])

# Promedio del PIM
mean(gasto$pim)

# Promedio de la ejecución
mean(gasto$ejecucion)

# Promedio del porcentaje de ejecución
mean(gasto$porcentaje_ejecucion)

# Medianas
median(gasto$pim)
median(gasto$ejecucion)
median(gasto$porcentaje_ejecucion)

# Valores mínimos
min(gasto$pim)
min(gasto$ejecucion)
min(gasto$porcentaje_ejecucion)

# Valores máximos
max(gasto$pim)
max(gasto$ejecucion)
max(gasto$porcentaje_ejecucion)

###############################################################
# 8. RESUMEN POR NIVEL DE GOBIERNO
###############################################################

resumen_nivel <- gasto %>%
  group_by(nivel_gobierno) %>%
  summarise(
    promedio_pim = mean(pim),
    promedio_ejecucion = mean(ejecucion),
    promedio_porcentaje = mean(porcentaje_ejecucion)
  )

resumen_nivel

###############################################################
# 9. RESUMEN PARA VISUALIZACIONES
###############################################################

resumen_nivel <- gasto %>%
  group_by(nivel_gobierno) %>%
  summarise(
    total_pim = sum(pim),
    total_ejecucion = sum(ejecucion),
    promedio_porcentaje = mean(porcentaje_ejecucion),
    .groups = "drop"
  )

resumen_nivel

###############################################################
# 10. GRÁFICO 1
# Presupuesto (PIM) por nivel de gobierno
###############################################################

grafico1 <- ggplot(resumen_nivel,
                   aes(x = nivel_gobierno,
                       y = total_pim,
                       fill = nivel_gobierno)) +
  geom_col() +
  labs(
    title = "Presupuesto Institucional Modificado por nivel de gobierno",
    subtitle = "Distribución geográfica del gasto - Perú 2025",
    x = "Nivel de gobierno",
    y = "PIM (S/)",
    fill = "Nivel de gobierno"
  ) +
  theme_minimal() +
  coord_flip()

grafico1

ggsave(
  "figures/grafico_pim.png",
  grafico1,
  width = 8,
  height = 6
)
###############################################################
# 11. GRÁFICO 2
# Ejecución del gasto por nivel de gobierno
###############################################################

grafico2 <- ggplot(resumen_nivel,
                   aes(x = nivel_gobierno,
                       y = total_ejecucion,
                       fill = nivel_gobierno)) +
  geom_col() +
  labs(
    title = "Ejecución del gasto por nivel de gobierno",
    subtitle = "Distribución geográfica del gasto - Perú 2025",
    x = "Nivel de gobierno",
    y = "Ejecución (S/)",
    fill = "Nivel de gobierno"
  ) +
  theme_minimal() +
  coord_flip()

grafico2

ggsave(
  "figures/grafico_ejecucion.png",
  grafico2,
  width = 8,
  height = 6
)

###############################################################
# 12. GRÁFICO 3
# Porcentaje promedio de ejecución
###############################################################

grafico3 <- ggplot(resumen_nivel,
                   aes(x = nivel_gobierno,
                       y = promedio_porcentaje,
                       fill = nivel_gobierno)) +
  geom_col() +
  labs(
    title = "Porcentaje promedio de ejecución presupuestal",
    subtitle = "Distribución geográfica del gasto - Perú 2025",
    x = "Nivel de gobierno",
    y = "Porcentaje (%)",
    fill = "Nivel de gobierno"
  ) +
  theme_minimal() +
  coord_flip()

grafico3

ggsave(
  "figures/grafico_porcentaje.png",
  grafico3,
  width = 8,
  height = 6
)

###############################################################
# 13. GRÁFICO 4
#EJECUCIÓN PRESUPUESTAL POR DEPARTAMENTO
###############################################################

peru <- geodata::gadm(
  country = "PER",
  level = 1,
  path = "mapa_peru"
)
# Nombres 
peru <- st_as_sf(peru)
ejecucion_departamento$departamento <- tools::toTitleCase(
  tolower(ejecucion_departamento$departamento)
)
peru$nombre_limpio <- stri_trans_general(
  peru$NAME_1,
  "Latin-ASCII"
)

peru$nombre_limpio <- toupper(peru$nombre_limpio)
ejecucion_departamento$nombre_limpio <- stri_trans_general(
  ejecucion_departamento$departamento,
  "Latin-ASCII"
)

ejecucion_departamento$nombre_limpio <- toupper(
  ejecucion_departamento$nombre_limpio
)
# Corrección Callao
ejecucion_departamento$nombre_limpio[
  ejecucion_departamento$nombre_limpio == "PROV CONSTIT DEL CALLAO"
] <- "CALLAO"

# Corrección Lima
peru <- peru %>%
  filter(nombre_limpio != "LIMA PROVINCE")
ejecucion_departamento$nombre_limpio[
  ejecucion_departamento$nombre_limpio == "LIMA PROVINCE"
] <- "LIMA"
# Unir información
mapa_ejecucion <- peru %>%
  left_join(
    ejecucion_departamento,
    by = "nombre_limpio"
  )

# GRÁFICO FINAL
mapa_final <- ggplot(mapa_ejecucion) +
  geom_sf(aes(fill = porcentaje_promedio),
          color = "white") +
  scale_fill_viridis(
    option = "C",
    name = "% Ejecución"
  ) +
  theme_minimal() +
  labs(
    title = "Porcentaje de ejecución presupuestal por departamento",
    subtitle = "Perú",
    caption = "Fuente: Elaboración propia"
  )
mapa_final

ggsave(
  filename = "figures/mapa_porcentaje_ejecucion_departamental.png",
  plot = mapa_final,
  width = 10,
  height = 8,
  dpi = 300
)
###############################################################
# 13. COLLAGE DE GRÁFICOS
###############################################################

collage <- grafico3 + mapa_final +
  plot_layout(ncol=2)

collage

ggsave(
  "figures/collage_graficos.png",
  collage,
  width=14,
  height=7,
  dpi=300
)

###############################################################
# 14. ANALISIS FINAL
###############################################################

analisis_final <- gasto %>%
  group_by(departamento) %>%
  summarise(
    presupuesto_total = sum(pim),
    ejecucion_promedio = mean(porcentaje_ejecucion)
  ) %>%
  arrange(desc(presupuesto_total))


analisis_final

# ============================================================
# 04_analisis_final.R
# Análisis final: Ejecución presupuestal por departamento
# Fuente: Ministerio de Economía y Finanzas (MEF)
# ============================================================


# ------------------------------------------------------------
# 1. Cargar paquetes
# ------------------------------------------------------------

library(tidyverse)
library(ggplot2)


# ------------------------------------------------------------
# 2. Importar base de datos
# ------------------------------------------------------------

gasto <- read.csv(
  "data/EP_Distribucion_Geografica_Gasto.csv",
  stringsAsFactors = FALSE,
  check.names = FALSE
)


# ------------------------------------------------------------
# 3. Limpieza y preparación
# ------------------------------------------------------------


# Crear porcentaje de ejecución

gasto <- gasto %>%
  mutate(
    porcentaje_ejecucion = (`EJECUCIÓN` / PIM) * 100
  )


# Eliminar registros que no corresponden a departamentos

gasto <- gasto %>%
  filter(DEPARTAMENTO_AP4_NOMBRE != "EXTERIOR")



# ------------------------------------------------------------
# 4. Pregunta de análisis
# ------------------------------------------------------------

# Pregunta:
# ¿Qué departamentos presentan mayores niveles de eficiencia
# en la ejecución presupuestal?


# ------------------------------------------------------------
# 5. Análisis por departamento
# ------------------------------------------------------------

analisis_departamental <- gasto %>%
  group_by(DEPARTAMENTO_AP4_NOMBRE) %>%
  summarise(
    
    porcentaje_promedio = mean(
      porcentaje_ejecucion,
      na.rm = TRUE
    ),
    
    presupuesto_total = sum(
      PIM,
      na.rm = TRUE
    ),
    
    gasto_ejecutado = sum(
      `EJECUCIÓN`,
      na.rm = TRUE
    )
    
  ) %>%
  arrange(desc(porcentaje_promedio))


# Ver resultados

View(analisis_departamental)



# ------------------------------------------------------------
# 6. Top 10 departamentos con mayor ejecución
# ------------------------------------------------------------

top10 <- analisis_departamental %>%
  slice_head(n = 10)


top10



# ------------------------------------------------------------
# 7. Bottom 10 departamentos
# ------------------------------------------------------------

bottom10 <- analisis_departamental %>%
  slice_tail(n = 10)


bottom10



# ------------------------------------------------------------
# 8. Gráfico final: Ranking de departamentos
# ------------------------------------------------------------

grafico_final <- ggplot(
  top10,
  aes(
    x = reorder(
      DEPARTAMENTO_AP4_NOMBRE,
      porcentaje_promedio
    ),
    y = porcentaje_promedio
  )
) +
  geom_col() +
  geom_text(
    aes(label = paste0(round(porcentaje_promedio,1), "%")),
    hjust = -0.1,
    size = 4
  ) +
  coord_flip() +
  scale_y_continuous(
    limits = c(0, max(top10$porcentaje_promedio) + 10)
  ) +
  labs(
    title = "Departamentos con mayor ejecución presupuestal",
    subtitle = "Ranking de los 10 departamentos con mayor porcentaje promedio ejecutado",
    x = NULL,
    y = "Ejecución presupuestal (%)",
    caption = "Fuente: Ministerio de Economía y Finanzas (MEF)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(
      size = 16,
      face = "bold"
    ),
    plot.subtitle = element_text(
      size = 12
    )
  )


# Mostrar gráfico

grafico_final
# ------------------------------------------------------------
# 9. Guardar gráfico final
# ------------------------------------------------------------

ggsave(
  filename = "figures/fig03_top10_ejecucion_departamentos.png",
  plot = grafico_final,
  width = 10,
  height = 7,
  dpi = 300
)



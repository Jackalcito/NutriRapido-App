# ============================================================
# DIAGRAMA DEL SISTEMA - NUTRIRÁPIDO
# Curso: Análisis y Diseño de Sistemas - UNICA 2026
# ============================================================

# install.packages("DiagrammeR")
library(DiagrammeR)

grViz("
digraph NutriRapido {

  graph [layout = dot, rankdir = TB, bgcolor = '#0A0E1A',
         fontname = Arial, fontcolor = white,
         label = 'DIAGRAMA DEL SISTEMA — NUTRIRÁPIDO\\nAlimentación saludable para estudiantes universitarios de Ica',
         labelloc = t, labeljust = c, fontsize = 14]

  node [fontname = Arial, fontsize = 11, style = filled, shape = box, fontcolor = white]

  # ENTRADA
  USUARIO [label = 'USUARIO\\n(Estudiante universitario)',
           fillcolor = '#4F46E5', shape = oval]

  # DATOS
  BD [label = 'BASE DE DATOS\\n─────────────────\\nINGREDIENTES (30)\\nRECETAS (15)\\nUSUARIOS\\nPLAN SEMANAL\\nREGISTRO\\nLISTA COMPRAS\\nRECETA_INGREDIENTE',
      fillcolor = '#1E2535', shape = box]

  MINSA [label = 'MINSA/CENAN 2025\\nTablas Peruanas de\\nComposición de Alimentos',
         fillcolor = '#1E2535', shape = cylinder]

  # MÓDULOS
  IMC [label = 'MÓDULO IMC\\nHarris-Benedict\\nVolumen/Mantener/Definir',
       fillcolor = '#7C3AED']

  INGREDIENTES [label = 'MÓDULO INGREDIENTES\\nEvaluación nutricional\\nFactor de cocción',
                fillcolor = '#2563EB']

  RECETAS [label = 'MÓDULO RECETAS\\nFiltro por tiempo\\ny método de cocción',
           fillcolor = '#0891B2']

  PLAN [label = 'PLAN SEMANAL\\nBatch cooking\\n5 días',
        fillcolor = '#059669']

  COMPRAS [label = 'LISTA DE COMPRAS\\nPrecios mercado Ica\\nCosto semanal S/.',
           fillcolor = '#D97706']

  REGISTRO [label = 'MI REGISTRO\\nHistorial calorías\\nEstadísticas diarias',
            fillcolor = '#DC2626']

  # SALIDA
  DECISION [label = 'TOMA DE DECISIONES\\nAlimentación saludable\\nrápida y económica',
            fillcolor = '#4F46E5', shape = oval]

  # CONEXIONES
  MINSA    -> BD        [color = '#6366F1', label = 'datos nutricionales', fontcolor = '#94A3B8', fontsize = 9]
  USUARIO  -> IMC       [color = '#7C3AED', label = 'peso/talla/edad', fontcolor = '#94A3B8', fontsize = 9]
  USUARIO  -> INGREDIENTES [color = '#2563EB', label = 'ingredientes\\ndisponibles', fontcolor = '#94A3B8', fontsize = 9]
  BD       -> INGREDIENTES [color = '#2563EB']
  BD       -> RECETAS   [color = '#0891B2']
  BD       -> PLAN      [color = '#059669']
  BD       -> COMPRAS   [color = '#D97706']
  IMC      -> DECISION  [color = '#4F46E5']
  INGREDIENTES -> DECISION [color = '#4F46E5']
  RECETAS  -> PLAN      [color = '#059669']
  PLAN     -> COMPRAS   [color = '#D97706']
  PLAN     -> REGISTRO  [color = '#DC2626']
  REGISTRO -> DECISION  [color = '#4F46E5']
  COMPRAS  -> DECISION  [color = '#4F46E5']

  subgraph cluster_bd {
    label = 'Fuentes de datos'
    fontcolor = '#94A3B8'
    fontsize = 11
    style = dashed
    color = '#334155'
    MINSA; BD
  }

  subgraph cluster_modulos {
    label = 'Módulos de la App Shiny'
    fontcolor = '#94A3B8'
    fontsize = 11
    style = dashed
    color = '#334155'
    IMC; INGREDIENTES; RECETAS; PLAN; COMPRAS; REGISTRO
  }
}
")

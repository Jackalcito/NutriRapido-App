# NutriRápido

### Alimentación saludable para estudiantes universitarios de Ica

**Universidad Nacional "San Luis Gonzaga" — Facultad de Ciencias**  
**Curso: Análisis y Diseño de Sistemas | Docente: Mag. Elmer Leonidas Landeo Alfaro**  
**Ica, Perú | 2026-I**

> *"Come sano. Sin perder tiempo. Sin gastar de más."*

---

## 1. DESCRIPCIÓN DEL PROYECTO

**NutriRápido** surge como respuesta a una problemática real de los estudiantes universitarios de Ica: la falta de tiempo para preparar comidas saludables durante la vida académica. Muchos estudiantes recurren a comida poco nutritiva por desconocer cómo planificar su alimentación con los ingredientes que ya tienen en casa.

La solución es una aplicación web interactiva desarrollada en **R Shiny** que permite calcular el IMC, evaluar la composición nutricional de un plato según los ingredientes disponibles y el método de cocción, filtrar recetas rápidas, planificar la semana con batch cooking y gestionar una lista de compras con precios del mercado de Ica.

---

## 2. BASE DE DATOS

Base de datos con **7 tablas relacionales** basada en las Tablas Peruanas de Composición de Alimentos — MINSA/CENAN 2025:

| Tabla | Registros | Descripción |
|-------|-----------|-------------|
| ingredientes | 30 | Alimentos con macronutrientes y precios en soles |
| recetas | 15 | Platos rápidos con tiempo y método de cocción |
| receta_ingrediente | 45 | Relación entre recetas e ingredientes |
| usuarios | 4 | Datos físicos y objetivos nutricionales |
| plan_semanal | 15 | Comidas planificadas de lunes a viernes |
| registro_comidas | 6 | Historial de calorías consumidas |
| lista_compras | 10 | Productos con precios del mercado de Ica |

---

## 3. FUNCIONALIDADES DE LA APP

| Módulo | Descripción |
|--------|-------------|
| 📊 IMC | Calcula IMC con Harris-Benedict. Determina si necesitas volumen, mantenimiento o definición |
| 🥦 Mis ingredientes | Evalúa la proporción nutricional del plato según ingredientes y método de cocción |
| 🍳 Recetas rápidas | Filtra por tiempo disponible (5-60 min) y método de cocción |
| 📅 Plan semanal | Batch cooking de lunes a viernes con consejos de ahorro de tiempo |
| 🛒 Lista de compras | Productos con cantidades y precios estimados del mercado de Ica |
| 📋 Mi registro | Historial de calorías consumidas con estadísticas descriptivas |

### Factor de cocción
La app ajusta automáticamente las calorías según el método:

| Método | Factor | Efecto |
|--------|--------|--------|
| Sancochar | 0.95 | -5% calorías |
| Hornear | 0.90 | -10% calorías |
| Freír | 1.25 | +25% calorías |
| Sin cocción | 1.00 | Sin cambio |

---

## 4. TECNOLOGÍAS Y LIBRERÍAS

| Componente | Tecnología |
|------------|------------|
| Lenguaje | `R 4.5.3` |
| Framework web | `Shiny` |
| Visualización | `ggplot2` |
| Interfaz | `CSS Dark Mode` personalizado |
| Base de datos | `CSV / SQLite` |
| Fuente de datos | `MINSA/CENAN 2025` |

---

## 5. ESTRUCTURA DEL REPOSITORIO

```
NutriRapido-App/
├── app.R                      # App principal R Shiny
├── index.html                 # Página web del proyecto
├── diagrama_nutri.R           # Diagrama del sistema con DiagrammeR
├── Informe_NutriRapido.docx   # Informe académico completo
├── ingredientes.csv           # Base de datos ingredientes
├── recetas.csv                # Base de datos recetas
├── receta_ingrediente.csv     # Relación recetas-ingredientes
├── usuarios.csv               # Datos de usuarios
├── plan_semanal.csv           # Plan de comidas semanal
├── registro_comidas.csv       # Historial de comidas
├── lista_compras.csv          # Lista de compras semanal
└── www/
    └── style.css              # Estilos modo oscuro
```

---

## 6. INSTALACIÓN Y USO

```r
# 1. Instalar dependencias
install.packages(c("shiny", "ggplot2"))

# 2. Establecer directorio
setwd("D:/NutriRapido")

# 3. Ejecutar la app
shiny::runApp("app.R")

## 🌐 App en línea
Accede sin instalar nada: https://jackalcitouwu.shinyapps.io/nutrirapido/
```

---

## 7. EQUIPO DE PROYECTO

| Integrante | Rol |
|------------|-----|
| Jack Ccencho | Desarrollo App Shiny y Análisis Estadístico |
| Adrian Oviedo | Recolección y Validación de Datos |
| Avidaish Luna | Documentación y Redacción del Informe |
| Jhanker Chaupin | Diseño de Base de Datos y Modelado del Sistema |

**Período académico:** 2026-I

---

*Fuente de datos: [MINSA/CENAN — Tablas Peruanas de Composición de Alimentos 2025](https://www.ins.gob.pe)*  
*Curso: Análisis y Diseño de Sistemas | Docente: Mag. Elmer Leonidas Landeo Alfaro | UNICA 2026*

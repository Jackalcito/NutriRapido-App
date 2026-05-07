# ============================================================
# APP SHINY - NUTRIRÁPIDO
# Alimentación saludable para estudiantes universitarios de Ica
# Curso: Análisis y Diseño de Sistemas - UNICA 2026
# Equipo: Jack Ccencho, Adrian Oviedo, Avidaish Luna, Jhanker Chaupin
# ============================================================

# install.packages(c("shiny", "ggplot2"))
library(shiny)
library(ggplot2)

# CARGAR BASE DE DATOS
ingredientes     <- read.csv("ingredientes.csv",      stringsAsFactors=FALSE)
recetas          <- read.csv("recetas.csv",           stringsAsFactors=FALSE)
receta_ing       <- read.csv("receta_ingrediente.csv",stringsAsFactors=FALSE)
plan_semanal     <- read.csv("plan_semanal.csv",      stringsAsFactors=FALSE)
lista_compras    <- read.csv("lista_compras.csv",     stringsAsFactors=FALSE)
registro_comidas <- read.csv("registro_comidas.csv",  stringsAsFactors=FALSE)

factor_coccion <- c("Sancochar"=0.95,"Hornear"=0.90,"Freír"=1.25,"Sin cocción"=1.00)

ui <- fluidPage(
  tags$head(tags$link(rel="stylesheet", type="text/css", href="style.css")),
  titlePanel(div(
    h2("🥗 NutriRápido — Alimentación saludable para estudiantes"),
    h5("Ica, Perú | MINSA/CENAN 2025 | UNICA 2026")
  )),
  hr(),
  fluidRow(
    column(2,div(style="background:#1F4E79;color:white;padding:12px;border-radius:8px;text-align:center;",h5("Ingredientes"),h3("30"),p("disponibles"))),
    column(2,div(style="background:#E63946;color:white;padding:12px;border-radius:8px;text-align:center;",h5("Recetas"),h3("15"),p("rápidas"))),
    column(2,div(style="background:#2A9D8F;color:white;padding:12px;border-radius:8px;text-align:center;",h5("Mín tiempo"),h3("5"),p("minutos"))),
    column(2,div(style="background:#F4A261;color:white;padding:12px;border-radius:8px;text-align:center;",h5("Métodos"),h3("4"),p("de cocción"))),
    column(2,div(style="background:#6B7280;color:white;padding:12px;border-radius:8px;text-align:center;",h5("Plan"),h3("5"),p("días"))),
    column(2,div(style="background:#457B9D;color:white;padding:12px;border-radius:8px;text-align:center;",h5("Objetivo"),h3("IMC"),p("personalizado")))
  ),
  br(),
  tabsetPanel(

    # PESTAÑA 1: IMC
    tabPanel("📊 IMC",br(),
      fluidRow(
        column(4,
          h4("Tus datos",style="color:#1F4E79;"),
          textInput("nombre","Tu nombre:",value="Jack"),
          numericInput("peso_imc","Peso (kg):",value=68,min=30,max=200),
          numericInput("talla_imc","Talla (cm):",value=172,min=100,max=220),
          numericInput("edad_imc","Edad (años):",value=20,min=15,max=60),
          selectInput("sexo_imc","Sexo:",choices=c("Masculino","Femenino")),
          selectInput("actividad_imc","Actividad:",choices=c("Sedentario","Ligero","Moderado","Intenso")),
          br(),
          actionButton("calcular_imc","📊 Calcular IMC",
            style="background:#1F4E79;color:white;width:100%;padding:10px;border:none;border-radius:6px;font-size:15px;")
        ),
        column(8,
          h4("Resultado",style="color:#1F4E79;"),
          verbatimTextOutput("resultado_imc"),
          plotOutput("grafico_imc",height="250px")
        )
      )
    ),

    # PESTAÑA 2: MIS INGREDIENTES
    tabPanel("🥦 Mis ingredientes",br(),
      fluidRow(
        column(4,
          h4("¿Qué tienes en casa?",style="color:#1F4E79;"),
          selectInput("cat_ing","Categoría:",choices=c("Todos",unique(ingredientes$categoria))),
          selectInput("ing_sel","Ingrediente:",choices=NULL),
          numericInput("gramos_ing","Cantidad (gramos):",value=150,min=1,max=2000),
          selectInput("metodo_ing","Método de cocción:",choices=c("Sancochar","Hornear","Freír","Sin cocción")),
          br(),
          actionButton("agregar_ing","➕ Agregar",
            style="background:#2A9D8F;color:white;width:100%;padding:10px;border:none;border-radius:6px;font-size:15px;"),
          br(),br(),
          actionButton("limpiar_ing","🗑️ Limpiar",
            style="background:#E63946;color:white;width:100%;padding:10px;border:none;border-radius:6px;font-size:15px;")
        ),
        column(8,
          h4("Mi plato",style="color:#1F4E79;"),
          tableOutput("tabla_ing"),
          br(),
          fluidRow(
            column(3,div(style="background:#E63946;color:white;padding:10px;border-radius:8px;text-align:center;",h5("Calorías"),textOutput("tot_cal"))),
            column(3,div(style="background:#2A9D8F;color:white;padding:10px;border-radius:8px;text-align:center;",h5("Proteínas g"),textOutput("tot_prot"))),
            column(3,div(style="background:#457B9D;color:white;padding:10px;border-radius:8px;text-align:center;",h5("Carbos g"),textOutput("tot_carb"))),
            column(3,div(style="background:#F4A261;color:white;padding:10px;border-radius:8px;text-align:center;",h5("Grasas g"),textOutput("tot_gras")))
          ),
          br(),
          verbatimTextOutput("evaluacion_plato"),
          plotOutput("grafico_macros_plato",height="250px")
        )
      )
    ),

    # PESTAÑA 3: RECETAS
    tabPanel("🍳 Recetas rápidas",br(),
      fluidRow(
        column(4,
          h4("Filtrar",style="color:#1F4E79;"),
          sliderInput("tiempo_max","Tiempo máximo (min):",min=5,max=60,value=30),
          selectInput("metodo_rec","Método:",choices=c("Todos","Sancochar","Hornear","Freír","Sin cocción")),
          selectInput("cat_rec","Categoría:",choices=c("Todos",unique(recetas$categoria)))
        ),
        column(8,
          h4("Recetas disponibles",style="color:#1F4E79;"),
          tableOutput("tabla_recetas"),
          plotOutput("grafico_tiempo",height="280px")
        )
      )
    ),

    # PESTAÑA 4: PLAN SEMANAL
    tabPanel("📅 Plan semanal",br(),
      h4("Plan de comidas — semana del estudiante",style="color:#1F4E79;"),
      p("Batch cooking: cocina una vez para varios días y ahorra tiempo."),
      tableOutput("tabla_plan"),
      br(),
      verbatimTextOutput("resumen_plan")
    ),

    # PESTAÑA 5: LISTA DE COMPRAS
    tabPanel("🛒 Lista de compras",br(),
      h4("Lista de compras semanal",style="color:#1F4E79;"),
      p("Precios de mercado de Ica 2026."),
      tableOutput("tabla_compras"),
      br(),
      verbatimTextOutput("total_compras"),
      plotOutput("grafico_compras",height="280px")
    ),

    # PESTAÑA 6: REGISTRO
    tabPanel("📋 Mi registro",br(),
      h4("Historial de comidas",style="color:#1F4E79;"),
      tableOutput("tabla_registro"),
      br(),
      verbatimTextOutput("resumen_registro"),
      plotOutput("grafico_registro",height="280px")
    )
  ),
  hr(),
  p("NutriRápido | Jack Ccencho · Adrian Oviedo · Avidaish Luna · Jhanker Chaupin | UNICA 2026",
    style="color:#999;text-align:center;font-size:12px;")
)

server <- function(input, output, session) {

  # IMC
  observeEvent(input$calcular_imc, {
    imc <- round(input$peso_imc / (input$talla_imc/100)^2, 1)
    tmb <- if(input$sexo_imc=="Masculino")
      88.36+(13.4*input$peso_imc)+(4.8*input$talla_imc)-(5.7*input$edad_imc)
    else 447.6+(9.2*input$peso_imc)+(3.1*input$talla_imc)-(4.3*input$edad_imc)
    fa  <- switch(input$actividad_imc,"Sedentario"=1.2,"Ligero"=1.375,"Moderado"=1.55,"Intenso"=1.725)
    cal <- round(tmb*fa)
    clas <- if(imc<18.5) "⚠ BAJO PESO → Volumen (subir peso)"
      else if(imc<25) "✅ NORMAL → Mantenimiento"
      else if(imc<30) "⚠ SOBREPESO → Definición (bajar peso)"
      else "🚨 OBESIDAD → Consulta nutricionista"

    output$resultado_imc <- renderPrint({
      cat("══════════════════════════════════════════\n")
      cat("IMC —",toupper(input$nombre),"\n")
      cat("══════════════════════════════════════════\n")
      cat("IMC:               ",imc,"kg/m²\n")
      cat("Clasificación:     ",clas,"\n")
      cat("──────────────────────────────────────────\n")
      cat("Calorías diarias:  ",cal,"kcal\n")
      cat("Proteínas (20%):   ",round(cal*0.20/4),"g/día\n")
      cat("Carbohidratos(50%):",round(cal*0.50/4),"g/día\n")
      cat("Grasas (30%):      ",round(cal*0.30/9),"g/día\n")
      cat("══════════════════════════════════════════\n")
    })

    output$grafico_imc <- renderPlot({
      df <- data.frame(
        Cat=c("Bajo peso","Normal","Sobrepeso","Obesidad"),
        Min=c(0,18.5,25,30), Max=c(18.5,25,30,40))
      ggplot(df,aes(xmin=Min,xmax=Max,ymin=0,ymax=1,fill=Cat))+
        geom_rect(alpha=0.7)+
        geom_vline(xintercept=imc,color="black",linewidth=2,linetype="dashed")+
        annotate("text",x=imc,y=0.5,label=paste("Tu IMC:",imc),vjust=-0.5,fontface="bold",size=4.5)+
        scale_fill_manual(values=c("#457B9D","#2A9D8F","#F4A261","#E63946"))+
        scale_x_continuous(limits=c(10,42),breaks=c(18.5,25,30))+
        labs(title="Tu posición en la escala IMC",x="IMC (kg/m²)",y="",fill="")+
        theme_dark(base_size=12)+
        theme(axis.text.y=element_blank(),plot.title=element_text(face="bold"),
              legend.position="bottom",
              plot.background=element_rect(fill="#141824",color=NA),
              panel.background=element_rect(fill="#1E2535",color=NA))
    })
  })

  # MIS INGREDIENTES
  observe({
    ops <- if(input$cat_ing=="Todos") ingredientes$nombre
           else ingredientes$nombre[ingredientes$categoria==input$cat_ing]
    updateSelectInput(session,"ing_sel",choices=ops)
  })

  plato <- reactiveVal(data.frame(
    Ingrediente=character(),Gramos=numeric(),Metodo=character(),
    Calorias=numeric(),Proteinas=numeric(),Carbohidratos=numeric(),Grasas=numeric(),
    stringsAsFactors=FALSE))

  observeEvent(input$agregar_ing, {
    sel <- ingredientes[ingredientes$nombre==input$ing_sel,]
    if(nrow(sel)>0) {
      f <- (input$gramos_ing/100)*factor_coccion[input$metodo_ing]
      nuevo <- data.frame(
        Ingrediente=sel$nombre, Gramos=input$gramos_ing, Metodo=input$metodo_ing,
        Calorias=round(sel$calorias_100g*f,1),
        Proteinas=round(sel$proteinas_100g*f,1),
        Carbohidratos=round(sel$carbohidratos_100g*f,1),
        Grasas=round(sel$grasas_100g*f,1))
      plato(rbind(plato(),nuevo))
    }
  })

  observeEvent(input$limpiar_ing, {
    plato(data.frame(Ingrediente=character(),Gramos=numeric(),Metodo=character(),
      Calorias=numeric(),Proteinas=numeric(),Carbohidratos=numeric(),Grasas=numeric()))
  })

  output$tabla_ing  <- renderTable({plato()},striped=TRUE,hover=TRUE,bordered=TRUE)
  output$tot_cal    <- renderText({paste(round(sum(plato()$Calorias),1),"kcal")})
  output$tot_prot   <- renderText({round(sum(plato()$Proteinas),1)})
  output$tot_carb   <- renderText({round(sum(plato()$Carbohidratos),1)})
  output$tot_gras   <- renderText({round(sum(plato()$Grasas),1)})

  output$evaluacion_plato <- renderPrint({
    req(nrow(plato())>0)
    tc <- sum(plato()$Calorias)
    pp <- if(tc>0) round(sum(plato()$Proteinas)*4/tc*100,1) else 0
    pc <- if(tc>0) round(sum(plato()$Carbohidratos)*4/tc*100,1) else 0
    pg <- if(tc>0) round(sum(plato()$Grasas)*9/tc*100,1) else 0
    cat("══════════════════════════════════════\n")
    cat("EVALUACIÓN DEL PLATO\n")
    cat("══════════════════════════════════════\n")
    cat("Proteínas:    ",pp,"% (ideal 15-25%)",if(pp>=15&&pp<=25)" ✅" else" ⚠","\n")
    cat("Carbohidratos:",pc,"% (ideal 45-65%)",if(pc>=45&&pc<=65)" ✅" else" ⚠","\n")
    cat("Grasas:       ",pg,"% (ideal 20-35%)",if(pg>=20&&pg<=35)" ✅" else" ⚠","\n")
    cat("──────────────────────────────────────\n")
    if(pp<15) cat("💡 Agrega proteína: huevo, pollo o atún\n")
    if(pc<45) cat("💡 Agrega carbos: arroz, papa o fideos\n")
    if(pg>35) cat("💡 Reduce grasas: menos aceite o frituras\n")
    if(pp>=15&&pc>=45&&pg<=35) cat("🎉 ¡Plato bien balanceado!\n")
    cat("══════════════════════════════════════\n")
  })

  output$grafico_macros_plato <- renderPlot({
    req(nrow(plato())>0)
    df <- data.frame(
      Nutriente=c("Proteínas","Carbohidratos","Grasas"),
      Gramos=c(sum(plato()$Proteinas),sum(plato()$Carbohidratos),sum(plato()$Grasas)))
    ggplot(df,aes(x=Nutriente,y=Gramos,fill=Nutriente))+
      geom_bar(stat="identity",width=0.6)+
      scale_fill_manual(values=c("#2A9D8F","#457B9D","#F4A261"))+
      labs(title="Macronutrientes del plato",x="",y="Gramos")+
      theme_minimal(base_size=12)+theme(legend.position="none",plot.title=element_text(face="bold"))
  })

  # RECETAS
  output$tabla_recetas <- renderTable({
    df <- recetas
    if(input$metodo_rec!="Todos") df <- df[df$metodo_coccion==input$metodo_rec,]
    if(input$cat_rec!="Todos")    df <- df[df$categoria==input$cat_rec,]
    df <- df[df$tiempo_min<=input$tiempo_max,]
    df[,c("nombre","categoria","tiempo_min","metodo_coccion","porciones","dificultad")]
  },striped=TRUE,hover=TRUE,bordered=TRUE)

  output$grafico_tiempo <- renderPlot({
    df <- recetas[recetas$tiempo_min<=input$tiempo_max,]
    ggplot(df,aes(x=reorder(nombre,tiempo_min),y=tiempo_min,fill=metodo_coccion))+
      geom_bar(stat="identity")+coord_flip()+
      scale_fill_manual(values=c("#2A9D8F","#E63946","#F4A261","#457B9D"))+
      labs(title="Tiempo de preparación",x="",y="Minutos",fill="Método")+
      theme_minimal(base_size=11)+theme(plot.title=element_text(face="bold"))
  })

  # PLAN SEMANAL
  output$tabla_plan <- renderTable({
    df <- merge(plan_semanal,recetas[,c("id_receta","nombre","tiempo_min","metodo_coccion")],by="id_receta")
    df[order(match(df$dia,c("Lunes","Martes","Miércoles","Jueves","Viernes"))),
       c("dia","tiempo_comida","nombre","tiempo_min","metodo_coccion")]
  },striped=TRUE,hover=TRUE,bordered=TRUE)

  output$resumen_plan <- renderPrint({
    df <- merge(plan_semanal,recetas[,c("id_receta","nombre","tiempo_min")],by="id_receta")
    cat("══════════════════════════════════════\n")
    cat("RESUMEN DEL PLAN SEMANAL\n")
    cat("══════════════════════════════════════\n")
    cat("Comidas planificadas:",nrow(df),"\n")
    cat("Tiempo total cocina: ",sum(df$tiempo_min),"minutos\n")
    cat("Promedio por comida: ",round(mean(df$tiempo_min),1),"minutos\n")
    cat("──────────────────────────────────────\n")
    cat("💡 Tip batch cooking:\n")
    cat("Cocina arroz el domingo para toda la\n")
    cat("semana. Sancocha el pollo para 3 días.\n")
    cat("Ensalada al momento: solo 5 minutos.\n")
    cat("══════════════════════════════════════\n")
  })

  # LISTA DE COMPRAS
  output$tabla_compras <- renderTable({
    df <- merge(lista_compras,ingredientes[,c("id_ingrediente","nombre","categoria")],by="id_ingrediente")
    df[,c("nombre","categoria","cantidad","unidad","precio_estimado")]
  },striped=TRUE,hover=TRUE,bordered=TRUE)

  output$total_compras <- renderPrint({
    total <- sum(lista_compras$precio_estimado)
    cat("══════════════════════════════════════\n")
    cat("RESUMEN DE COMPRAS SEMANALES\n")
    cat("══════════════════════════════════════\n")
    cat("Total productos: ",nrow(lista_compras),"\n")
    cat("Costo total:     S/.",round(total,2),"\n")
    cat("Costo diario:    S/.",round(total/7,2),"\n")
    cat("──────────────────────────────────────\n")
    cat("💡 Compra en el mercado de Ica para\n")
    cat("precios más económicos que el super.\n")
    cat("══════════════════════════════════════\n")
  })

  output$grafico_compras <- renderPlot({
    df <- merge(lista_compras,ingredientes[,c("id_ingrediente","nombre","categoria")],by="id_ingrediente")
    df2 <- aggregate(precio_estimado~categoria,data=df,FUN=sum)
    ggplot(df2,aes(x=reorder(categoria,precio_estimado),y=precio_estimado,fill=categoria))+
      geom_bar(stat="identity")+
      geom_text(aes(label=paste("S/.",round(precio_estimado,2))),hjust=-0.1)+
      coord_flip()+
      labs(title="Gasto semanal por categoría",x="",y="Soles (S/.)")+
      theme_minimal(base_size=12)+theme(legend.position="none",plot.title=element_text(face="bold"))
  })

  # REGISTRO
  output$tabla_registro <- renderTable({
    df <- merge(registro_comidas,recetas[,c("id_receta","nombre")],by="id_receta")
    df[,c("fecha","tiempo_comida","nombre","porciones","calorias_consumidas")]
  },striped=TRUE,hover=TRUE,bordered=TRUE)

  output$resumen_registro <- renderPrint({
    cat("══════════════════════════════════════\n")
    cat("RESUMEN DE TU REGISTRO\n")
    cat("══════════════════════════════════════\n")
    cat("Comidas registradas:",nrow(registro_comidas),"\n")
    cat("Calorías totales:   ",sum(registro_comidas$calorias_consumidas),"kcal\n")
    cat("Promedio diario:    ",round(sum(registro_comidas$calorias_consumidas)/length(unique(registro_comidas$fecha)),1),"kcal\n")
    cat("══════════════════════════════════════\n")
  })

  output$grafico_registro <- renderPlot({
    df <- aggregate(calorias_consumidas~fecha,data=registro_comidas,FUN=sum)
    ggplot(df,aes(x=fecha,y=calorias_consumidas))+
      geom_bar(stat="identity",fill="#1F4E79",width=0.5)+
      geom_text(aes(label=paste(calorias_consumidas,"kcal")),vjust=-0.5,size=3.5)+
      labs(title="Calorías consumidas por día",x="Fecha",y="kcal")+
      theme_minimal(base_size=12)+theme(plot.title=element_text(face="bold"))
  })
}

shinyApp(ui=ui,server=server)


# intplot  ----------------------------------------------------------------

panel_intplot <- tabPanel(
  "intplot",
  fluidRow(
    column(
      8, 
      plotOutput(
        "intplot_1", height = 250, dblclick = "intplot_dbclick_1",
        brush = brushOpts(
          id = "intplot_brush_1", resetOnNew = T
        )
      )
    ),
    column(
      4, 
      rHandsontableOutput("inttb_1"), 
      style = "height:300px; overflow-y: scroll;overflow-x: scroll;"
    )
  ),
  fluidRow(
    column(
      8, 
      plotOutput(
        "intplot_2", height = 250, dblclick = "intplot_dbclick_2",
        brush = brushOpts(
          id = "intplot_brush_2", resetOnNew = T
        )
      )
    ),
    column(
      4, 
      rHandsontableOutput("inttb_2"), 
      style = "height:300px; overflow-y: scroll;overflow-x: scroll;"
    )
  )
)

# smrplot ------------------------------------------------------------
panel_smrplot <- tabPanel(
  "smrplot",
  fluidRow(
    column(
      6,
      fluidRow(
        column(
          6,
          textOutput("smr_teamname_1"),
          numericInput("crrate_1", "current rate", value = 2),
          verbatimTextOutput("smr_bestrate_1")
        ),
        column(
          6,
          textOutput("smr_teamname_2"),
          numericInput("crrate_2", "current rate", value = 2),
          verbatimTextOutput("smr_bestrate_2")
        )
      )
      
    ),
    column(6, plotOutput("smr_int", height = 250, width = 300))
  ),
  br(),
  fluidRow(
    column(6, plotOutput("smr_win", height = 250, width = 300)),
    column(6, plotOutput("smr_bet", height = 250, width = 300))
  )
)



# download ----------------------------------------------------------------

panel_download <- tabPanel(
  "download",
  fluidRow(column(12, selectInput("teamwin", "Team win:", c("team_1", "team_2")))),
  fluidRow(column(12, verbatimTextOutput("teamwin_announcer"))),
  fluidRow(column(12, rHandsontableOutput("dltb"))),
  fluidRow(column(12, downloadButton("dlbutton", "Download")))
)
# main ui -----------------------------------------------------------------
ui <- fluidPage(
  titlePanel("BETGENR"),
  
  sidebarLayout(
    
    sidebarPanel(
      width = 3,
      fluidRow(column(12, textInput("game", "game"))),
      fluidRow(
        column(6, textInput("teamname_1", "team_1")),
        column(6, textInput("teamname_2", "team_2"))
      ),
      rHandsontableOutput("bettb"),
      br(), 
      actionButton("updatebet", "Update"),
      br(),br(),
      rHandsontableOutput("smrtb")
    ),
    
    mainPanel(
      width = 9,
      tabsetPanel(
        panel_smrplot,
        panel_intplot,
        panel_download
      )
    )
    
  )
)


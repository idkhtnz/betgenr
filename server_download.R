output$teamwin_announcer <- renderText(
  paste(NA, "WIN!!")
)

output$dltb <- dt$dltb %>% rhandsontable() %>% renderRHandsontable()

observeEvent(input$updatebet, {
  
  bettb <- input$bettb %>% hot_to_r() %>% as.data.frame()
  
  dt$dltb <-   rbind.data.frame(
    
    data.frame(
      team = input$teamname_1,
      bet = bettb$bet_1,
      rate = bettb$rate_1,
      win = input$teamwin == "team_1"
    ),
    data.frame(
      team = input$teamname_2,
      bet = bettb$bet_2,
      rate = bettb$rate_2,
      win = input$teamwin == "team_2"
    )
    
  )
  
  dt$dltb$time <- as.POSIXct(Sys.time())
  dt$dltb$game <- input$game
  
  dt$dltb <- dt$dltb[c("time", "game", "team", "bet", "rate", "win")]
  
  dt$dltb <- dt$dltb[complete.cases(dt$dltb),]
  
  output$dltb <- dt$dltb %>% rhandsontable() %>% renderRHandsontable()
  
  output$teamwin_announcer <- renderText(
    paste(
      if (
        input$teamwin == "team_1"
      ) {
        input$teamname_1
      } else {input$teamname_2}, 
      "WIN!!"
    )
  )
})

output$dlbutton <- downloadHandler(
  filename = function(){
    paste("dltb_", as.numeric(Sys.time()), ".csv", sep = "")
  },
  content = function(file){
    write.csv(dt$dltb, file, row.names = F)
  }
)


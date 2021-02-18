output$smr_teamname_1 <- renderText(input$teamname_1)
output$smr_teamname_2 <- renderText(input$teamname_2)

output$smr_bestrate_1 <- renderText({
  smrtb <- input$smrtb %>% hot_to_r() %>% as.data.frame()
  
  paste(
    "Best bet: \n",
    (
      if (
        smrtb$team_2[[2]] - smrtb$team_1[[2]] >=0
      ) {
        smrtb$team_2[[2]] - smrtb$team_1[[2]]
      } else {0}
    )/input$crrate_1,"\n",
    "Different: \n",
    (
      if (
        smrtb$team_2[[2]] - smrtb$team_1[[2]] >=0
      ) {
        smrtb$team_2[[2]] - smrtb$team_1[[2]]
      } else {0}
    )
  )
})

output$smr_bestrate_2 <- renderText({
  smrtb <- input$smrtb %>% hot_to_r() %>% as.data.frame()
  
  paste(
    "Best bet: \n",
    (
      if (
        smrtb$team_1[[2]] - smrtb$team_2[[2]] >=0
      ) {
        smrtb$team_1[[2]] - smrtb$team_2[[2]]
      } else {0}
    )/input$crrate_2,"\n",
    "Different: \n",
    (
      if (
        smrtb$team_1[[2]] - smrtb$team_2[[2]] >=0
      ) {
        smrtb$team_1[[2]] - smrtb$team_2[[2]]
      } else {0}
    )
  )
})

# smr_plot ----------------------------------------------------------------


observeEvent(input$updatebet, {

  output$smr_int <- renderPlot({
    smrtb <- input$smrtb %>% hot_to_r() %>% t() %>% as.data.frame()
    smrtb <- cbind.data.frame(
      team = c("team_1", "team_2"),
      smrtb
    )
    ggplot(data = smrtb, aes(x = team, y = total_int, fill = total_int < 0)) + 
      geom_bar(stat = "identity")+
      geom_text(aes(label = total_int), vjust = 1.6) +
      scale_fill_manual(values = c("green", "red")) + 
      theme(legend.position = "none")
  })
  
  output$smr_win <- renderPlot({
    smrtb <- input$smrtb %>% hot_to_r() %>% t() %>% as.data.frame()
    smrtb <- cbind.data.frame(
      team = c("team_1", "team_2"),
      smrtb
    )
    ggplot(data = smrtb, aes(x = team, y = total_win, fill = total_int < 0)) + 
      geom_bar(stat = "identity")+
      geom_text(aes(label = total_win), vjust = 1.6) +
      scale_fill_manual(values = c("green", "red")) + 
      theme(legend.position = "none")
  })
  
  output$smr_bet <- renderPlot({
    smrtb <- input$smrtb %>% hot_to_r() %>% t() %>% as.data.frame()
    smrtb <- cbind.data.frame(
      team = c("team_1", "team_2"),
      smrtb
    )
    ggplot(data = smrtb, aes(x = team, y = total_bet, fill = total_int < 0)) + 
      geom_bar(stat = "identity")+
      geom_text(aes(label = total_bet), vjust = 1.6) +
      scale_fill_manual(values = c("green", "red")) + 
      theme(legend.position = "none")
  })
  
})


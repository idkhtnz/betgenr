
# smr table ---------------------------------------------------------------

output$smrtb <- dt$smrtb %>% 
  rhandsontable(rowHeaderWidth = 80) %>%
  renderRHandsontable()

observeEvent(input$updatebet, {
  
  bettb <- input$bettb %>% hot_to_r() %>% as.data.frame()
  
  dt$smrtb <- data.frame(
    team_1 = c(
      sum(bettb$bet_1, na.rm = T),
      sum(bettb$bet_1 * bettb$rate_1, na.rm = T),
      sum(bettb$bet_1 * bettb$rate_1, na.rm = T) -
        sum(bettb$bet_1, na.rm = T) - sum(bettb$bet_2, na.rm = T)
    ),
    team_2 = c(
      sum(bettb$bet_2, na.rm = T),
      sum(bettb$bet_2 * bettb$rate_2, na.rm = T),
      sum(bettb$bet_2 * bettb$rate_2, na.rm = T) -
        sum(bettb$bet_2, na.rm = T) - sum(bettb$bet_1, na.rm = T)
    )
  )

  row.names(dt$smrtb) <- c("total_bet", "total_win", "total_int")

  output$smrtb <- dt$smrtb %>%
    rhandsontable() %>%
    renderRHandsontable()



})

output$bettb <- dt$bettb %>%
  rhandsontable(rowHeaders = NULL) %>%
  renderRHandsontable()
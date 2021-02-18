# table output ------------------------------------------------------------
output$inttb_1 <- dt$inttb_1 %>% 
  rhandsontable(rowHeaders = NULL) %>%
  renderRHandsontable()

output$inttb_2 <- dt$inttb_2 %>% 
  rhandsontable(rowHeaders = NULL) %>%
  renderRHandsontable()

output$intplot_1 <- renderPlot({
  ggplot(data = dt$inttb_1, aes(x = rate, y = int)) + 
    geom_point() + 
    geom_hline(aes(yintercept = 0))
})

output$intplot_2 <- renderPlot({
  ggplot(data = dt$inttb_2, aes(x = rate, y = int)) + 
    geom_point() + 
    geom_hline(aes(yintercept = 0))
})
# update button -----------------------------------------------------------

observeEvent(input$updatebet, {
  
  bettb_1 <- (
    input$bettb %>% hot_to_r() %>% as.data.frame()
  )[1:2]
  bettb_2 <- (
    input$bettb %>% hot_to_r() %>% as.data.frame()
  )[3:4]
  
  bettb_1 <- bettb_1[complete.cases(bettb_1),]
  bettb_2 <- bettb_2[complete.cases(bettb_2),]
  
  dt$inttb_1 <- data.frame(
    rate = seq(1.1,10,0.01),
    bet = (
      if (
        sum(bettb_2$bet * bettb_2$rate) - sum(bettb_1$bet * bettb_1$rate) >= 0
      ) {
        sum(bettb_2$bet * bettb_2$rate) - sum(bettb_1$bet * bettb_1$rate)
      } else {0}
    )/seq(1.1,10,0.01)
  )
  
  dt$inttb_1$int <- sum(bettb_1$bet * bettb_1$rate) +
    dt$inttb_1$bet * dt$inttb_1$rate - 
    sum(bettb_1$bet) -sum(bettb_2$bet) - dt$inttb_1$bet 
  
  dt$inttb_2 <- data.frame(
    rate = seq(1.1,10,0.01),
    bet = (
      if (
        sum(bettb_1$bet * bettb_1$rate) - sum(bettb_2$bet * bettb_2$rate) >= 0
      ) {
        sum(bettb_1$bet * bettb_1$rate) - sum(bettb_2$bet * bettb_2$rate)
      } else {0}
    )/seq(1.1,10,0.01)
  )
  
  dt$inttb_2$int <- sum(bettb_2$bet * bettb_2$rate) +
    dt$inttb_2$bet * dt$inttb_2$rate - 
    sum(bettb_2$bet) -sum(bettb_1$bet) - dt$inttb_2$bet 
  
  
  #########################
  range_1 <- reactiveValues(x = NULL, y = NULL)
  
  
  
  output$intplot_1 <- renderPlot({
    ggplot(data = dt$inttb_1, aes(x = rate, y = int)) + 
      geom_point() + 
      geom_hline(aes(yintercept = 0)) + 
      coord_cartesian(xlim = range_1$x, ylim = range_1$y, expand = FALSE)
  })
  
  observeEvent(input$intplot_dbclick_1, {
    brush <- input$intplot_brush_1
    if (!is.null(brush)) {
      range_1$x <- c(brush$xmin, brush$xmax)
      range_1$y <- c(brush$ymin, brush$ymax)
      
    } else {
      range_1$x <- NULL
      range_1$y <- NULL
    }
    
    output$inttb_1 <- brushedPoints(
      dt$inttb_1, input$intplot_brush_1, xvar = "rate", yvar = "int" 
    ) %>% 
      rhandsontable(rowHeaders = NULL) %>% 
      hot_col(
        "int",
        renderer = "
                    function (instance, td, row, col, prop, value, cellProperties) {
                      Handsontable.renderers.NumericRenderer.apply(this, arguments);
                      if (value < 0) {
                        td.style.background = '#f54f4f';
                      } else {
                        td.style.background = 'green';
                      }
                    }"
                                 
      ) %>% 
      renderRHandsontable()
    
  })
  ############################
  range_2 <- reactiveValues(x = NULL, y = NULL)
  
  
  
  output$intplot_2 <- renderPlot({
    ggplot(data = dt$inttb_2, aes(x = rate, y = int)) + 
      geom_point() + 
      geom_hline(aes(yintercept = 0)) + 
      coord_cartesian(xlim = range_2$x, ylim = range_2$y, expand = FALSE)
  })
  
  observeEvent(input$intplot_dbclick_2, {
    brush <- input$intplot_brush_2
    if (!is.null(brush)) {
      range_2$x <- c(brush$xmin, brush$xmax)
      range_2$y <- c(brush$ymin, brush$ymax)
      
    } else {
      range_2$x <- NULL
      range_2$y <- NULL
    }
    
    output$inttb_2 <- brushedPoints(
      dt$inttb_2, input$intplot_brush_2, xvar = "rate", yvar = "int" 
    ) %>% 
      rhandsontable(rowHeaders = NULL) %>% 
      hot_col(
        "int",
        renderer = "
                    function (instance, td, row, col, prop, value, cellProperties) {
                      Handsontable.renderers.NumericRenderer.apply(this, arguments);
                      if (value < 0) {
                        td.style.background = '#f54f4f';
                      } else {
                        td.style.background = 'green';
                      }
                    }"
        
      ) %>% 
      renderRHandsontable()
    
  })
})














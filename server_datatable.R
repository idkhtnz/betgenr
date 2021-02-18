# data table --------------------------------------------------------------
dt <- reactiveValues()
dt$bettb <- data.frame(
  bet_1 = as.numeric(rep(NA,5)),
  rate_1 = as.numeric(rep(NA,5)),
  bet_2 = as.numeric(rep(NA,5)),
  rate_2 = as.numeric(rep(NA,5))
)

dt$inttb_1 <- data.frame(
  rate = as.numeric(),
  bet = as.numeric(),
  int = as.numeric()
)
dt$inttb_2 <- data.frame(
  rate = as.numeric(),
  bet = as.numeric(),
  int = as.numeric()
)
dt$smrtb <- data.frame(
  team_1 = as.numeric(rep(NA, 3)),
  team_2 = as.numeric(rep(NA, 3))
)


dt$dltb <- data.frame(
  time = as.POSIXct(integer(0)),
  game = as.character(),
  team = as.character(),
  bet = as.numeric(),
  rate = as.numeric(),
  win = as.logical()
)


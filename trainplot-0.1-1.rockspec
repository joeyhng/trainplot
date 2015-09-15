package = "TrainPlot"
version = "0.1-1"
source = {
  url = "file:///home/joe/code/trainplot/"
}
dependencies = {
  "lua"
}
build = {
  type = "builtin",
  modules = {
    ['TrainPlotter'] = 'trainplot.lua'
  }
}

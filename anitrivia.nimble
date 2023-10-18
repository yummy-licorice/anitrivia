version       = "0.1.0"
author        = "ripples"
description   = "Random anime for anime trivia api"
license       = "MIT"

namedBin = {
  "src/main": "bin/anitrivia",
  "src/updatedb": "bin/update-db"
}.toTable()

requires "nim >= 2.0.0", "happyx", "zuhyo", "jsony", "limdb", "flatty", "supersnappy"

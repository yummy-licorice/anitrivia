import
  jsony,
  limdb,
  flatty,
  supersnappy,
  std/strutils,
  happyx,
  std/random; randomize()

type
  Anime = object
    name: string
    img: string
    color: string

let db = initDatabase("db", (string, string))
let idx = rand(0..db["max"].parseInt())
let data = fromFlatty(uncompress(db[$idx]), Anime).toJson()

proc random(): string {.gcsafe.} =
  let idx = rand(0..db["max"].parseInt())
  return fromFlatty(uncompress(db[$idx]), Anime).toJson()

serve("127.0.0.1", 3000):
  get "/":
    random()

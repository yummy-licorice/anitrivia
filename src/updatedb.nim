import supersnappy, zuhyo, jsony, strutils, std/options, limdb, flatty
import usertypes

let gql = """query ($id: Int) {
  Media (id: $id, type: ANIME) {
  	title {
    	english
    }
    coverImage {
      large
      color
    }
    isAdult
  }
}"""

let db = initDatabase("db", (string, string))
let api = zuhyo.newClient("https://graphql.anilist.co")
var counter = db.getOrPut("max", $0).parseInt()

# Comment this if you want to continue from when you last updated
db["cid"] = $0
db["max"] = $0

let cid = db.getOrPut("cid", $0).parseInt()
echo $cid
echo db["max"]

for i in cid..104253:
  let query = gql.newQuery(vars {"id": $i})
  let res = api.request(query).body
  if (not res.contains("errors")) and (not res.contains("<")):
    let data = res.fromJson(JSON).data.Media
    let title = data.title.english
    if (not title.isNone) and (not data.isAdult):
      echo title.get() & " : " & $i
      db[$counter] = compress(toFlatty(Anime(
        name: title.get(),
        img: data.coverImage.large,
        color: data.coverImage.color
      )))
      db["max"] = $counter
      db["cid"] = $i
      inc counter
    else:
      echo "err - no name"
  else:
    echo "err - json"



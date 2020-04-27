/*
Items Model
Items will be the individual post/comment/etc. retrieved from the HN API
Items will be stored in either the Post table or the Comment table
 */

class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final int poll;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final List<dynamic> parts;
  final int descendants;

  // the fromJSON named constructor parses the inbound JSON data from the API
  ItemModel.fromJSON(Map<String, dynamic> parsedJSON)
      : id = parsedJSON['id'],
        deleted = parsedJSON['deleted'] ?? false,
        type = parsedJSON['type'],
        by = parsedJSON['by'] ?? "",
        time = parsedJSON['time'],
        text = parsedJSON['text'] ?? "",
        dead = parsedJSON['dead'] ?? false,
        parent = parsedJSON['parent'],
        poll = parsedJSON['poll'],
        kids = parsedJSON['kids'] ?? [],
        url = parsedJSON['url'] ?? "",
        score = parsedJSON['score'] ?? 0,
        title = parsedJSON['title'] ?? "",
        parts = parsedJSON['parts'] ?? [],
        descendants = parsedJSON['descendants'] ?? 0;

  // the fromDB named constructor parses the inbound item data from the DB provider

  ItemModel.fromDB(Map<String, dynamic> parsedDB)
      : id = parsedDB['id'],
        deleted = parsedDB['deleted'] == 1,
        type = parsedDB['type'],
        by = parsedDB['by'],
        time = parsedDB['time'],
        text = parsedDB['text'],
        dead = parsedDB['dead'] == 1,
        parent = parsedDB['parent'],
        poll = parsedDB['poll'],
        kids = parsedDB['kids'],
        url = parsedDB['url'],
        score = parsedDB['score'],
        title = parsedDB['title'],
        parts = parsedDB['parts'],
        descendants = parsedDB['descendants'];

  // toMapFromDB converts the ItemModel into a map that can be inserted into the SQL table
  Map<String, dynamic> toMapForDB() {
    return <String, dynamic>{
      "id": id,
      "deleted": deleted ? 1 : 0,
      "type": type,
      "by": by,
      "time": time,
      "text": text,
      "dead": dead ? 1 : 0,
      "parent": parent,
      "poll": poll,
      "kids": kids,
      "url": url,
      "score": score,
      "title": title,
      "parts": parts,
      "descendants": descendants
    };
  }
}

class Todo {
  int? id;
  String title;
  String? description;
  String date;
  int priority;

  Todo({
    required this.title,
    required this.date,
    required this.priority,
    this.description,
  });

  Todo.withId({
    required this.id,
    required this.title,
    required this.date,
    required this.priority,
    this.description,
  });

  Todo.fromMap(dynamic o)
      : id = o["id"],
        title = o["title"],
        description = o["description"],
        priority = o["priority"],
        date = o["date"];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["title"] = title;
    map["description"] = description;
    map["priority"] = priority;
    map["date"] = date;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}

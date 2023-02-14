class Todo{
  Todo({required this.title, required this.date});

  Todo.fromJson(Map<String, dynamic> json)
  : title = json['title'],
  date = DateTime.parse(json['datetime']);

  String title;
  DateTime date;

  Map<String, dynamic> toJson(){
    return{
      'title': title,
      'dateTime': date.toIso8601String(),
    };
  }
}
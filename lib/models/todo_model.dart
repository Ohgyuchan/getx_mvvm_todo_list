class TodoModel {
  String? id;
  String title;
  bool isDone;

  TodoModel({required this.title, this.isDone = false, this.id});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      title: json['title'],
      isDone: json['isDone'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isDone': isDone,
      'id': id,
    };
  }

  @override
  String toString() {
    return "id: $id, title: $title, isDone: $isDone";
  }
}

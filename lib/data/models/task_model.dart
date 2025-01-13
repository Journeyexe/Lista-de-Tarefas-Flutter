class TaskModel {
  final String title;
  final String description;
  late bool isDone;

  TaskModel({
    required this.title,
    required this.description,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'],
      description: map['description'],
      isDone: map['isDone'],
    );
  }
}

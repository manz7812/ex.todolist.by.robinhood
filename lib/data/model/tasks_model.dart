
import 'dart:convert';

TaskTodoModel taskTodoModelFromJson(String str) => TaskTodoModel.fromJson(json.decode(str));

String taskTodoModelToJson(TaskTodoModel data) => json.encode(data.toJson());

class TaskTodoModel {
  List<Task> tasks;
  int pageNumber;
  int totalPages;

  TaskTodoModel({
    required this.tasks,
    required this.pageNumber,
    required this.totalPages,
  });

  factory TaskTodoModel.fromJson(Map<String, dynamic> json) => TaskTodoModel(
    tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
    pageNumber: json["pageNumber"],
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
    "pageNumber": pageNumber,
    "totalPages": totalPages,
  };
}

class Task {
  String id;
  String title;
  String description;
  DateTime createdAt;
  Status status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
    status: statusValues.map[json["status"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "createdAt": createdAt.toIso8601String(),
    "status": statusValues.reverse[status],
  };
}

enum Status {
  DOING,
  DONE,
  TODO
}

final statusValues = EnumValues({
  "DOING": Status.DOING,
  "DONE": Status.DONE,
  "TODO": Status.TODO
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

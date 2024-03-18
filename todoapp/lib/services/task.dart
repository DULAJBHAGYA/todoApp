class Task {
  int id;
  String name;
  bool completed;

  Task({required this.id, required this.name, this.completed = false});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      completed: json["completed"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "completed": completed,
      };
}

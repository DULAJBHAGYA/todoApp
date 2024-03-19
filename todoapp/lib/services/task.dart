class Task {
  int id; // Hold the model ID retrieved from the backend
  String name;
  bool completed;

  Task({required this.id, required this.name, this.completed = false});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["modelId"] ?? 0, // Replace "modelId" with the key for your GORM model ID in the JSON response
      name: json["name"] ?? "",
      completed: json["completed"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "modelId": id, // Replace "modelId" with the key for your GORM model ID in the JSON request
        "name": name,
        "completed": completed,
      };
}

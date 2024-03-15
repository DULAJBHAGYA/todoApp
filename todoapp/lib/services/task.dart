class Task {
  String name;
  bool completed;

  Task({required this.name, this.completed = false}); // Provide a default value for completed

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      name: json["name"] ?? "",
      completed: json["completed"] ?? false, // Assign completed value if available
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "completed": completed, // Include completed in the JSON representation
      };
}

class Task {
<<<<<<< Updated upstream
  int id; // Hold the model ID retrieved from the backend
=======
  int ID;
>>>>>>> Stashed changes
  String name;
  bool completed;

  Task({required this.ID, required this.name, this.completed = false});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
<<<<<<< Updated upstream
      id: json["modelId"] ?? 0, // Replace "modelId" with the key for your GORM model ID in the JSON response
=======
      ID: json["ID"] ?? 0,
>>>>>>> Stashed changes
      name: json["name"] ?? "",
      completed: json["completed"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
<<<<<<< Updated upstream
        "modelId": id, // Replace "modelId" with the key for your GORM model ID in the JSON request
        "name": name,
        "completed": completed,
      };
=======
  "ID": ID,
  "name": name,
  "completed": completed,
};

>>>>>>> Stashed changes
}

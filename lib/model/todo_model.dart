// ignore_for_file: public_member_api_docs, sort_constructors_first
class TodoModel {
  String? id;
  String title;
  String description;
  bool isCompleted;
  DateTime createdAt;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json["_id"] ?? '',
      title: json["title"] ?? '',
      description: json["description"] ?? '',
      isCompleted: json["is_completed"] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class TodoMdl extends Equatable {
  String? id;
  String? title;
  String? description;
  bool? isCompleted;

  TodoMdl(
      {String? id,
      required this.title,
      this.description = '',
      this.isCompleted = false})
      : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  TodoMdl.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    isCompleted = json['isCompleted'];
  }

  TodoMdl copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return TodoMdl(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, title, description, isCompleted];
}

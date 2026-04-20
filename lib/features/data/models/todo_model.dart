import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel extends Equatable {
  const TodoModel({
    this.id,
    this.title,
    this.description,
    this.createdAt,
  });

  final int? id;
  final String? title;
  final String? description;
  final String? createdAt;

  TodoModel copyWith({
    int? id,
    String? title,
    String? description,
    String? createdAt,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) => _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);

  @override
  List<Object?> get props => [
    id, title, description, createdAt, ];
}

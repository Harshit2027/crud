import 'package:crud/features/data/models/todo_model.dart';
import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final TodoModel data;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TodoCard({super.key, required this.data, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.title ?? ''),
      subtitle: Text(data.description ?? ''),
      onTap: onEdit,
      trailing: IconButton(
        onPressed: onDelete,
        icon: const Icon(Icons.delete_outline),
      ),
    );
  }
}

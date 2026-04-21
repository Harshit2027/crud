import 'package:crud/core/constants/enums.dart';
import 'package:crud/features/data/models/todo_model.dart';
import 'package:crud/features/presentation/bloc/add_edit/add_edit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditTodoPage extends StatefulWidget {
  static const String routeName = '/add-edit-todo-page';

  const AddEditTodoPage({super.key});

  // static Widget builder(BuildContext context) {
  //   var args = ModalRoute.of(context)!.settings.arguments as TodoModel?;
  //   return BlocProvider(
  //     create: (context) => AddEditBloc(AddEditState(todoModel: args)),
  //     child: AddEditTodoPage(),
  //   );
  // }

  @override
  State<AddEditTodoPage> createState() => _AddEditTodoPageState();
}

class _AddEditTodoPageState extends State<AddEditTodoPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final todo = context.read<AddEditBloc>().state.todoModel;

    if (todo != null) {
      _titleController.text = todo.title ?? '';
      _descriptionController.text = todo.description ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditBloc, AddEditState>(
      listener: (context, state) {
        if (state.status == AddEditStatus.success) {
          Navigator.of(context).pop(state.todoModel);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(state.isEdit ? 'Edit Todo' : 'Add Todo')),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Title is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;
                          context.read<AddEditBloc>().add(
                            SubmitEvent(title: _titleController.text.trim(), description: _descriptionController.text.trim()),
                          );
                        },
                        child: Text(state.isEdit ? 'Update' : 'Save'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

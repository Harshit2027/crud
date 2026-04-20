import 'package:crud/core/constants/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud/features/data/models/todo_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'add_edit_event.dart';

part 'add_edit_state.dart';

class AddEditBloc extends Bloc<AddEditEvent, AddEditState> {
  AddEditBloc(super.initialState) {
    if(state.todoModel!=null){
      emit(state.copyWith(isEdit: true));
    }
    on<SubmitEvent>(_onSubmit);
  }

  void _onSubmit(SubmitEvent event, Emitter<AddEditState> emit) {

    if (state.todoModel != null) {
      var updatedTodo = state.todoModel?.copyWith(
        title: event.title.trim(),
        description: event.description.trim(),
      );
      if (updatedTodo == null) return;
      emit(state.copyWith(todoModel: updatedTodo, status: AddEditStatus.success));
      // Navigator.of(event.context).pop(updatedTodo);
    } else {
      var newTodo = TodoModel(
        id: DateTime.now().millisecondsSinceEpoch,
        title: event.title.trim(),
        description: event.description.trim(),
        createdAt: DateTime.now().toIso8601String(),
      );
      emit(state.copyWith(todoModel: newTodo, status: AddEditStatus.success));
      // Navigator.of(event.context).pop(newTodo);
    }
  }
}

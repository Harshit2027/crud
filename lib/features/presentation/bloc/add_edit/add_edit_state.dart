part of 'add_edit_bloc.dart';

class AddEditState extends Equatable {
  final TodoModel? todoModel;
  final AddEditStatus status;

  final bool isEdit;

  const AddEditState({this.todoModel,this.status=.initial,this.isEdit=false});

  @override
  List<Object?> get props => [todoModel,status,isEdit];

  AddEditState copyWith({
    TodoModel? todoModel,
    AddEditStatus? status,
    bool? isEdit,
  }) {
    return AddEditState(
      todoModel: todoModel ?? this.todoModel,
      status: status ?? this.status,
      isEdit: isEdit ?? this.isEdit,
    );
  }
}

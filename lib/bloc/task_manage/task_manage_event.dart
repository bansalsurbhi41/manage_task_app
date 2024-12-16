part of 'task_manage_bloc.dart';

@immutable
abstract class TaskManageEvent extends Equatable {
  const TaskManageEvent();
}

class SetDateEvent extends TaskManageEvent{
  final String date;
  const SetDateEvent({required this.date});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SetTimeEvent extends TaskManageEvent{
  final String time;
  const SetTimeEvent({required this.time});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SetCategoryEvent extends TaskManageEvent{
  final int categoryId;
  const SetCategoryEvent({required this.categoryId});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SetPriorityEvent extends TaskManageEvent{
  final int priority;
  const SetPriorityEvent({required this.priority});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AddTaskEvent extends TaskManageEvent{
  final String title;
  final String description;
  const AddTaskEvent({required this.title, required this.description});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class EditTaskEvent extends TaskManageEvent{
  final int taskId;
  final String? title;
  final String? description;
  const EditTaskEvent({required this.taskId, this.title, this.description});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class FetchTaskEvent extends TaskManageEvent{
  const FetchTaskEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class FetchTaskWithIdEvent extends TaskManageEvent{
  final int taskId;
  const FetchTaskWithIdEvent({required this.taskId});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DeleteTaskEvent extends TaskManageEvent{
  final int taskId;
  const DeleteTaskEvent({required this.taskId});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
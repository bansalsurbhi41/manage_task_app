part of 'task_manage_bloc.dart';

@immutable
class TaskManageState {
  StateStatus addTaskStatus;
  StateStatus editTaskStatus;
  StateStatus fetchTaskStatus;
  StateStatus fetchTaskWithIdStatus;
  StateStatus deleteTaskStatus;
  Task? task;
  Task? taskData;
  List<Task> taskList;
  TaskManageState({
    this.addTaskStatus = const StateNotLoaded(),
    this.editTaskStatus = const StateNotLoaded(),
    this.fetchTaskStatus = const StateNotLoaded(),
    this.fetchTaskWithIdStatus = const StateNotLoaded(),
    this.deleteTaskStatus = const StateNotLoaded(),
    this.task,
    this.taskData,
    this.taskList = const [],
});



  TaskManageState get initialState => TaskManageState();

  @override
  List<Object> get props => [
    addTaskStatus,
    editTaskStatus,
    fetchTaskStatus,
    fetchTaskWithIdStatus,
    deleteTaskStatus,
    taskList,
  ];

  TaskManageState copyWith({
    StateStatus? addTaskStatus,
    StateStatus? editTaskStatus,
    StateStatus? fetchTaskStatus,
    StateStatus? fetchTaskWithIdStatus,
    StateStatus? deleteTaskStatus,
    Task? task,
    List<Task>? taskList,
    Task? taskData,
  }){
    return TaskManageState(
      addTaskStatus: addTaskStatus ?? this.addTaskStatus,
      editTaskStatus: editTaskStatus ?? this.editTaskStatus,
      fetchTaskStatus: fetchTaskStatus ?? this.fetchTaskStatus,
      fetchTaskWithIdStatus: fetchTaskWithIdStatus ?? this.fetchTaskWithIdStatus,
      deleteTaskStatus: deleteTaskStatus ?? this.deleteTaskStatus,
      task: task ?? this.task,
      taskData: taskData ?? this.taskData,
      taskList: taskList ?? this.taskList,
    );
  }

}



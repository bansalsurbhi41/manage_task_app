import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:learning_project/utilities/state_status.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../src/model/task_model.dart';
import '../../utilities/string_const.dart';
import '../../utilities/table_names.dart';

part 'task_manage_event.dart';
part 'task_manage_state.dart';

class TaskManageBloc extends Bloc<TaskManageEvent, TaskManageState> {
  TaskManageBloc() : super(TaskManageState()) {
    on<SetDateEvent>(onSetDateEvent);
    on<SetTimeEvent>(onSetTimeEvent);
    on<SetCategoryEvent>(onSetCategoryEvent);
    on<SetPriorityEvent>(onSetPriorityEvent);
    on<AddTaskEvent>(onAddTaskEvent);
    on<EditTaskEvent>(onEditTaskEvent);
    on<FetchTaskEvent>(onFetchTaskEvent);
    on<FetchTaskWithIdEvent>(onFetchTaskWithIdEvent);
    on<DeleteTaskEvent>(onDeleteTaskEvent);
  }

  static const kId = 'id';
  static const kUserId = 'user_id';
  static const kAuthId = 'auth_id';
  static const kDate = 'date';
  static const kTime = 'time';

  final SupabaseClient supabase = Supabase.instance.client;


  FutureOr<void> onSetDateEvent(SetDateEvent event, Emitter<TaskManageState> emit) {
    Task task = state.task ?? Task();
    emit(state.copyWith(task: task.copyWith(date: event.date)));
  }

  FutureOr<void> onSetTimeEvent(SetTimeEvent event, Emitter<TaskManageState> emit) {
    Task task = state.task ?? Task();
    emit(state.copyWith(task: task.copyWith(time: event.time)));
  }

  FutureOr<void> onSetCategoryEvent(SetCategoryEvent event, Emitter<TaskManageState> emit) {
    Task task = state.task ?? Task();
    emit(state.copyWith(task: task.copyWith(categoryId: event.categoryId)));
  }

  FutureOr<void> onSetPriorityEvent(SetPriorityEvent event, Emitter<TaskManageState> emit) {
    Task task = state.task ?? Task();
    emit(state.copyWith(task: task.copyWith(priority: event.priority)));
  }

  Future<void> onAddTaskEvent(AddTaskEvent event, Emitter<TaskManageState> emit) async {
    emit(state.copyWith(addTaskStatus: StateLoading()));
    try{
      final userId = await fetchUserId();
      debugPrint('----------------UserId --------$userId');
      final requestModel =  Task(
        title: event.title,
        description: event.description,
        date: state.task?.date,
        time: state.task?.time,
        categoryId: state.task?.categoryId,
        priority: state.task?.priority,
        userId: userId,
      );
      if(userId != null){
        await supabase
            .from(TableNames.tTasks)
            .insert(requestModel.toJson());
        emit(state.copyWith(addTaskStatus: const StateLoaded()));
      }
    }catch(e){
      debugPrint(e.toString());
      emit(state.copyWith(addTaskStatus: const StateFailed()));
    }
  }

  Future<int?> fetchUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authId = prefs.getString(StringConst.kAuthId);

      if (authId == null || authId.isEmpty) {
        throw Exception('authId is null or empty.');
      }

      final result = await supabase
          .from(TableNames.tUsers)
          .select(kId)
          .eq(kAuthId, authId)
          .maybeSingle();

      if (result == null) {
        debugPrint('No user found with the given auth_id.');
        return null;

      }
      return result['id'] as int?;

    } catch (e) {
      debugPrint('Error fetching userId: $e');

    }
    return null;

  }


  FutureOr<void> onFetchTaskEvent(FetchTaskEvent event, Emitter<TaskManageState> emit) async{
    emit(state.copyWith(fetchTaskStatus: StateLoading()));
    try{
      final userId = await fetchUserId();
      if(userId != null){
        final result = await supabase
            .from(TableNames.tTasks)
            .select().eq(kUserId, userId).order(kDate,ascending: true).order(kTime, ascending: true);
        List<Task>  taskList = result.map((task) => Task.fromJson(task)).toList();
        emit(state.copyWith(fetchTaskStatus: const StateLoaded(), taskList: taskList));
      }else{
        emit(state.copyWith(fetchTaskStatus: const StateFailed()));
      }
    }catch(e){
      debugPrint('Error fetching task list: $e');
      emit(state.copyWith(fetchTaskStatus: const StateFailed()));
    }
  }

  FutureOr<void> onEditTaskEvent(EditTaskEvent event, Emitter<TaskManageState> emit) async{

    emit(state.copyWith(editTaskStatus: StateLoading()));
    try{
      final userId = await fetchUserId();
      debugPrint('----------------UserId --------$userId');
      final requestModel =  Task(
        title: event.title,
        description: event.description,
        date: state.task?.date,
        time: state.task?.time,
        categoryId: state.task?.categoryId,
        priority: state.task?.priority,
      );
      print(requestModel);
      if(userId != null){
        await supabase
            .from(TableNames.tTasks)
            .update(requestModel.toJson()).eq(kId, event.taskId).eq(kUserId, userId);
        emit(state.copyWith(editTaskStatus: const StateLoaded()));
      }else{
        emit(state.copyWith(editTaskStatus: const StateFailed()));
      }
    }catch(e){
      debugPrint(e.toString());
      emit(state.copyWith(editTaskStatus: const StateFailed()));
    }
  }

  FutureOr<void> onFetchTaskWithIdEvent(FetchTaskWithIdEvent event, Emitter<TaskManageState> emit) async{
    emit(state.copyWith(fetchTaskWithIdStatus: StateLoading()));
    try{
      final userId = await fetchUserId();
      if(userId != null){
        final result = await supabase
            .from(TableNames.tTasks)
            .select().eq(kId, event.taskId).eq(kUserId, userId).maybeSingle();
        Task  taskData = Task.fromJson(result as Map<String, dynamic>);
        emit(state.copyWith(fetchTaskWithIdStatus: const StateLoaded(), taskData: taskData));
      }else{
        emit(state.copyWith(fetchTaskWithIdStatus: const StateFailed()));
      }
    }catch(e){
      debugPrint('Error fetching task with id: $e');
      emit(state.copyWith(fetchTaskWithIdStatus: const StateFailed()));
    }
  }

  FutureOr<void> onDeleteTaskEvent(DeleteTaskEvent event, Emitter<TaskManageState> emit) async{
    emit(state.copyWith(deleteTaskStatus: StateLoading()));
    try{
      final userId = await fetchUserId();
      if(userId != null){
        await supabase
            .from(TableNames.tTasks)
            .delete().eq(kId, event.taskId).eq(kUserId, userId).maybeSingle();
        emit(state.copyWith(deleteTaskStatus: const StateLoaded()));
      }else{
        emit(state.copyWith(deleteTaskStatus: const StateFailed()));
      }
    }catch(e){
      debugPrint('Error While delete task: $e');
      emit(state.copyWith(deleteTaskStatus: const StateFailed()));
    }
  }
}



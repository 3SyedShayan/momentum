import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/task_model.dart';
import '../../repositories/momentum_repository.dart';
import 'tasks_event.dart';
import 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final MomentumRepository _momentumRepository;

  TasksBloc({required MomentumRepository momentumRepository})
      : _momentumRepository = momentumRepository,
        super(TasksInitial()) {
    on<SubscribeTasks>(_onSubscribeTasks);
    on<TasksUpdated>(_onTasksUpdated);
    on<AddTaskRequested>(_onAddTaskRequested);
    on<UpdateTaskRequested>(_onUpdateTaskRequested);
    on<DeleteTaskRequested>(_onDeleteTaskRequested);
  }

  Future<void> _onSubscribeTasks(
    SubscribeTasks event,
    Emitter<TasksState> emit,
  ) async {
    emit(TasksLoading());
    await emit.forEach<List<TaskModel>>(
      _momentumRepository.getTasks(event.uid),
      onData: (tasks) => TasksLoaded(tasks),
      onError: (error, stackTrace) => TasksError(error.toString()),
    );
  }

  void _onTasksUpdated(
    TasksUpdated event,
    Emitter<TasksState> emit,
  ) {
    emit(TasksLoaded(event.tasks));
  }

  Future<void> _onAddTaskRequested(
    AddTaskRequested event,
    Emitter<TasksState> emit,
  ) async {
    try {
      await _momentumRepository.addTask(event.uid, event.task);
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> _onUpdateTaskRequested(
    UpdateTaskRequested event,
    Emitter<TasksState> emit,
  ) async {
    try {
      await _momentumRepository.updateTask(event.uid, event.task);
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> _onDeleteTaskRequested(
    DeleteTaskRequested event,
    Emitter<TasksState> emit,
  ) async {
    try {
      await _momentumRepository.deleteTask(event.uid, event.taskId);
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }
}

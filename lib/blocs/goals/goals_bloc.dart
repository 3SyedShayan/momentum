import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/goal_model.dart';
import '../../models/task_model.dart';
import '../../repositories/momentum_repository.dart';
import 'goals_event.dart';
import 'goals_state.dart';

class GoalsBloc extends Bloc<GoalsEvent, GoalsState> {
  final MomentumRepository _momentumRepository;
  StreamSubscription<List<GoalModel>>? _goalsSubscription;

  GoalsBloc({required MomentumRepository momentumRepository})
      : _momentumRepository = momentumRepository,
        super(GoalsInitial()) {
    on<SubscribeGoals>(_onSubscribeGoals);
    on<GoalsUpdated>(_onGoalsUpdated);
    on<AddGoalRequested>(_onAddGoalRequested);
    on<UpdateGoalRequested>(_onUpdateGoalRequested);
    on<DeleteGoalRequested>(_onDeleteGoalRequested);
    on<AddGoalToTodayRequested>(_onAddGoalToTodayRequested);
  }

  Future<void> _onSubscribeGoals(
    SubscribeGoals event,
    Emitter<GoalsState> emit,
  ) async {
    emit(GoalsLoading());
    await _goalsSubscription?.cancel();
    _goalsSubscription = _momentumRepository.getGoals(event.uid).listen(
      (goals) {
        add(GoalsUpdated(goals));
      },
      onError: (error) {
        emit(GoalsError(error.toString()));
      },
    );
  }

  void _onGoalsUpdated(
    GoalsUpdated event,
    Emitter<GoalsState> emit,
  ) {
    emit(GoalsLoaded(event.goals));
  }

  Future<void> _onAddGoalRequested(
    AddGoalRequested event,
    Emitter<GoalsState> emit,
  ) async {
    try {
      await _momentumRepository.addGoal(event.uid, event.goal);
    } catch (e) {
      emit(GoalsError(e.toString()));
    }
  }

  Future<void> _onUpdateGoalRequested(
    UpdateGoalRequested event,
    Emitter<GoalsState> emit,
  ) async {
    try {
      await _momentumRepository.updateGoal(event.uid, event.goal);
    } catch (e) {
      emit(GoalsError(e.toString()));
    }
  }

  Future<void> _onDeleteGoalRequested(
    DeleteGoalRequested event,
    Emitter<GoalsState> emit,
  ) async {
    try {
      await _momentumRepository.deleteGoal(event.uid, event.goalId);
    } catch (e) {
      emit(GoalsError(e.toString()));
    }
  }

  Future<void> _onAddGoalToTodayRequested(
    AddGoalToTodayRequested event,
    Emitter<GoalsState> emit,
  ) async {
    try {
      final updatedGoal = event.goal.copyWith(
        completedSessions: (event.goal.completedSessions + 1).clamp(0, event.goal.totalSessions),
      );
      await _momentumRepository.updateGoal(event.uid, updatedGoal);

      final now = DateTime.now();
      final newTask = TaskModel(
        id: '',
        title: 'Session: ${event.goal.title}',
        categoryId: event.goal.categoryId,
        startTime: DateTime(now.year, now.month, now.day, now.hour + 1, 0),
        endTime: DateTime(now.year, now.month, now.day, now.hour + 2, 0),
        isCompleted: false,
        durationPlanned: 60,
        durationCompleted: 0,
      );
      await _momentumRepository.addTask(event.uid, newTask);
    } catch (e) {
      emit(GoalsError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _goalsSubscription?.cancel();
    return super.close();
  }
}

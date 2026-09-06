import 'package:freezed_annotation/freezed_annotation.dart';
part 'task_stats.freezed.dart';

@freezed
abstract class DayTaskStats with _$DayTaskStats {
  const factory DayTaskStats({
    @Default(0.0) double completionPercentage,
    @Default(0.0) double plannedHours,
    @Default(0.0) double completedHours,
    @Default(0.0) double remainingHours,
  }) = _DayTaskStats;
}

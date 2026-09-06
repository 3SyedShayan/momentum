part of 'home.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [bool listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  Stream<TaskX?> watchNextTask({DateTime? currentTime}) {
    final now = currentTime ?? DateTime.now();
    return TaskRepo.ins.watchAllTasks(now).map((tasks) {
      return _findNextTask(tasks, now);
    });
  }

  Future<TaskX?> getNextTask({DateTime? currentTime}) async {
    final now = currentTime ?? DateTime.now();
    final tasks = await TaskRepo.ins.watchAllTasks(now).first;
    return _findNextTask(tasks, now);
  }

  TaskX? _findNextTask(List<TaskX> tasks, DateTime now) {
    for (final task in tasks) {
      if (task.isCompleted) continue;
      if (task.endTime.isAfter(now)) {
        return task;
      }
    }
    return null;
  }

  String formatTime(DateTime time) {
    final hour = time.hour > 12
        ? time.hour - 12
        : (time.hour == 0 ? 12 : time.hour);
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  String formatTaskTimeRange(TaskX task) {
    return '${formatTime(task.startTime)} – ${formatTime(task.endTime)}';
  }

  String getTaskCountdown(TaskX task, [DateTime? currentTime]) {
    final now = currentTime ?? DateTime.now();
    if (now.isBefore(task.startTime)) {
      final diff = task.startTime.difference(now);
      if (diff.inHours > 0) {
        final hours = diff.inHours;
        final mins = diff.inMinutes % 60;
        return mins > 0
            ? 'Starts in ${hours}h ${mins}m'
            : 'Starts in ${hours}h';
      } else if (diff.inMinutes > 0) {
        return 'Starts in ${diff.inMinutes}m';
      } else {
        return 'Starts soon';
      }
    } else if (now.isBefore(task.endTime)) {
      final diff = task.endTime.difference(now);
      if (diff.inHours > 0) {
        return 'Ends in ${diff.inHours}h ${diff.inMinutes % 60}m';
      } else if (diff.inMinutes > 0) {
        return 'Ends in ${diff.inMinutes}m';
      } else {
        return 'In progress';
      }
    }
    return 'Completed';
  }
}

part of 'task.dart';

class _TaskState extends ChangeNotifier {
  static _TaskState s(BuildContext context, [bool listen = false]) =>
      Provider.of<_TaskState>(context, listen: listen);

  List<TaskX> tasks = [];
}

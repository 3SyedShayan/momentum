part of '../task.dart';

class _FloatingButton extends StatelessWidget {
  const _FloatingButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => AddTaskModal.show(context),
      child: const Icon(Icons.add),
    );
  }
}

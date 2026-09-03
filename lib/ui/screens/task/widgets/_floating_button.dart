part of '../task.dart';

class _FloatingButton extends StatelessWidget {
  const _FloatingButton();

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context, true);
    if (!state.canAddTask) return const SizedBox.shrink();

    return FloatingActionButton(
      onPressed: () => AddTaskModal.show(context),
      child: const Icon(Icons.add),
    );
  }
}

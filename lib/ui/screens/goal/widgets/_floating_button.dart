part of '../goal.dart';

class _FloatingButton extends StatelessWidget {
  const _FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => AddGoal.show(context),
      child: Icon(Icons.add),
    );
  }
}

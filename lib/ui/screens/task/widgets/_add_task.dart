part of '../task.dart';

class AddTaskModal extends StatefulWidget {
  final int? initialStartHour;
  final int? initialEndHour;

  const AddTaskModal({
    super.key,
    this.initialStartHour,
    this.initialEndHour,
  });

  static Future<void> show(
    BuildContext context, {
    int? initialStartHour,
    int? initialEndHour,
  }) {
    final state = _ScreenState.s(context);

    if (!state.canAddTask) return Future.value();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ChangeNotifierProvider.value(
        value: state,
        child: AddTaskModal(
          initialStartHour: initialStartHour,
          initialEndHour: initialEndHour,
        ),
      ),
    );
  }

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  int startHour = 9;
  int endHour = 10;
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    final state = _ScreenState.s(context);

    return StreamBuilder<List<TaskX>>(
      stream: state.watchAllTasks(state.selectedDate),
      builder: (context, snapshot) {
        final tasks = snapshot.data ?? [];
        final occupiedHours = state.getOccupiedHours(tasks);
        final pastHours = state.getPastHours();
        if (!_initialized) {
          _initialized = true;
          final initial = state.getInitialTaskHours(
            initialStartHour: widget.initialStartHour,
            initialEndHour: widget.initialEndHour,
            occupiedHours: occupiedHours,
            pastHours: pastHours,
          );
          startHour = initial.startHour;
          endHour = initial.endHour;
        }

        final availableEnds = state.getAvailableEndHours(
          startHour,
          occupiedHours,
        );
        final disabledEnds = List.generate(
          25,
          (i) => i,
        ).where((h) => !availableEnds.contains(h)).toSet();

        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: FormBuilder(
            key: state.taskFormKey,
            initialValue: _TaskFormData.initialTaskValues(),
            child: Padding(
              padding: Space.a.t20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Add New Task', style: AppText.h2),
                  Space.y.t16,
                  AppFormTextInput(
                    name: _TaskFormKeys.title,
                    heading: 'Task Title',
                    placeholder: 'e.g., Flutter Dev, Workout',
                    validators: FormBuilderValidators.required(),
                  ),
                  Space.y.t16,
                  AppFormTextInput(
                    name: _TaskFormKeys.description,
                    heading: 'Description (Optional)',
                    placeholder: 'e.g., Focus on UI refactor',
                  ),
                  Space.y.t16,
                  FormBuilderField<CategoryX>(
                    name: _TaskFormKeys.category,
                    validator: FormBuilderValidators.required(
                      errorText: 'Please select a category',
                    ),
                    builder: (field) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Category', style: AppText.b1b),
                          Space.y.t08,
                          StreamBuilder<List<CategoryX>>(
                            stream: state.watchAllCategories(),
                            builder: (context, snapshot) {
                              final categories = snapshot.data ?? [];
                              if (categories.isEmpty) {
                                return Text(
                                  'No categories available. Please create one first.',
                                  style: AppText.b2.cl(AppTheme.c.subText),
                                );
                              }

                              return Wrap(
                                spacing: SpaceToken.t08,
                                runSpacing: SpaceToken.t08,
                                children: categories.map((cat) {
                                  final isSelected = field.value?.id == cat.id;

                                  return GestureDetector(
                                    onTap: () => field.didChange(cat),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 150,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: SpaceToken.t12,
                                        vertical: SpaceToken.t08,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Color(
                                                cat.color,
                                              ).withValues(alpha: 0.15)
                                            : AppTheme.c.subBackground,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: isSelected
                                              ? Color(cat.color)
                                              : Colors.transparent,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Color(cat.color),
                                            radius: 5,
                                          ),
                                          Space.x.t08,
                                          Text(
                                            cat.name,
                                            style: AppText.b2
                                                .w(isSelected ? 6 : 4)
                                                .cl(
                                                  isSelected
                                                      ? AppTheme.c.text
                                                      : AppTheme.c.subText,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                          if (field.hasError) ...[
                            Space.y.t04,
                            Text(
                              field.errorText!,
                              style: AppText.b1.cl(Colors.red),
                            ),
                          ],
                        ],
                      );
                    },
                  ),
                  Space.y.t16,
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderField<DateTime>(
                          name: _TaskFormKeys.startTime,
                          initialValue: DateTime(
                            state.selectedDate.year,
                            state.selectedDate.month,
                            state.selectedDate.day,
                            startHour,
                            0,
                          ),
                          builder: (field) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Start Time', style: AppText.b1b),
                                Space.y.t08,
                                InkWell(
                                  onTap: () async {
                                    final pastHours = state.getPastHours();
                                    final hour = await HourPickerModal.show(
                                      context,
                                      initialHour: startHour,
                                      occupiedHours: occupiedHours,
                                      pastHours: pastHours,
                                      maxHour: 23,
                                      title: 'Select Start Hour',
                                    );
                                    if (hour != null) {
                                      setState(() {
                                        startHour = hour;
                                        final newAvailableEnds = state
                                            .getAvailableEndHours(
                                              hour,
                                              occupiedHours,
                                            );
                                        if (endHour <= hour ||
                                            !newAvailableEnds.contains(
                                              endHour,
                                            )) {
                                          endHour = newAvailableEnds.isNotEmpty
                                              ? newAvailableEnds.first
                                              : (hour + 1 <= 24
                                                  ? hour + 1
                                                  : 24);
                                        }
                                      });
                                      final selectedDate = state.selectedDate;
                                      field.didChange(
                                        DateTime(
                                          selectedDate.year,
                                          selectedDate.month,
                                          selectedDate.day,
                                          hour,
                                          0,
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: Space.a.t12,
                                    decoration: BoxDecoration(
                                      color: AppTheme.c.subBackground,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: AppTheme.c.border,
                                      ),
                                    ),
                                    child: Text(
                                      _ScreenState.formatHour(startHour),
                                      style: AppText.b1,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Space.x.t16,
                      Expanded(
                        child: FormBuilderField<DateTime>(
                          name: _TaskFormKeys.endTime,
                          initialValue: DateTime(
                            state.selectedDate.year,
                            state.selectedDate.month,
                            state.selectedDate.day,
                            endHour,
                            0,
                          ),
                          builder: (field) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('End Time', style: AppText.b1b),
                                Space.y.t08,
                                InkWell(
                                  onTap: () async {
                                    final pastHours = state.getPastHours();
                                    final hour = await HourPickerModal.show(
                                      context,
                                      initialHour: endHour,
                                      disabledHours: disabledEnds,
                                      occupiedHours: occupiedHours,
                                      pastHours: pastHours,
                                      maxHour: 24,
                                      title: 'Select End Hour',
                                    );
                                    if (hour != null) {
                                      setState(() => endHour = hour);
                                      final selectedDate = state.selectedDate;
                                      field.didChange(
                                        DateTime(
                                          selectedDate.year,
                                          selectedDate.month,
                                          selectedDate.day,
                                          hour,
                                          0,
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: Space.a.t12,
                                    decoration: BoxDecoration(
                                      color: AppTheme.c.subBackground,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: AppTheme.c.border,
                                      ),
                                    ),
                                    child: Text(
                                      _ScreenState.formatHour(endHour),
                                      style: AppText.b1,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Space.y.t24,
                  AppButton(
                    label: 'Save Task',
                    onTap: () => state.submitAddTask(
                      context,
                      startHour: startHour,
                      endHour: endHour,
                      occupiedHours: occupiedHours,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

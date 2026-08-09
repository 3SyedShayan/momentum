part of '../forms.dart';

class AppIconOption {
  final String key;
  final IconData icon;
  final String? label;

  const AppIconOption({required this.key, required this.icon, this.label});
}

class AppFormIconInput extends StatelessWidget {
  const AppFormIconInput({
    super.key,
    required this.name,
    required this.icons,
    this.initialValue,
    this.onChanged,
    this.heading,
    this.subHeading,
    this.placeholder,
    this.sideInput = false,
    this.state = AppFormState.def,
    this.margin,
    this.suffixIcon = LucideIcons.chevron_down,
    this.validators,
  });

  final String name;
  final String? initialValue;
  final List<AppIconOption> icons;
  final void Function(String?)? onChanged;
  final String? heading;
  final String? subHeading;
  final String? placeholder;
  final bool sideInput;
  final AppFormState state;
  final EdgeInsets? margin;
  final IconData? suffixIcon;
  final FormFieldValidator<String>? validators;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: name,
      initialValue: initialValue,
      validator: validators,
      onChanged: onChanged,
      builder: (field) {
        return AppFormIconInputContent(
          heading: heading,
          subHeading: subHeading,
          placeholder: placeholder,
          sideInput: sideInput,
          state: state,
          margin: margin,
          suffixIcon: suffixIcon,
          icons: icons,
          initialValue: field.value,
          onChanged: field.didChange,
          fieldState: field,
        );
      },
    );
  }
}

class AppFormIconInputContent extends StatefulWidget {
  const AppFormIconInputContent({
    super.key,
    required this.icons,
    this.initialValue,
    this.onChanged,
    this.heading,
    this.subHeading,
    this.placeholder,
    this.sideInput = false,
    this.state = AppFormState.def,
    this.margin,
    this.suffixIcon = LucideIcons.chevron_down,
    this.fieldState,
  });

  final List<AppIconOption> icons;
  final String? initialValue;
  final void Function(String?)? onChanged;
  final String? heading;
  final String? subHeading;
  final String? placeholder;
  final bool sideInput;
  final AppFormState state;
  final EdgeInsets? margin;
  final IconData? suffixIcon;
  final FormFieldState<String>? fieldState;

  @override
  State<AppFormIconInputContent> createState() =>
      _AppFormIconInputContentState();
}

class _AppFormIconInputContentState extends State<AppFormIconInputContent> {
  late TextEditingController _controller;
  IconData? _selectedIconData;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _updateControllerValue(widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant AppFormIconInputContent oldWidget) {
    if (oldWidget.initialValue != widget.initialValue) {
      _updateControllerValue(widget.initialValue);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _updateControllerValue(String? key) {
    if (key != null && key.isNotEmpty) {
      final match = widget.icons.firstWhere(
        (e) => e.key == key,
        orElse: () => widget.icons.first,
      );
      _controller.text = match.label ?? match.key;
      _selectedIconData = match.icon;
    } else {
      _controller.clear();
      _selectedIconData = null;
    }
  }

  Future<void> _handleTap() async {
    final selectedKey = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) {
        return Container(
          padding: Space.a.t20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select Icon', style: AppText.h3),
              Space.y.t16,
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.icons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (_, index) {
                  final option = widget.icons[index];
                  final isSelected = option.key == widget.initialValue;

                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => Navigator.pop(modalContext, option.key),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.c.primary.withValues(alpha: 0.15)
                            : AppTheme.c.specBackground,
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.c.primary
                              : AppTheme.c.border,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        option.icon,
                        color: isSelected
                            ? AppTheme.c.primary
                            : AppTheme.c.text,
                        size: 26,
                      ),
                    ),
                  );
                },
              ),
              Space.y.t16,
            ],
          ),
        );
      },
    );

    if (selectedKey != null) {
      _updateControllerValue(selectedKey);
      if (widget.onChanged != null) {
        widget.onChanged!(selectedKey);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: AppFormTextInputContent<String>(
        onTap: _handleTap,
        readOnly: true,
        controller: _controller,
        state: widget.state,
        fieldState: widget.fieldState,
        placeholder: widget.placeholder,
        heading: widget.heading,
        subHeading: widget.subHeading,
        sideInput: widget.sideInput,
        prefixIcon: _selectedIconData,
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}

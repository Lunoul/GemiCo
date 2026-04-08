import 'package:flutter/material.dart';
import 'package:gemico/core/theme/app_colors.dart';
import 'package:gemico/features/chat/chat_mode.dart';

class ModeSelector extends StatelessWidget {
  const ModeSelector({
    super.key,
    required this.currentMode,
    required this.onChanged,
    required this.defaultLabel,
    required this.plus18Label,
  });

  final ChatMode currentMode;
  final ValueChanged<ChatMode> onChanged;
  final String defaultLabel;
  final String plus18Label;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ChatMode>(
      showSelectedIcon: false,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.segmentedSelected;
          }
          return AppColors.segmentedUnselected;
        }),
        side: WidgetStateProperty.all(
          const BorderSide(
            color: AppColors.segmentedBorder,
            width: 1,
          ),
        ),
        foregroundColor: WidgetStateProperty.all(AppColors.primaryFg),
      ),
      segments: [
        ButtonSegment(
          value: ChatMode.defaultMode,
          label: Text(defaultLabel),
        ),
        ButtonSegment(
          value: ChatMode.plus18,
          label: Text(plus18Label),
        ),
      ],
      selected: {currentMode},
      onSelectionChanged: (selected) {
        if (selected.isNotEmpty) {
          onChanged(selected.first);
        }
      },
    );
  }
}

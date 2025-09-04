import 'package:flutter/material.dart';
import 'styles/date_range_select_step_styles.dart';
import '../../../../core/i18n/strings.dart';

class DateRangeSelectStep extends StatelessWidget {
  final DateTimeRange? selectedRange;
  final ValueChanged<DateTimeRange> onRangeSelected;
  const DateRangeSelectStep({
    super.key,
    required this.selectedRange,
    required this.onRangeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.Plan.selectDateRangeTitle,
          style: DateRangeSelectStepStyles.titleStyle,
        ),
        DateRangeSelectStepStyles.titleSpacing,
        OutlinedButton.icon(
          onPressed: () async {
            final now = DateTime.now();
            final picked = await showDateRangePicker(
              context: context,
              firstDate: DateTime(now.year - 1),
              lastDate: DateTime(now.year + 2),
            );
            if (picked != null) onRangeSelected(picked);
          },
          icon: const Icon(Icons.date_range),
          label: Text(
            selectedRange == null
                ? '기간 선택'
                : '${selectedRange!.start.year}.${selectedRange!.start.month}.${selectedRange!.start.day} ~ ${selectedRange!.end.year}.${selectedRange!.end.month}.${selectedRange!.end.day}',
          ),
          style: DateRangeSelectStepStyles.buttonStyle(context),
        ),
      ],
    );
  }
}

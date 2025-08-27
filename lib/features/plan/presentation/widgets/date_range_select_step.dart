import 'package:flutter/material.dart';
import '../../../../core/widgets/date_range_picker.dart';
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
    return DateRangePicker(
      initialRange: selectedRange,
      onRangeSelected: onRangeSelected,
      title: Strings.Plan.selectDateRangeTitle,
    );
  }
}

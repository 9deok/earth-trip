import 'package:flutter/material.dart';
import '../../../../core/widgets/date_range_picker.dart';

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
      title: '여행 일정을 선택하세요',
    );
  }
}

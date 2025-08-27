import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DateRangePicker extends StatefulWidget {
  final DateTimeRange? initialRange;
  final ValueChanged<DateTimeRange> onRangeSelected;
  final DateTime? firstDay;
  final DateTime? lastDay;
  final String? title;

  const DateRangePicker({
    super.key,
    required this.initialRange,
    required this.onRangeSelected,
    this.firstDay,
    this.lastDay,
    this.title,
  });

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    if (widget.initialRange != null) {
      _rangeStart = widget.initialRange!.start;
      _rangeEnd = widget.initialRange!.end;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('yyyy-MM-dd');
    final now = DateTime.now();
    final first = widget.firstDay ?? now;
    final last = widget.lastDay ?? DateTime(now.year + 2, 12, 31);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        if (widget.title != null) const SizedBox(height: 24),
        if (_rangeStart != null)
          Text(
            _rangeEnd == null
                ? dateFmt.format(_rangeStart!)
                : '${dateFmt.format(_rangeStart!)} ~ ${dateFmt.format(_rangeEnd!)}',
            style: const TextStyle(fontSize: 16),
          ),
        const SizedBox(height: 16),
        Expanded(
          child: TableCalendar(
            firstDay: first,
            lastDay: last,
            focusedDay: _rangeStart ?? now,
            calendarFormat: CalendarFormat.month,
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            onRangeSelected: (start, end, focusedDay) {
              setState(() {
                _rangeStart = start;
                _rangeEnd = end;
                if (_rangeStart != null && _rangeEnd != null) {
                  widget.onRangeSelected(
                    DateTimeRange(start: _rangeStart!, end: _rangeEnd!),
                  );
                }
              });
            },
            rangeSelectionMode: RangeSelectionMode.enforced,
            calendarStyle: const CalendarStyle(
              rangeHighlightColor: Colors.greenAccent,
              rangeStartDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              rangeEndDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

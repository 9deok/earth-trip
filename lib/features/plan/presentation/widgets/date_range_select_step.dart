import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DateRangeSelectStep extends StatefulWidget {
  final DateTimeRange? selectedRange;
  final ValueChanged<DateTimeRange> onRangeSelected;

  const DateRangeSelectStep({
    super.key,
    required this.selectedRange,
    required this.onRangeSelected,
  });

  @override
  State<DateRangeSelectStep> createState() => _DateRangeSelectStepState();
}

class _DateRangeSelectStepState extends State<DateRangeSelectStep> {
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    if (widget.selectedRange != null) {
      _rangeStart = widget.selectedRange!.start;
      _rangeEnd = widget.selectedRange!.end;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('yyyy-MM-dd');
    final now = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '여행 일정을 선택하세요',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
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
            firstDay: now,
            lastDay: DateTime(now.year + 2, 12, 31),
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
        // 일정 선택완료 버튼 제거
        // if (_rangeStart != null && _rangeEnd != null)
        //   Center(
        //     child: ElevatedButton(
        //       onPressed: () {
        //         widget.onRangeSelected(
        //           DateTimeRange(start: _rangeStart!, end: _rangeEnd!),
        //         );
        //       },
        //       child: const Text('일정 선택완료'),
        //     ),
        //   ),
      ],
    );
  }
}

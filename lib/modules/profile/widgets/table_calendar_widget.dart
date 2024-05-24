import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarWidget extends StatefulWidget {
  const TableCalendarWidget({
    super.key,
    required this.start,
    required this.end,
  });
  final DateTime start;
  final DateTime end;

  @override
  State<TableCalendarWidget> createState() => _TableCalendarWidgetState();
}

class _TableCalendarWidgetState extends State<TableCalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    // Future.microtask(
    //   () => _onRangeSelected(
    //     widget.start,
    //     widget.end,
    //     DateTime.now(),
    //   ),
    // );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.gray80, width: 1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: TableCalendar(
        availableGestures: AvailableGestures.horizontalSwipe,
        firstDay: DateTime.utc(2024, 1, 1),
        lastDay: DateTime.utc(2030, 1, 1),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        calendarFormat: _calendarFormat,
        startingDayOfWeek: StartingDayOfWeek.monday,
        // onDaySelected: _onDaySelected,
        rangeSelectionMode: RangeSelectionMode.toggledOff,
        rangeStartDay: widget.start,
        rangeEndDay: widget.end,

        rowHeight: 45,
        formatAnimationCurve: Curves.bounceIn,
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
          ),
          formatButtonDecoration: BoxDecoration(
            border: Border.all(color: AppColors.primary20, width: 1),
          ),
          formatButtonShowsNext: true,
        ),
        headerVisible: true,
        calendarStyle: const CalendarStyle(
          rangeHighlightColor: AppColors.secondary60,
          rangeHighlightScale: 1,
          rangeEndTextStyle: const TextStyle(color: Colors.white),
          rangeStartTextStyle: const TextStyle(color: Colors.white),
          rangeStartDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondary20,
          ),
          rangeEndDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondary20,
          ),
          outsideDaysVisible: false,
          defaultTextStyle: TextStyle(
            color: Colors.black,
          ),
          todayTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          todayDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary50,
          ),
          selectedTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          selectedDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary40,
          ),
        ),
      ),
    );
  }
}

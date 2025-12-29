import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthCalendarWidget extends StatelessWidget {
  final int year;
  final int month;
  final Map<DateTime, bool> trackingData;
  final ValueChanged<DateTime>? onDayTap;

  const MonthCalendarWidget({
    super.key,
    required this.year,
    required this.month,
    required this.trackingData,
    this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(year, month, 1);
    final lastDayOfMonth = DateTime(year, month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    // DateTime.weekday: 1=Monday, 7=Sunday
    // We want: 0=Sunday, 1=Monday, ..., 6=Saturday
    final firstWeekday = firstDayOfMonth.weekday % 7; // Convert to 0-6 where 0=Sunday
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    // Weekday headers (Sun-Sat)
    const weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Month name
            Text(
              DateFormat('MMMM').format(firstDayOfMonth),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            // Weekday headers
            Row(
              children: weekdays.map((day) {
                return Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 4),
            // Calendar grid
            ...List.generate(
              (daysInMonth + firstWeekday + 6) ~/ 7,
              (weekIndex) {
                return Row(
                  children: List.generate(7, (dayIndex) {
                    final dayNumber = weekIndex * 7 + dayIndex - firstWeekday + 1;
                    
                    if (dayNumber < 1 || dayNumber > daysInMonth) {
                      // Empty cell
                      return const Expanded(child: SizedBox());
                    }

                    final date = DateTime(year, month, dayNumber);
                    final dateOnly = DateTime(date.year, date.month, date.day);
                    final isFuture = dateOnly.isAfter(todayDate);
                    final isTracked = trackingData[dateOnly] ?? false;
                    final isToday = dateOnly.isAtSameMomentAs(todayDate);

                    Color cellColor;
                    if (isFuture) {
                      cellColor = Colors.grey.shade300; // Gray for future
                    } else if (isTracked) {
                      cellColor = Colors.green.shade400; // Green for tracked
                    } else {
                      cellColor = Colors.red.shade300; // Red for missed
                    }

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: InkWell(
                          onTap: isFuture
                              ? null
                              : () {
                                  // Call callback with the date
                                  onDayTap?.call(dateOnly);
                                },
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            height: 32,
                            decoration: BoxDecoration(
                              color: cellColor,
                              borderRadius: BorderRadius.circular(4),
                              border: isToday
                                  ? Border.all(
                                      color: Theme.of(context).colorScheme.primary,
                                      width: 2,
                                    )
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                dayNumber.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isToday
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isFuture
                                      ? Colors.grey.shade600
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


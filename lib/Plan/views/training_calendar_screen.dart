// lib/features/training_calendar/screens/training_calendar_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_syed_ameen_gillani/Plan/Model/workout_model.dart';
import 'package:task_syed_ameen_gillani/Plan/provider/workout_provider.dart';
import 'package:task_syed_ameen_gillani/Plan/widgets/draggable_day_row_widget.dart';
import 'package:task_syed_ameen_gillani/core/constants/app_colors.dart';
import 'package:task_syed_ameen_gillani/core/constants/app_fonts.dart';
import 'package:task_syed_ameen_gillani/Home/provider/hydration_provider.dart';

class TrainingCalendarScreen extends ConsumerWidget {
  const TrainingCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeks = ref.watch(workoutProvider);
    final hydrationState = ref.watch(hydrationProvider);
    final weekDates = ref.read(hydrationProvider.notifier).getWeekDates();

    final currentWeekTitle =
        'Week ${hydrationState.currentWeek}/${hydrationState.totalWeeks}';
    final currentWeekDateRange = _formatWeekDateRange(weekDates);

    final nextWeekDates =
        weekDates.map((date) => date.add(const Duration(days: 7))).toList();
    final nextWeekIndex = hydrationState.currentWeek + 1;
    final nextWeekTitle = nextWeekIndex <= hydrationState.totalWeeks
        ? 'Week $nextWeekIndex/${hydrationState.totalWeeks}'
        : null;
    final nextWeekDateRange = _formatWeekDateRange(nextWeekDates);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Training Calendar",
                    style: AppTextStyles.mulishRegular24,
                  ),
                  Text(
                    "Save",
                    style: AppTextStyles.mulishBold18.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Render all weeks dynamically
                    for (int weekIndex = 0; weekIndex < weeks.length; weekIndex++)
                      _buildWeekSection(
                        weeks[weekIndex],
                        weekIndex,
                        weekIndex == 0,
                        overrideWeekTitle: weekIndex == 0
                            ? currentWeekTitle
                            : (weekIndex == 1 ? nextWeekTitle : null),
                        overrideDateRange: weekIndex == 0
                            ? currentWeekDateRange
                            : (weekIndex == 1 ? nextWeekDateRange : null),
                        overrideWeekDates: weekIndex == 0
                            ? weekDates
                            : (weekIndex == 1 ? nextWeekDates : null),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekSection(
    dynamic week,
    int weekIndex,
    bool isFirst, {
    String? overrideWeekTitle,
    String? overrideDateRange,
    List<DateTime>? overrideWeekDates,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top divider
        Container(
          height: 2.h,
          width: double.infinity,
          color: isFirst ? AppColors.accentBlue : Color(0xff18AA99),
        ),

        // Week Header
        Container(
          color: const Color(0xFF1C1C1E),
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            top: 16.h,
            bottom: 8.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                overrideWeekTitle ?? week.weekTitle,
                style: AppTextStyles.mulishBold18,
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    overrideDateRange ?? week.dateRange,
                    style: AppTextStyles.mulishRegular16.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                  Text(
                    week.totalDuration,
                    style: AppTextStyles.mulishRegular16.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Days List
        if (week.days.isNotEmpty) ...[
          SizedBox(height: 12.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                for (int dayIndex = 0; dayIndex < week.days.length; dayIndex++)
                  DragTargetDayRow(
                    day: _buildDisplayDay(
                      week.days[dayIndex],
                      overrideWeekDates != null &&
                              dayIndex < overrideWeekDates.length
                          ? overrideWeekDates[dayIndex]
                          : null,
                    ),
                    weekIndex: weekIndex,
                    dayIndex: dayIndex,
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  String _formatWeekDateRange(List<DateTime> weekDates) {
    if (weekDates.isEmpty) return '';

    final start = weekDates.first;
    final end = weekDates.last;

    if (start.month == end.month) {
      // Match existing style: "December 8-14"
      return '${_monthName(start.month)} ${start.day}-${end.day}';
    } else {
      // Cross-month week: "Dec 30 - Jan 5"
      return '${_monthName(start.month)} ${start.day} - ${_monthName(end.month)} ${end.day}';
    }
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    if (month < 1 || month > 12) return '';
    // Existing text uses full "December", but shorter labels are acceptable stylistically.
    // To keep closer to "December", expand here if needed.
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return months[month - 1];
    }
  }

  DayModel _buildDisplayDay(DayModel original, DateTime? date) {
    if (date == null) return original;

    return original.copyWith(
      day: _weekdayLabel(date.weekday),
      date: '${date.day}',
    );
  }

  String _weekdayLabel(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }
}
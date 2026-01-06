// lib/Home/widgets/calendar_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_syed_ameen_gillani/core/constants/app_colors.dart';
import 'package:task_syed_ameen_gillani/core/constants/app_fonts.dart';
import 'package:task_syed_ameen_gillani/Home/provider/hydration_provider.dart';

class CalendarBottomSheet extends ConsumerStatefulWidget {
  const CalendarBottomSheet({super.key});

  @override
  ConsumerState<CalendarBottomSheet> createState() =>
      _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends ConsumerState<CalendarBottomSheet> {
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    final selectedDate = ref.read(hydrationProvider).selectedDate;
    _currentMonth = DateTime(selectedDate.year, selectedDate.month, 1);
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  List<DateTime?> _generateCalendarDays() {
    final firstDay = _currentMonth;
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final firstWeekday = firstDay.weekday;

    List<DateTime?> days = [];

    // Add empty cells for days before the first day of month
    for (int i = 1; i < firstWeekday; i++) {
      days.add(null);
    }

    // Add actual days of the month
    for (int day = 1; day <= lastDay.day; day++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, day));
    }

    return days;
  }

  String _getMonthYearString() {
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
      'Dec'
    ];
    return '${months[_currentMonth.month - 1]} ${_currentMonth.year}';
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(hydrationProvider).selectedDate;
    final calendarDays = _generateCalendarDays();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle Bar
          Container(
            width: 48.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.textSecondary,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),

          // Header (Month Navigation)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: _previousMonth,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 16.sp,
                ),
              ),
              Text(
                _getMonthYearString(),
                style: AppTextStyles.mulishBold16,
              ),
              GestureDetector(
                onTap: _nextMonth,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 16.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Days of Week
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
                .map(
                  (day) => Center(
                    child: Text(
                      day,
                      style: AppTextStyles.mulishBold12.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 16.h),

          // Calendar Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: calendarDays.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final date = calendarDays[index];
              
              if (date == null) {
                return const SizedBox.shrink();
              }

              final isSelected = date.year == selectedDate.year &&
                  date.month == selectedDate.month &&
                  date.day == selectedDate.day;

              return GestureDetector(
                onTap: () {
                  ref.read(hydrationProvider.notifier).selectDate(date);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? AppColors.primaryGreen.withOpacity(0.2)
                        : Colors.transparent,
                    border: isSelected
                        ? Border.all(color: AppColors.primaryGreen, width: 2)
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "${date.day}",
                    style: AppTextStyles.mulishBold14.copyWith(
                      color: Colors.white,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
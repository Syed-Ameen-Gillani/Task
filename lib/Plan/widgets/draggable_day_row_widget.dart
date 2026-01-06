// lib/features/training_calendar/widgets/drag_target_day_row.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_syed_ameen_gillani/Plan/Model/workout_model.dart';
import 'package:task_syed_ameen_gillani/Plan/provider/workout_provider.dart';
import 'package:task_syed_ameen_gillani/Plan/widgets/draggable_workout_widget.dart';
import 'package:task_syed_ameen_gillani/core/constants/app_colors.dart';
import 'package:task_syed_ameen_gillani/core/constants/app_fonts.dart';

class DragTargetDayRow extends ConsumerWidget {
  final DayModel day;
  final int weekIndex;
  final int dayIndex;

  const DragTargetDayRow({
    super.key,
    required this.day,
    required this.weekIndex,
    required this.dayIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color textColor = day.workout != null
        ? const Color(0xffEBEBEB)
        : AppColors.textTertiary;

    return DragTarget<Map<String, dynamic>>(
      onWillAcceptWithDetails: (details) {
        final data = details.data;
        final fromWeekIndex = data['fromWeekIndex'] as int;
        final fromDayIndex = data['fromDayIndex'] as int;
        
        // Check if it's the same position
        final isSamePosition = fromWeekIndex == weekIndex && fromDayIndex == dayIndex;
        
        // Only accept if the day is empty OR if it's being moved from the same position
        return day.workout == null || isSamePosition;
      },
      onAcceptWithDetails: (details) {
        final data = details.data;
        final fromWeekIndex = data['fromWeekIndex'] as int;
        final fromDayIndex = data['fromDayIndex'] as int;

        // Only move if it's not the same position
        if (fromWeekIndex != weekIndex || fromDayIndex != dayIndex) {
          ref.read(workoutProvider.notifier).moveWorkout(
                fromWeekIndex: fromWeekIndex,
                fromDayIndex: fromDayIndex,
                toWeekIndex: weekIndex,
                toDayIndex: dayIndex,
              );
        }
      },
      builder: (context, candidateData, rejectedData) {
        final bool isHovering = candidateData.isNotEmpty;
        final bool isRejected = rejectedData.isNotEmpty;
        final bool hasWorkout = day.workout != null;

        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xff282A39), width: 1),
            ),
            color: isRejected
                ? Colors.red.withOpacity(0.1)
                : isHovering
                    ? AppColors.accentBlue.withOpacity(0.1)
                    : Colors.transparent,
          ),
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Date Column
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day.day,
                      style: AppTextStyles.mulishBold14.copyWith(
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      day.date,
                      style: AppTextStyles.mulishRegular20.copyWith(
                        color: textColor,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),

              // Workout Card or Empty Space
              if (day.workout != null)
                Expanded(
                  child: DraggableWorkoutCard(
                    workout: day.workout!,
                    weekIndex: weekIndex,
                    dayIndex: dayIndex,
                  ),
                )
              else
                Expanded(
                  child: Container(
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: isHovering
                          ? AppColors.cardBackgroundDark.withOpacity(0.3)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                      border: isHovering
                          ? Border.all(
                              color: AppColors.accentBlue.withOpacity(0.5),
                              width: 2,
                            )
                          : null,
                    ),
                    child: isHovering
                        ? Center(
                            child: Icon(
                              Icons.add_circle_outline,
                              color: AppColors.accentBlue.withOpacity(0.5),
                              size: 24.w,
                            ),
                          )
                        : null,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
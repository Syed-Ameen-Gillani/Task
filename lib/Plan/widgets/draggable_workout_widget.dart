// lib/features/training_calendar/widgets/draggable_workout_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_syed_ameen_gillani/Plan/Model/workout_model.dart';
import 'package:task_syed_ameen_gillani/core/constants/app_assets.dart';
import 'package:task_syed_ameen_gillani/core/constants/app_colors.dart';
import 'package:task_syed_ameen_gillani/core/constants/app_fonts.dart';

class DraggableWorkoutCard extends StatelessWidget {
  final WorkoutModel workout;
  final int weekIndex;
  final int dayIndex;
  final VoidCallback? onDragStarted;
  final VoidCallback? onDragEnd;

  const DraggableWorkoutCard({
    super.key,
    required this.workout,
    required this.weekIndex,
    required this.dayIndex,
    this.onDragStarted,
    this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundDark,
        borderRadius: BorderRadius.circular(8.r),
        border: Border(
          left: BorderSide(color: Colors.white, width: 7.w),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Draggable Icon
          Draggable<Map<String, dynamic>>(
            data: {
              'workout': workout,
              'fromWeekIndex': weekIndex,
              'fromDayIndex': dayIndex,
            },
            feedback: Material(
              color: Colors.transparent,
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  width: MediaQuery.of(context).size.width - 120.w,
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackgroundDark,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border(
                      left: BorderSide(color: Colors.white, width: 7.w),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: _buildCardContent(),
                ),
              ),
            ),
            childWhenDragging: Opacity(
              opacity: 0.3,
              child: SvgPicture.asset(AppAssets.dragIcon),
            ),
            onDragStarted: onDragStarted,
            onDragEnd: (_) => onDragEnd?.call(),
            child: SvgPicture.asset(AppAssets.dragIcon),
          ),
          
          // Card Content (Not Draggable)
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: workout.tagColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          workout.iconAsset,
                          width: 12.w,
                          height: 12.h,
                          colorFilter: ColorFilter.mode(
                            workout.tagColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          workout.tag,
                          style: AppTextStyles.mulishSemiBold10.copyWith(
                            color: workout.tagColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        workout.title,
                        style: AppTextStyles.mulishRegular14.copyWith(
                          color: Color(0xffFBFBFB),
                        ),
                      ),
                      Text(
                        workout.duration,
                        style: AppTextStyles.mulishRegular14.copyWith(
                          color: Color(0xffFBFBFB),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(AppAssets.dragIcon),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: workout.tagColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        workout.iconAsset,
                        width: 12.w,
                        height: 12.h,
                        colorFilter: ColorFilter.mode(
                          workout.tagColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        workout.tag,
                        style: AppTextStyles.mulishSemiBold10.copyWith(
                          color: workout.tagColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      workout.title,
                      style: AppTextStyles.mulishRegular14.copyWith(
                        color: Color(0xffFBFBFB),
                      ),
                    ),
                    Text(
                      workout.duration,
                      style: AppTextStyles.mulishRegular14.copyWith(
                        color: Color(0xffFBFBFB),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
// lib/features/training_calendar/providers/workout_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_syed_ameen_gillani/Plan/Model/workout_model.dart';
import 'package:task_syed_ameen_gillani/core/constants/app_assets.dart';
import 'package:task_syed_ameen_gillani/core/constants/app_colors.dart';

class WorkoutNotifier extends StateNotifier<List<WeekModel>> {
  WorkoutNotifier() : super(_initialWeeks());

  static List<WeekModel> _initialWeeks() {
    return [
      WeekModel(
        weekTitle: "Week 2/8",
        dateRange: "December 8-14",
        totalDuration: "Total: 60min",
        days: [
          DayModel(
            day: "Mon",
            date: "8",
            workout: WorkoutModel(
              id: "workout_1",
              title: "Arm Blaster",
              tag: "Arms Workout",
              iconAsset: AppAssets.armWorkoutIcon,
              duration: "25m - 30m",
              tagColor: AppColors.primaryGreen,
            ),
          ),
          DayModel(day: "Tue", date: "9"),
          DayModel(day: "Wed", date: "10"),
          DayModel(
            day: "Thu",
            date: "11",
            workout: WorkoutModel(
              id: "workout_2",
              title: "Leg Day Blitz",
              tag: "Leg Workout",
              iconAsset: AppAssets.legWorkoutIcon,
              duration: "25m - 30m",
              tagColor: AppColors.accentPurple,
            ),
          ),
          DayModel(day: "Fri", date: "12"),
          DayModel(day: "Sat", date: "13"),
          DayModel(day: "Sun", date: "14"),
        ],
      ),
      WeekModel(
        weekTitle: "Week 2",
        dateRange: "December 14-22",
        totalDuration: "Total: 60min",
        days: [],
      ),
    ];
  }

  void moveWorkout({
    required int fromWeekIndex,
    required int fromDayIndex,
    required int toWeekIndex,
    required int toDayIndex,
  }) {
    final weeks = [...state];
    
    // Get the workout to move
    final workout = weeks[fromWeekIndex].days[fromDayIndex].workout;
    
    if (workout == null) return;

    // Remove workout from source
    final updatedFromDays = [...weeks[fromWeekIndex].days];
    updatedFromDays[fromDayIndex] = updatedFromDays[fromDayIndex].copyWith(
      clearWorkout: true,
    );
    weeks[fromWeekIndex] = weeks[fromWeekIndex].copyWith(days: updatedFromDays);

    // Add workout to destination (replace if exists)
    final updatedToDays = [...weeks[toWeekIndex].days];
    updatedToDays[toDayIndex] = updatedToDays[toDayIndex].copyWith(
      workout: workout,
    );
    weeks[toWeekIndex] = weeks[toWeekIndex].copyWith(days: updatedToDays);

    state = weeks;
  }

  void removeWorkout(int weekIndex, int dayIndex) {
    final weeks = [...state];
    final updatedDays = [...weeks[weekIndex].days];
    updatedDays[dayIndex] = updatedDays[dayIndex].copyWith(clearWorkout: true);
    weeks[weekIndex] = weeks[weekIndex].copyWith(days: updatedDays);
    state = weeks;
  }

  void addWorkout(int weekIndex, int dayIndex, WorkoutModel workout) {
    final weeks = [...state];
    final updatedDays = [...weeks[weekIndex].days];
    updatedDays[dayIndex] = updatedDays[dayIndex].copyWith(workout: workout);
    weeks[weekIndex] = weeks[weekIndex].copyWith(days: updatedDays);
    state = weeks;
  }
}

final workoutProvider = StateNotifierProvider<WorkoutNotifier, List<WeekModel>>(
  (ref) => WorkoutNotifier(),
);
// lib/Home/provider/hydration_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

class HydrationState {
  final int intake;
  final int goal;
  final DateTime selectedDate;
  final int currentWeek;
  final int totalWeeks;
  final bool isDaytime;

  HydrationState({
    required this.intake,
    required this.goal,
    required this.selectedDate,
    required this.currentWeek,
    required this.totalWeeks,
    required this.isDaytime,
  });

  HydrationState copyWith({
    int? intake,
    int? goal,
    DateTime? selectedDate,
    int? currentWeek,
    int? totalWeeks,
    bool? isDaytime,
  }) {
    return HydrationState(
      intake: intake ?? this.intake,
      goal: goal ?? this.goal,
      selectedDate: selectedDate ?? this.selectedDate,
      currentWeek: currentWeek ?? this.currentWeek,
      totalWeeks: totalWeeks ?? this.totalWeeks,
      isDaytime: isDaytime ?? this.isDaytime,
    );
  }
}

class HydrationNotifier extends StateNotifier<HydrationState> {
  HydrationNotifier()
      : super(HydrationState(
          intake: 0,
          goal: 4000,
          selectedDate: DateTime.now(),
          currentWeek: _getWeekOfMonth(DateTime.now()),
          totalWeeks: _getTotalWeeksInMonth(DateTime.now()),
          isDaytime: true,
        ));

  void logWater(int amount) {
    state = state.copyWith(intake: state.intake + amount);
  }

  void reset() {
    state = state.copyWith(intake: 0);
  }

  void selectDate(DateTime date) {
    final weekOfMonth = _getWeekOfMonth(date);
    final totalWeeks = _getTotalWeeksInMonth(date);
    
    state = state.copyWith(
      selectedDate: date,
      currentWeek: weekOfMonth,
      totalWeeks: totalWeeks,
    );
  }

  void setDaytime(bool isDaytime) {
    state = state.copyWith(isDaytime: isDaytime);
  }

  // Calculate which week of the month a date falls in
  static int _getWeekOfMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final firstWeekday = firstDayOfMonth.weekday;
    
    // Calculate day offset from Monday
    final daysSinceMonday = (date.day + firstWeekday - 2);
    final weekNumber = (daysSinceMonday / 7).floor() + 1;
    
    return weekNumber;
  }

  // Calculate total weeks in a month
  static int _getTotalWeeksInMonth(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    final lastDay = DateTime(date.year, date.month + 1, 0);
    
    final firstWeekday = firstDay.weekday;
    final totalDays = lastDay.day;
    
    // Calculate total weeks
    final totalWeeks = ((totalDays + firstWeekday - 2) / 7).ceil() + 1;
    
    return totalWeeks;
  }

  // Get the start and end dates of the current week
  List<DateTime> getWeekDates() {
    final selectedDate = state.selectedDate;
    final weekday = selectedDate.weekday;
    
    // Find Monday of current week (weekday 1 = Monday)
    final monday = selectedDate.subtract(Duration(days: weekday - 1));
    
    // Generate 7 days starting from Monday
    return List.generate(7, (index) => monday.add(Duration(days: index)));
  }
}

final hydrationProvider =
    StateNotifierProvider<HydrationNotifier, HydrationState>((ref) {
  return HydrationNotifier();
});
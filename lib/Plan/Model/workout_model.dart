// lib/features/training_calendar/models/workout_model.dart

import 'package:flutter/material.dart';

class WorkoutModel {
  final String id;
  final String title;
  final String tag;
  final String iconAsset;
  final String duration;
  final Color tagColor;

  WorkoutModel({
    required this.id,
    required this.title,
    required this.tag,
    required this.iconAsset,
    required this.duration,
    required this.tagColor,
  });

  WorkoutModel copyWith({
    String? id,
    String? title,
    String? tag,
    String? iconAsset,
    String? duration,
    Color? tagColor,
  }) {
    return WorkoutModel(
      id: id ?? this.id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      iconAsset: iconAsset ?? this.iconAsset,
      duration: duration ?? this.duration,
      tagColor: tagColor ?? this.tagColor,
    );
  }
}

class DayModel {
  final String day;
  final String date;
  final WorkoutModel? workout;

  DayModel({
    required this.day,
    required this.date,
    this.workout,
  });

  DayModel copyWith({
    String? day,
    String? date,
    WorkoutModel? workout,
    bool clearWorkout = false,
  }) {
    return DayModel(
      day: day ?? this.day,
      date: date ?? this.date,
      workout: clearWorkout ? null : (workout ?? this.workout),
    );
  }
}

class WeekModel {
  final String weekTitle;
  final String dateRange;
  final String totalDuration;
  final List<DayModel> days;

  WeekModel({
    required this.weekTitle,
    required this.dateRange,
    required this.totalDuration,
    required this.days,
  });

  WeekModel copyWith({
    String? weekTitle,
    String? dateRange,
    String? totalDuration,
    List<DayModel>? days,
  }) {
    return WeekModel(
      weekTitle: weekTitle ?? this.weekTitle,
      dateRange: dateRange ?? this.dateRange,
      totalDuration: totalDuration ?? this.totalDuration,
      days: days ?? this.days,
    );
  }
}
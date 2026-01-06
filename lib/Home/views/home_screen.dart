import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_syed_ameen_gillani/core/constants/app_assets.dart';
import 'package:task_syed_ameen_gillani/core/constants/app_colors.dart';
import 'package:task_syed_ameen_gillani/core/constants/app_fonts.dart';
import 'package:task_syed_ameen_gillani/Plan/views/training_calendar_screen.dart';
import 'package:task_syed_ameen_gillani/Home/widgets/calendar_bottom_sheet.dart';
import 'package:task_syed_ameen_gillani/Mood/views/mood_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_syed_ameen_gillani/Home/provider/hydration_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;
  late final DateTime _workoutDateTime;

  @override
  void initState() {
    super.initState();
    _workoutDateTime = DateTime.now();
    _syncDaytimeWithWorkout();
  }

  void _syncDaytimeWithWorkout() {
    final isDaytime = _isDaytime(_workoutDateTime);
    final hydrationState = ref.read(hydrationProvider);
    if (hydrationState.isDaytime != isDaytime) {
      ref.read(hydrationProvider.notifier).setDaytime(isDaytime);
    }
  }

  bool _isDaytime(DateTime time) {
    return time.hour >= 6 && time.hour < 18;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openCalendarSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CalendarBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final (currentWeek, totalWeeks) = ref.watch(
      hydrationProvider.select((state) => (state.currentWeek, state.totalWeeks)),
    );
    final selectedDate = ref.watch(
      hydrationProvider.select((state) => state.selectedDate),
    );
    final weekDates = ref.read(hydrationProvider.notifier).getWeekDates();
    final isDaytime = ref.watch(
      hydrationProvider.select((state) => state.isDaytime),
    );

    Widget body;
    if (_selectedIndex == 0) {
      body = SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    children: [
                      // Header Row - Notification and Week Selector
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Notification Bell Icon
                          SvgPicture.asset(
                            AppAssets.notificationIcon,
                            width: 24.w,
                            height: 24.h,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          // Week Selector
                          SizedBox(width: 120.w),
                          GestureDetector(
                            onTap: _openCalendarSheet,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppAssets.weekIcon,
                                  width: 20.w,
                                  height: 20.h,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Week $currentWeek/$totalWeeks',
                                  style: AppTextStyles.mulishRegular14,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 24.w),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      // Today Text
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Today, 22 Dec 2024",
                          style: AppTextStyles.mulishBold24.copyWith(
                            color: AppColors.textGray,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // Calendar Strip
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < weekDates.length; i++) ...[
                              _buildCalendarItem(
                                day: _weekdayLabel(weekDates[i].weekday),
                                date: '${weekDates[i].day}',
                                isSelected: weekDates[i].year == selectedDate.year &&
                                    weekDates[i].month == selectedDate.month &&
                                    weekDates[i].day == selectedDate.day,
                              ),
                              if (i != weekDates.length - 1) SizedBox(width: 14.w),
                            ],
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // Bottom Handle Bar
                      Container(
                        width: 48.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: AppColors.textSecondary,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Workouts Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Workouts",
                            style: AppTextStyles.mulishSemiBold24.copyWith(
                              color: AppColors.textGray,
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 24.w,
                                height: 24.h,
                                child: isDaytime
                                    ? SvgPicture.asset(
                                        AppAssets.sunIcon,
                                        width: 24.w,
                                        height: 24.h,
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.textGray,
                                          BlendMode.srcIn,
                                        ),
                                      )
                                    : Icon(
                                        Icons.nights_stay,
                                        size: 24.w,
                                        color: AppColors.textGray,
                                      ),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                "9°",
                                style: AppTextStyles.mulishMedium24.copyWith(
                                  color: AppColors.textGray,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Upper Body Workout Card
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Container(
                          color: AppColors.cardBackgroundDark,
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Left Teal Strip
                                Container(
                                  width: 6.w,
                                  color: AppColors.tealAccent,
                                ),
                                // Content
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24.w,
                                      vertical: 16.h,
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "December 22 - 25m - 30m",
                                              style: AppTextStyles.mulishBold12,
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              "Upper Body",
                                              style: AppTextStyles.mulishBold24,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        SvgPicture.asset(
                                          AppAssets.forwardArrowIcon,
                                          width: 24.w,
                                          height: 24.h,
                                          colorFilter: const ColorFilter.mode(
                                            Colors.white,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "My Insights",
                          style: AppTextStyles.mulishSemiBold24,
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Insights Cards ScrollView
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // Card 1: Calories
                            Container(
                              width: 189.w,
                              height: 189.h,
                              padding: EdgeInsets.all(13.w),
                              decoration: BoxDecoration(
                                color: AppColors.cardBackgroundDark,
                                borderRadius: BorderRadius.circular(6.9.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        "550",
                                        style: AppTextStyles.mulishSemiBold10
                                            .copyWith(
                                              color: AppColors.textGray,
                                              fontSize: 40.sp,
                                            ),
                                      ),
                                      SizedBox(width: 2.w),
                                      Text(
                                        "Calories",
                                        style: AppTextStyles.mulishBold14,
                                      ),
                                    ],
                                  ),
                                  // SizedBox(height: 4.h),
                                  Text(
                                    "1950 Remaining",
                                    style: AppTextStyles.mulishMedium14
                                        .copyWith(color: AppColors.textMuted),
                                  ),
                                  SizedBox(height: 39.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "0",
                                        style: AppTextStyles.mulishSemiBold14
                                            .copyWith(
                                              color: AppColors.textMuted,
                                            ),
                                      ),
                                      Text(
                                        "2500",
                                        style: AppTextStyles.mulishSemiBold14
                                            .copyWith(
                                              color: AppColors.textMuted,
                                            ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  // Custom Progress Bar
                                  Container(
                                    height: 6.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.textSecondary
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(3.r),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: 550 / 2500,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              AppColors.gradientBlueStart,
                                              AppColors.gradientGreenEnd,
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            3.r,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12.w),
                            // Card 2: Weight
                            Container(
                              width: 189.5.w,
                              height: 189.h,
                              padding: EdgeInsets.all(13.w),
                              decoration: BoxDecoration(
                                color: AppColors.cardBackgroundDark,
                                borderRadius: BorderRadius.circular(6.9.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        "75",
                                        style: AppTextStyles.mulishSemiBold10
                                            .copyWith(
                                              color: AppColors.textGray,
                                              fontSize: 40.sp,
                                            ),
                                      ),
                                      SizedBox(width: 2.w),
                                      Text(
                                        "kg",
                                        style: AppTextStyles.mulishBold18,
                                      ),
                                    ],
                                  ),
                                  // SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      Container(
                                        width: 16.w,
                                        height: 16.w,
                                        decoration: const BoxDecoration(
                                          color: Color(
                                            0xFF1B3D45,
                                          ), // Dark green bg
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.arrow_outward,
                                          color: AppColors.primaryGreen,
                                          size: 10.sp,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        "+1.6kg",
                                        style: AppTextStyles.mulishMedium14
                                            .copyWith(
                                              color: AppColors.textMuted,
                                            ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 39.h),
                                  Text(
                                    "Weight",
                                    style: AppTextStyles.mulishSemiBold14
                                        .copyWith(color: AppColors.textGray),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Hydration Card
                      SizedBox(height: 12.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Container(
                          color: AppColors.cardBackgroundDark,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 14.sp, right: 14.sp, bottom: 14.sp),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Hydration Label & Percentage
                                    SizedBox(
                                      height: 124.h,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Static Percentage
                                          Text(
                                            "0%",
                                            style: AppTextStyles.mulishSemiBold24
                                                .copyWith(
                                                  color: AppColors.accentBlue,
                                                  fontSize: 40.sp,
                                                ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Hydration",
                                                style:
                                                    AppTextStyles.mulishBold18,
                                              ),
                                              SizedBox(height: 4.h),
                                              // Log Now Button
                                              Text(
                                                "Log Now",
                                                style: AppTextStyles
                                                    .mulishRegular12
                                                    .copyWith(
                                                      color:
                                                          AppColors.textMuted,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    // Right Content (Ruler)
                                    Container(
                                      // width: 176.56.w,
                                      height: 124.h,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          // Labels Column
                                          Container(
                                            height: 108.h,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "2 L",
                                                  style: AppTextStyles
                                                      .mulishSemiBold10 // Slightly bolder
                                                      .copyWith(
                                                        color:
                                                            AppColors.textGray,
                                                      ),
                                                ),
                                                Text(
                                                  "0 L",
                                                  style: AppTextStyles
                                                      .mulishSemiBold10
                                                      .copyWith(
                                                        color:
                                                            AppColors.textGray,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          // Ruler Line Column
                                          Container(
                                            height: 108.h,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // Top Tick
                                                _buildBlueTick(),
                                                // Dashes
                                                ...List.generate(
                                                  4,
                                                  (_) => _buildDash(),
                                                ),
                                                // Middle Tick
                                                _buildBlueTick(),
                                                // Dashes
                                                ...List.generate(
                                                  4,
                                                  (_) => _buildDash(),
                                                ),
                                                // Bottom Tick
                                                _buildBlueTick(),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0,
                                              vertical: 1.0,
                                            ),
                                            child: Container(
                                              width: 107.w,
                                              height: 1.h,
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                          // Current Value
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 0.h,
                                            ),
                                            child: Text(
                                              "0ml",
                                              style: AppTextStyles
                                                  .mulishSemiBold16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Bottom Status Bar
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                color: AppColors.darkNavy,
                                child: Center(
                                  child: Text(
                                    "500 ml added to water log",
                                    style: AppTextStyles.mulishMedium14
                                        .copyWith(
                                          color: Color(0xffEBEBEB),
                                          // Matches image text color roughly
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            );
    } else if (_selectedIndex == 1) {
      body = const TrainingCalendarScreen();
    } else if (_selectedIndex == 2) {
      body = const MoodScreen();
    } else {
      body = const TrainingCalendarScreen();
    }

    return Scaffold(
      body: body,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.cardBackgroundDark, // Subtle border
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: AppColors.textSecondary,
          selectedLabelStyle: AppTextStyles.mulishBold14.copyWith(
            fontSize: 12.sp,
          ),
          unselectedLabelStyle: AppTextStyles.mulishRegular14.copyWith(
            fontSize: 12.sp,
          ),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: SvgPicture.asset(
                  AppAssets.nutritionIcon,
                  width: 24.w,
                  height: 24.h,
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 0
                        ? Colors.white
                        : AppColors.textSecondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: "Nutrition",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: SvgPicture.asset(
                  AppAssets.planIcon,
                  width: 24.w,
                  height: 24.h,
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 1
                        ? Colors.white
                        : AppColors.textSecondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: "Plan",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: SvgPicture.asset(
                  AppAssets.moodIcon,
                  width: 24.w,
                  height: 24.h,
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 2
                        ? Colors.white
                        : AppColors.textSecondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: "Mood",
              
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: SvgPicture.asset(
                  AppAssets.profileIcon,
                  width: 24.w,
                  height: 24.h,
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 3
                        ? Colors.white
                        : AppColors.textSecondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarItem({
    required String day,
    required String date,
    bool isSelected = false,
  }) {
    return Column(
      children: [
        Text(
          day,
          style: AppTextStyles.mulishBold12.copyWith(
            color: AppColors.textGray, // Using textGray for day labels
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(9.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected
                ? AppColors.primaryGreenLight
                : AppColors.cardBackgroundDark,
            border: Border.all(
              color: isSelected ? AppColors.primaryGreen : Colors.transparent,
              width: 2,
            ),
          ),
          alignment: Alignment.center,
          child: SizedBox(
            width: 22.w,
            height: 22.h,
            child: Center(
              child: Text(
                date,
                style: AppTextStyles.mulishBold14.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        // Dot for selected item
        if (isSelected)
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryGreen,
            ),
          )
        else
          SizedBox(height: 8.w),
      ],
    );
  }

  String _weekdayLabel(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'M';
      case DateTime.tuesday:
        return 'TU';
      case DateTime.wednesday:
        return 'W';
      case DateTime.thursday:
        return 'TH';
      case DateTime.friday:
        return 'F';
      case DateTime.saturday:
        return 'SA';
      case DateTime.sunday:
        return 'SU';
      default:
        return '';
    }
  }

  Widget _buildBlueTick() {
    return Container(
      width: 14.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: AppColors.accentBlue,
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  Widget _buildDash() {
    return Container(
      width: 4.w,
      height: 2.h,
      decoration: BoxDecoration(
        color: const Color(0xFF2C3138), // Darker dash color
        borderRadius: BorderRadius.circular(1.r),
      ),
    );
  }
}

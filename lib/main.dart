import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_syed_ameen_gillani/Home/views/home_screen.dart';
import 'package:task_syed_ameen_gillani/core/theme/app_theme.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(439, 956), // Standard design size, adjustable
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          // darkTheme: AppTheme.darkTheme, // Uncomment to enable dark mode
          // themeMode: ThemeMode.system, // Uncomment to follow system theme
          home: const HomeScreen(),
        );
      },
    );
  }
}

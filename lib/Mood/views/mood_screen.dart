import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_syed_ameen_gillani/core/constants/app_assets.dart';
import 'package:task_syed_ameen_gillani/core/constants/app_colors.dart';
import 'package:task_syed_ameen_gillani/core/constants/app_fonts.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  double _angle = -math.pi / 4; // Initial angle (Top Right area)

  // Mood Data
  final Map<int, MoodData> _moods = {
    0: MoodData(
      label: "Calm",
      asset: AppAssets.calmMode,
      color: const Color(0xFFE3F1F0), // Tealish Off-white
    ),
    1: MoodData(
      label: "Happy",
      asset: AppAssets.happyMode,
      color: const Color(0xFFE8F5E9), // Light Green
    ),
    2: MoodData(
      label: "Peaceful",
      asset: AppAssets.peacefulMode,
      color: const Color(0xFFFCE4EC), // Light Pink
    ),
    3: MoodData(
      label: "Content",
      asset: AppAssets.contentMode,
      color: const Color(0xFFE8C6BB), // Salmon/Orange
    ),
  };

  MoodData get _currentMood {
    // Map angle to 4 quadrants
    // 0 to pi/2 (0 to 90 deg): Happy
    // pi/2 to pi (90 to 180 deg): Peaceful
    // -pi to -pi/2 (-180 to -90 deg): Content
    // -pi/2 to 0 (-90 to 0 deg): Calm

    if (_angle >= -math.pi / 2 && _angle < 0) return _moods[0]!; // Calm
    if (_angle >= 0 && _angle < math.pi / 2) return _moods[1]!; // Happy
    if (_angle >= math.pi / 2 && _angle <= math.pi)
      return _moods[2]!; // Peaceful
    return _moods[3]!; // Content
  }

  void _updateAngle(Offset localPosition, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final delta = localPosition - center;
    setState(() {
      _angle = math.atan2(delta.dy, delta.dx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Top Glow Refinement (3 Ellipses)
          _buildTopBackgroundEllipse(
            width: 206.w,
            height: 285.h,
            top: -175.h,
            left: 111.w,
            color: const Color(0xFFC547FF).withOpacity(0.25),
            blur: 155.6,
          ),
          _buildTopBackgroundEllipse(
            width: 360.w,
            height: 259.h,
            top: -175.h,
            left: 34.w,
            color: const Color(0xFF47B2FF).withOpacity(0.25),
            blur: 155.6,
          ),
          _buildTopBackgroundEllipse(
            width: 378.w,
            height: 285.h,
            top: -175.h,
            left: 33.w,
            color: const Color(0xFF47FFF6).withOpacity(0.25),
            blur: 155.6,
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  // Header
                  Text(
                    "Mood",
                    style: AppTextStyles.mulishRegular24.copyWith(
                      color: Colors.white,
                      fontSize: 32.sp,
                    ),
                  ),
                  SizedBox(height: 34.h),
                  Text(
                    "Start your day",
                    style: AppTextStyles.mulishRegular18.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "How are you feeling at the\nMoment?",
                    style: AppTextStyles.mulishSemiBold24.copyWith(
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),

                  const Spacer(),

                  // Mood Selector Wheel
                  Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final wheelSize = 270.w;
                        return GestureDetector(
                          onPanUpdate: (details) => _updateAngle(
                            details.localPosition,
                            Size(wheelSize, wheelSize),
                          ),
                          onPanStart: (details) => _updateAngle(
                            details.localPosition,
                            Size(wheelSize, wheelSize),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              // Gradient Ring (281x281)
                              _buildMoodWheel(wheelSize),

                              // Center Face (110x110)
                              Container(
                                width: 110.w,
                                height: 110.h,
                                decoration: BoxDecoration(
                                  // color: _currentMood.color,
                                  borderRadius: BorderRadius.circular(32.r),
                                ),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  _currentMood.asset,
                                  width: 100.w,
                                  height: 100.h,
                                  fit: BoxFit.contain,
                                ),
                              ),

                              // Selector Handle (57.5x57.5)
                              _buildHandle(wheelSize),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // Selected Mood Label
                  Center(
                    child: Text(
                      _currentMood.label,
                      style: AppTextStyles.mulishMedium24.copyWith(
                        color: Colors.white,
                        fontSize: 32.sp,
                      ),
                    ),
                  ),

                  const Spacer(flex: 2),

                  // Continue Button
                  Container(
                    width: double.infinity,
                    height: 56.h,
                    margin: EdgeInsets.only(bottom: 24.h),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Continue",
                        style: AppTextStyles.mulishBold16.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodWheel(double size) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Masked content (Ring shape)
          ClipPath(
            clipper: RingClipper(strokeWidth: 32.w),
            child: Stack(
              children: [
                // Base Orange Gradient
                Container(
                  width: size,
                  height: size,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFFFB17A), Color(0xFFF8954F)],
                    ),
                  ),
                ),
                // Ellipse 1 (Teal)
                _buildBlurredEllipse(
                  width: 91.7.w,
                  height: 256.3.h,
                  angle: -147.46,
                  color: const Color(0xFF6EB9AD),
                  blur: 28,
                  top: -63.71.h,
                  left: 153.08.w,
                ),
                // Ellipse 2 (Purple)
                _buildBlurredEllipse(
                  width: 115.5.w,
                  height: 201.3.h,
                  angle: 143.01,
                  color: const Color(0xFFC9BBEF),
                  blur: 46,
                  top: 110.35.h,
                  left: 170.84.w,
                ),
                // Ellipse 3 (Pink)
                _buildBlurredEllipse(
                  width: 145.5.w,
                  height: 271.7.h,
                  angle: 73.49,
                  color: const Color(0xFFF28DB3),
                  blur: 46,
                  top: 137.h,
                  left: -48.w,
                ),
                // Ellipse 4 (Orange overlay)
                _buildBlurredEllipse(
                  width: 85.4.w,
                  height: 165.h,
                  angle: -24.12,
                  color: const Color(0xFFF99955),
                  blur: 46,
                  top: -6.h,
                  left: 30.w,
                ),
                // Inner Shadow simulation
                CustomPaint(
                  size: Size(size, size),
                  painter: InnerShadowPainter(),
                ),
              ],
            ),
          ),
          // Segment Dividers
          CustomPaint(size: Size(size, size), painter: MoodWheelPainter()),
        ],
      ),
    );
  }

  Widget _buildBlurredEllipse({
    required double width,
    required double height,
    required double angle,
    required Color color,
    required double blur,
    required double top,
    required double left,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: Transform.rotate(
        angle: angle * math.pi / 180,
        child: ImageFiltered(
          imageFilter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(
                Radius.elliptical(width / 2, height / 2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBackgroundEllipse({
    required double width,
    required double height,
    required double top,
    required double left,
    required Color color,
    required double blur,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: ImageFiltered(
        imageFilter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(
              Radius.elliptical(width / 2, height / 2),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHandle(double wheelSize) {
    final handleSize = 57.5.w;
    final radius = (wheelSize / 2) - 16.w; // Half of 32.w thickness
    final x = (wheelSize / 2) + radius * math.cos(_angle) - (handleSize / 2);
    final y = (wheelSize / 2) + radius * math.sin(_angle) - (handleSize / 2);

    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: handleSize,
        height: handleSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFE3F1F0),
          border: Border.all(color: Colors.white, width: 3.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}

// Fixing the blurred ellipse implementation and adding helpers
class RingClipper extends CustomClipper<Path> {
  final double strokeWidth;
  RingClipper({required this.strokeWidth});

  @override
  Path getClip(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerPath = Path()
      ..addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    final innerPath = Path()
      ..addOval(
        Rect.fromCircle(center: center, radius: (size.width / 2) - strokeWidth),
      );
    return Path.combine(PathOperation.difference, outerPath, innerPath);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class InnerShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 32.w;

    // We want to draw a shadow that feels "inset" (y: 2px, blur: 4px)
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);

    canvas.save();
    canvas.clipPath(
      Path()..addOval(Rect.fromLTWH(0, 0, size.width, size.height)),
    );

    // Draw outer edge inset shadow (top-down)
    canvas.drawCircle(center.translate(0, 2), radius, shadowPaint);

    // Clean up center hole (the subtract part)
    final innerPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius - strokeWidth));
    canvas.drawPath(
      innerPath,
      Paint()
        ..color = Colors.black
        ..blendMode = BlendMode.clear,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Re-implementing the helper in the state class properly in the next step

class MoodData {
  final String label;
  final String asset;
  final Color color;
  MoodData({required this.label, required this.asset, required this.color});
}

class MoodWheelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 32.w;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Gradient Ring
    // Order: TR (Blue) -> BR (Green/Yellow) -> BL (Pink) -> TL (Orange)
    final gradient = SweepGradient(
      colors: [
        const Color(0xFF7BAEE2), // Blue (Top Right start)
        const Color(0xFF8ED2C7), // Green/Yellow (Bottom Right)
        const Color(0xFFEC839C), // Pink (Bottom Left)
        const Color(0xFFF8B570), // Orange (Top Left)
        const Color(0xFF7BAEE2), // Back to Blue
      ],
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
      transform: const GradientRotation(-math.pi / 2),
    );

    paint.shader = gradient.createShader(
      Rect.fromCircle(center: center, radius: radius),
    );

    // Draw the main ring
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      0,
      2 * math.pi,
      false,
      paint,
    );

    // Draw segment dividers
    final dividerPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const segmentCount = 12;
    for (int i = 0; i < segmentCount; i++) {
      final angle = (i * 2 * math.pi) / segmentCount;
      final start = Offset(
        center.dx + (radius - strokeWidth) * math.cos(angle),
        center.dy + (radius - strokeWidth) * math.sin(angle),
      );
      final end = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(start, end, dividerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

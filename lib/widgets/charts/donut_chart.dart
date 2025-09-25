import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../core/constants/app_colors.dart';

class DonutChart extends StatefulWidget {
  final double percentage;
  final double size;
  final double strokeWidth;
  final Color primaryColor;
  final Color backgroundColor;
  
  const DonutChart({
    super.key,
    required this.percentage,
    this.size = 100,
    this.strokeWidth = 8,
    this.primaryColor = AppColors.primary,
    this.backgroundColor = AppColors.chartBackground,
  });
  
  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: DonutChartPainter(
              percentage: widget.percentage * _animation.value,
              strokeWidth: widget.strokeWidth,
              primaryColor: widget.primaryColor,
              backgroundColor: widget.backgroundColor,
            ),
          );
        },
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color primaryColor;
  final Color backgroundColor;
  
  DonutChartPainter({
    required this.percentage,
    required this.strokeWidth,
    required this.primaryColor,
    required this.backgroundColor,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    
    // Draw background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    
    canvas.drawCircle(center, radius, backgroundPaint);
    
    // Draw progress arc
    final progressPaint = Paint()
      ..color = primaryColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    
    final sweepAngle = 2 * math.pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
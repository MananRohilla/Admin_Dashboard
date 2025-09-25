import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AnimatedLineChart extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final String dataKey;
  final Color color;
  final double height;

  const AnimatedLineChart({
    Key? key,
    required this.data,
    required this.dataKey,
    this.color = AppColors.primary,
    this.height = 200,
  }) : super(key: key);

  @override
  State<AnimatedLineChart> createState() => _AnimatedLineChartState();
}

class _AnimatedLineChartState extends State<AnimatedLineChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
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
      height: widget.height,
      child: CustomPaint(
        size: Size.infinite,
        painter: AnimatedChartPainter(
          data: widget.data,
          dataKey: widget.dataKey,
          color: widget.color,
          progress: _animation,
        ),
      ),
    );
  }
}

class AnimatedChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final String dataKey;
  final Color color;
  final Animation<double> progress;

  AnimatedChartPainter({
    required this.data,
    required this.dataKey,
    required this.color,
    required this.progress,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final values = data.map((d) => (d[dataKey] as num).toDouble()).toList();
    final maxValue = values.reduce(max);
    final minValue = values.reduce(min);

    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          color.withOpacity(0.3),
          color.withOpacity(0.0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    final fillPath = Path();
    
    final stepX = size.width / (data.length - 1);
    final animatedLength = (data.length * progress.value).floor();

    if (animatedLength > 0) {
      // Start paths
      final firstY = size.height - 
          ((values[0] - minValue) / (maxValue - minValue)) * size.height;
      path.moveTo(0, firstY);
      fillPath.moveTo(0, size.height);
      fillPath.lineTo(0, firstY);

      // Draw animated line
      for (int i = 1; i < animatedLength && i < values.length; i++) {
        final x = stepX * i;
        final y = size.height - 
            ((values[i] - minValue) / (maxValue - minValue)) * size.height;
        
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }

      // Complete fill path
      if (animatedLength > 0) {
        fillPath.lineTo(stepX * (animatedLength - 1), size.height);
        fillPath.close();
      }

      // Draw fill and line
      canvas.drawPath(fillPath, fillPaint);
      canvas.drawPath(path, paint);

      // Draw points
      final pointPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      for (int i = 0; i < animatedLength && i < values.length; i++) {
        final x = stepX * i;
        final y = size.height - 
            ((values[i] - minValue) / (maxValue - minValue)) * size.height;
        canvas.drawCircle(Offset(x, y), 4, pointPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

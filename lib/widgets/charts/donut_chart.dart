import 'dart:math';
import 'package:flutter/material.dart';
import '../../models/dashboard_data.dart';
import '../../core/constants/app_sizes.dart';

class DonutChart extends StatefulWidget {
  final List<ChartData> data;
  final double size;
  final double strokeWidth;

  const DonutChart({
    Key? key,
    required this.data,
    this.size = 200,
    this.strokeWidth = 20,
  }) : super(key: key);

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
    return Column(
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: CustomPaint(
            painter: DonutChartPainter(
              data: widget.data,
              strokeWidth: widget.strokeWidth,
              progress: _animation,
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spacingL),
        _buildLegend(),
      ],
    );
  }

  Widget _buildLegend() {
    return Column(
      children: widget.data.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.spacingXs),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: item.color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: AppSizes.spacingS),
              Text(
                '${item.label}: ${item.value.toInt()}%',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final List<ChartData> data;
  final double strokeWidth;
  final Animation<double> progress;

  DonutChartPainter({
    required this.data,
    required this.strokeWidth,
    required this.progress,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    
    double startAngle = -pi / 2;
    final total = data.fold<double>(0, (sum, item) => sum + item.value);

    for (final item in data) {
      final sweepAngle = (item.value / total) * 2 * pi * progress.value;
      
      final paint = Paint()
        ..color = item.color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      
      startAngle += sweepAngle / progress.value;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
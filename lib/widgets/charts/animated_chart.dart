import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/dashboard_data.dart';

class AnimatedChart extends StatefulWidget {
  final ChartData data;
  final double height;
  
  const AnimatedChart({
    super.key,
    required this.data,
    this.height = 200,
  });
  
  @override
  State<AnimatedChart> createState() => _AnimatedChartState();
}

class _AnimatedChartState extends State<AnimatedChart>
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
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
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
    return Container(
      height: widget.height,
      padding: const EdgeInsets.all(16),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: ChartPainter(
              pendingData: widget.data.pendingData,
              projectData: widget.data.projectData,
              animationValue: _animation.value,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<ChartPoint> pendingData;
  final List<ChartPoint> projectData;
  final double animationValue;
  
  ChartPainter({
    required this.pendingData,
    required this.projectData,
    required this.animationValue,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    
    // Draw pending data line
    paint.color = AppColors.chartSecondary;
    _drawLine(canvas, size, pendingData, paint);
    
    // Draw project data line
    paint.color = AppColors.chartPrimary;
    _drawLine(canvas, size, projectData, paint);
    
    // Draw grid lines
    _drawGrid(canvas, size);
    
    // Draw labels
    _drawLabels(canvas, size);
  }
  
  void _drawLine(Canvas canvas, Size size, List<ChartPoint> data, Paint paint) {
    if (data.isEmpty) return;
    
    final path = Path();
    final maxValue = _getMaxValue();
    final stepX = size.width / (data.length - 1);
    
    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - (data[i].value / maxValue * size.height * animationValue);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    
    canvas.drawPath(path, paint);
  }
  
  void _drawGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textLight.withOpacity(0.2)
      ..strokeWidth = 1;
    
    // Horizontal grid lines
    for (int i = 0; i <= 5; i++) {
      final y = (size.height / 5) * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }
  
  void _drawLabels(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    
    // Draw year labels
    final stepX = size.width / (pendingData.length - 1);
    for (int i = 0; i < pendingData.length; i++) {
      textPainter.text = TextSpan(
        text: pendingData[i].year,
        style: const TextStyle(
          color: AppColors.textLight,
          fontSize: 12,
        ),
      );
      textPainter.layout();
      
      final x = i * stepX - textPainter.width / 2;
      final y = size.height + 8;
      textPainter.paint(canvas, Offset(x, y));
    }
  }
  
  double _getMaxValue() {
    double max = 0;
    for (final point in pendingData) {
      if (point.value > max) max = point.value;
    }
    for (final point in projectData) {
      if (point.value > max) max = point.value;
    }
    return max;
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
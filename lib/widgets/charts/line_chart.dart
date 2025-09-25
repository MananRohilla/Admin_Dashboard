// import 'package:flutter/material.dart';
// import 'dart:math';
// import '../../core/constants/app_colors.dart';
// import '../../core/constants/app_sizes.dart';

// class LineChart extends StatefulWidget {
//   final List<Map<String, dynamic>> data;
//   final String xAxisKey;
//   final List<LineChartSeries> series;
//   final double height;
//   final bool showGrid;
//   final bool showLabels;
//   final bool animated;
//   final EdgeInsets padding;

//   const LineChart({
//     Key? key,
//     required this.data,
//     required this.xAxisKey,
//     required this.series,
//     this.height = 300,
//     this.showGrid = true,
//     this.showLabels = true,
//     this.animated = true,
//     this.padding = const EdgeInsets.all(20),
//   }) : super(key: key);

//   @override
//   State<LineChart> createState() => _LineChartState();
// }

// class _LineChartState extends State<LineChart>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   int? _hoveredPointIndex;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.animated) {
//       _animationController = AnimationController(
//         duration: const Duration(millis# Missing Flutter Dashboard Files - Complete Implementation
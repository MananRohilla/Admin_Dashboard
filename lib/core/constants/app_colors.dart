import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6C5CE7);
  static const Color secondary = Color(0xFFA29BFE);
  static const Color accent = Color(0xFFFF7675);
  static const Color success = Color(0xFF00B894);
  static const Color warning = Color(0xFFE17055);
  static const Color error = Color(0xFFD63031);
  static const Color info = Color(0xFF74B9FF);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient successGradient = LinearGradient(
    colors: [success, Color(0xFF55EFC4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Glass morphism colors
  static const Color glassBackground = Color(0x0DFFFFFF);
  static const Color glassBorder = Color(0x33FFFFFF);
  
  // Dark theme colors
  static const Color darkBackground = Color(0xFF0D1117);
  static const Color darkSurface = Color(0xFF161B22);
  static const Color darkCard = Color(0xFF21262D);
}
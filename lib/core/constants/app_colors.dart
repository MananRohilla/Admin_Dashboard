import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);
  
  // Background Colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color cardBackground = Color(0xFFFFFFFF);
  
  // Sidebar Colors
  static const Color sidebarBackground = Color(0xFFFFFFFF);
  static const Color sidebarSelected = Color(0xFFF1F5F9);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textLight = Color(0xFF94A3B8);
  
  // Accent Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Chart Colors
  static const Color chartPrimary = Color(0xFF8B5CF6);
  static const Color chartSecondary = Color(0xFFEC4899);
  static const Color chartBackground = Color(0xFFF1F5F9);
  
  // Calendar Colors
  static const Color calendarSelected = Color(0xFF6366F1);
  static const Color calendarToday = Color(0xFFEF4444);
  
  // Birthday/Anniversary Colors
  static const Color birthdayColor = Color(0xFFA855F7);
  static const Color anniversaryColor = Color(0xFF8B5CF6);
}
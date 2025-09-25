import 'package:flutter/material.dart';

class NavigationItem {
  final String id;
  final String label;
  final IconData icon;
  final IconData? selectedIcon;
  final String? badge;
  final bool isNew;

  NavigationItem({
    required this.id,
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.badge,
    this.isNew = false,
  });
}
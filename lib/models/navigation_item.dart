import 'package:flutter/material.dart';

class NavigationItem {
  final String title;
  final IconData icon;
  final String route;
  final bool isSelected;
  final List<NavigationItem>? children;
  
  NavigationItem({
    required this.title,
    required this.icon,
    required this.route,
    this.isSelected = false,
    this.children,
  });
  
  NavigationItem copyWith({
    String? title,
    IconData? icon,
    String? route,
    bool? isSelected,
    List<NavigationItem>? children,
  }) {
    return NavigationItem(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      route: route ?? this.route,
      isSelected: isSelected ?? this.isSelected,
      children: children ?? this.children,
    );
  }
}
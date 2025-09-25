import 'package:flutter/material.dart';

class DashboardStats {
  final String title;
  final String value;
  final String change;
  final bool isPositive;
  final IconData icon;
  final Color color;
  final String subtitle;

  DashboardStats({
    required this.title,
    required this.value,
    required this.change,
    required this.isPositive,
    required this.icon,
    required this.color,
    required this.subtitle,
  });
}

class ChartData {
  final String label;
  final double value;
  final Color color;

  ChartData({required this.label, required this.value, required this.color});
}

class ActivityItem {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color color;
  final String type;

  ActivityItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.color,
    required this.type,
  });
}

class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final double rating;
  final int reviews;
  final String category;
  final bool isNew;
  final double discount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.category,
    this.isNew = false,
    this.discount = 0,
  });
}
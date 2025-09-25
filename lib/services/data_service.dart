import 'dart:math';
import '../models/dashboard_data.dart';
import '../core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DataService {
  static List<DashboardStats> getDashboardStats() {
    return [
      DashboardStats(
        title: 'Total Revenue',
        value: '₹1,25,430',
        change: '+12.5%',
        isPositive: true,
        icon: Icons.trending_up,
        color: AppColors.success,
        subtitle: 'vs last month',
      ),
      DashboardStats(
        title: 'Active Users',
        value: '8,543',
        change: '+23.1%',
        isPositive: true,
        icon: Icons.people_outline,
        color: AppColors.info,
        subtitle: 'total users',
      ),
      DashboardStats(
        title: 'Orders',
        value: '1,352',
        change: '-8.2%',
        isPositive: false,
        icon: Icons.shopping_cart_outlined,
        color: AppColors.warning,
        subtitle: 'this month',
      ),
      DashboardStats(
        title: 'Conversion',
        value: '3.2%',
        change: '+2.4%',
        isPositive: true,
        icon: Icons.analytics_outlined,
        color: AppColors.primary,
        subtitle: 'avg rate',
      ),
    ];
  }
  
  static List<ChartData> getChartData() {
    return [
      ChartData(label: 'Mobile', value: 45, color: AppColors.primary),
      ChartData(label: 'Desktop', value: 30, color: AppColors.info),
      ChartData(label: 'Tablet', value: 25, color: AppColors.warning),
    ];
  }
  
  static List<ActivityItem> getRecentActivities() {
    return [
      ActivityItem(
        title: 'New order received',
        subtitle: 'Order #AD-2024-001',
        time: '2 min ago',
        icon: Icons.shopping_bag_outlined,
        color: AppColors.success,
        type: 'order',
      ),
      ActivityItem(
        title: 'Payment processed',
        subtitle: '₹15,000 received',
        time: '5 min ago',
        icon: Icons.payment,
        color: AppColors.info,
        type: 'payment',
      ),
      ActivityItem(
        title: 'New customer',
        subtitle: 'John Doe joined',
        time: '10 min ago',
        icon: Icons.person_add_outlined,
        color: AppColors.primary,
        type: 'user',
      ),
      ActivityItem(
        title: 'Product review',
        subtitle: '5-star rating received',
        time: '15 min ago',
        icon: Icons.star_outline,
        color: AppColors.warning,
        type: 'review',
      ),
      ActivityItem(
        title: 'Low stock alert',
        subtitle: 'iPhone 15 Pro',
        time: '20 min ago',
        icon: Icons.warning_outlined,
        color: AppColors.error,
        type: 'alert',
      ),
    ];
  }
  
  static List<Product> getPopularProducts() {
    final categories = ['Electronics', 'Fashion', 'Home', 'Sports', 'Books'];
    final names = [
      'iPhone 15 Pro Max',
      'MacBook Air M2',
      'AirPods Pro 2nd Gen',
      'Apple Watch Series 9',
      'iPad Air 5th Gen',
      'Samsung Galaxy S24',
      'Sony WH-1000XM5',
      'Nike Air Max 270',
    ];
    
    return List.generate(8, (index) {
      final random = Random();
      return Product(
        id: 'prod_${index + 1}',
        name: names[index],
        price: (random.nextInt(50) + 10) * 1000.0,
        image: 'assets/products/product_${index + 1}.jpg',
        rating: 4.0 + random.nextDouble(),
        reviews: random.nextInt(500) + 50,
        category: categories[random.nextInt(categories.length)],
        isNew: random.nextBool(),
        discount: random.nextBool() ? random.nextInt(30) + 5.0 : 0,
      );
    });
  }
  
  static List<Map<String, dynamic>> getLineChartData() {
    final random = Random();
    return List.generate(12, (index) {
      return {
        'month': [
          'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
        ][index],
        'revenue': 20000 + random.nextInt(30000),
        'users': 1000 + random.nextInt(2000),
        'orders': 100 + random.nextInt(300),
      };
    });
  }
}
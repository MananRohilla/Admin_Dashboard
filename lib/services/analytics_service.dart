import 'dart:math';
import '../models/dashboard_data.dart';
import '../core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  // Simulate real-time data updates
  final Random _random = Random();
  
  // Cache for performance
  Map<String, dynamic>? _cachedData;
  DateTime? _lastCacheTime;
  static const Duration _cacheTimeout = Duration(minutes: 5);

  bool get _isCacheValid {
    if (_cachedData == null || _lastCacheTime == null) return false;
    return DateTime.now().difference(_lastCacheTime!) < _cacheTimeout;
  }

  // Real-time analytics data
  Future<Map<String, dynamic>> getRealtimeAnalytics() async {
    if (_isCacheValid) {
      return _cachedData!;
    }

    // Simulate API delay
    await Future.delayed(Duration(milliseconds: 500 + _random.nextInt(500)));

    final data = {
      'activeUsers': 1200 + _random.nextInt(300),
      'pageViews': 15000 + _random.nextInt(5000),
      'bounceRate': 40 + _random.nextDouble() * 20,
      'avgSessionDuration': 180 + _random.nextInt(120),
      'conversionRate': 2.5 + _random.nextDouble() * 2,
      'totalRevenue': 125000 + _random.nextInt(50000),
      'newUsers': 150 + _random.nextInt(50),
      'returningUsers': 850 + _random.nextInt(200),
      'topPages': _generateTopPages(),
      'trafficSources': _generateTrafficSources(),
      'deviceBreakdown': _generateDeviceBreakdown(),
      'revenueByHour': _generateHourlyRevenue(),
      'userGrowth': _generateUserGrowth(),
      'salesFunnel': _generateSalesFunnel(),
    };

    _cachedData = data;
    _lastCacheTime = DateTime.now();
    
    return data;
  }

  // Generate hourly revenue data for the last 24 hours
  List<Map<String, dynamic>> _generateHourlyRevenue() {
    final now = DateTime.now();
    final data = <Map<String, dynamic>>[];
    
    for (int i = 23; i >= 0; i--) {
      final hour = now.subtract(Duration(hours: i));
      final baseRevenue = 1000 + _random.nextInt(3000);
      final hourlyMultiplier = _getHourlyMultiplier(hour.hour);
      
      data.add({
        'hour': hour.hour,
        'time': '${hour.hour.toString().padLeft(2, '0')}:00',
        'revenue': (baseRevenue * hourlyMultiplier).round(),
        'orders': 10 + _random.nextInt(30),
        'users': 50 + _random.nextInt(100),
      });
    }
    
    return data;
  }

  double _getHourlyMultiplier(int hour) {
    // Business hours (9-18) have higher activity
    if (hour >= 9 && hour <= 18) {
      return 1.0 + (0.5 * sin((hour - 9) * pi / 9));
    } else if (hour >= 19 && hour <= 23) {
      return 0.8;
    } else {
      return 0.3;
    }
  }

  // Generate user growth data for the last 12 months
  List<Map<String, dynamic>> _generateUserGrowth() {
    final data = <Map<String, dynamic>>[];
    final now = DateTime.now();
    
    for (int i = 11; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i, 1);
      final baseUsers = 5000 + (i * 500);
      final growth = _random.nextDouble() * 0.3; // 0-30% growth
      
      data.add({
        'month': _getMonthName(month.month),
        'year': month.year,
        'totalUsers': baseUsers + (baseUsers * growth).round(),
        'newUsers': 300 + _random.nextInt(200),
        'activeUsers': (baseUsers * 0.6).round() + _random.nextInt(500),
        'retentionRate': 65 + _random.nextDouble() * 20,
      });
    }
    
    return data;
  }

  String _getMonthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }

  // Generate sales funnel data
  Map<String, dynamic> _generateSalesFunnel() {
    final visitors = 10000 + _random.nextInt(5000);
    final productViews = (visitors * 0.7).round();
    final addToCarts = (productViews * 0.3).round();
    final checkouts = (addToCarts * 0.8).round();
    final purchases = (checkouts * 0.65).round();
    
    return {
      'stages': [
        {
          'name': 'Visitors',
          'count': visitors,
          'rate': 100.0,
          'color': Colors.blue[100],
        },
        {
          'name': 'Product Views',
          'count': productViews,
          'rate': (productViews / visitors * 100),
          'color': Colors.blue[300],
        },
        {
          'name': 'Add to Cart',
          'count': addToCarts,
          'rate': (addToCarts / visitors * 100),
          'color': Colors.blue[500],
        },
        {
          'name': 'Checkout',
          'count': checkouts,
          'rate': (checkouts / visitors * 100),
          'color': Colors.blue[700],
        },
        {
          'name': 'Purchase',
          'count': purchases,
          'rate': (purchases / visitors * 100),
          'color': Colors.blue[900],
        },
      ],
      'overallConversion': (purchases / visitors * 100),
      'dropoffPoints': {
        'productToCart': ((productViews - addToCarts) / productViews * 100),
        'cartToCheckout': ((addToCarts - checkouts) / addToCarts * 100),
        'checkoutToPurchase': ((checkouts - purchases) / checkouts * 100),
      }
    };
  }

  List<Map<String, dynamic>> _generateTopPages() {
    final pages = [
      {'path': '/', 'name': 'Homepage'},
      {'path': '/products', 'name': 'Products'},
      {'path': '/about', 'name': 'About Us'},
      {'path': '/contact', 'name': 'Contact'},
      {'path': '/blog', 'name': 'Blog'},
    ];

    return pages.map((page) {
      return {
        'path': page['path'],
        'name': page['name'],
        'views': 1000 + _random.nextInt(5000),
        'uniqueViews': 800 + _random.nextInt(3000),
        'avgTimeOnPage': 120 + _random.nextInt(300),
        'bounceRate': 30 + _random.nextDouble() * 40,
      };
    }).toList();
  }

  List<ChartData> _generateTrafficSources() {
    final sources = [
      {'name': 'Organic Search', 'color': AppColors.success},
      {'name': 'Direct', 'color': AppColors.primary},
      {'name': 'Social Media', 'color': AppColors.info},
      {'name': 'Referral', 'color': AppColors.warning},
      {'name': 'Email', 'color': AppColors.accent},
    ];

    return sources.map((source) {
      return ChartData(
        label: source['name'] as String,
        value: 10 + _random.nextDouble() * 40,
        color: source['color'] as Color,
      );
    }).toList();
  }

  List<ChartData> _generateDeviceBreakdown() {
    return [
      ChartData(
        label: 'Mobile',
        value: 45 + _random.nextDouble() * 20,
        color: AppColors.primary,
      ),
      ChartData(
        label: 'Desktop',
        value: 30 + _random.nextDouble() * 15,
        color: AppColors.info,
      ),
      ChartData(
        label: 'Tablet',
        value: 15 + _random.nextDouble() * 10,
        color: AppColors.warning,
      ),
    ];
  }

  // Get analytics for specific time period
  Future<Map<String, dynamic>> getAnalyticsForPeriod(
    DateTime startDate,
    DateTime endDate,
  ) async {
    await Future.delayed(Duration(milliseconds: 800));

    final days = endDate.difference(startDate).inDays;
    final dailyData = <Map<String, dynamic>>[];

    for (int i = 0; i <= days; i++) {
      final date = startDate.add(Duration(days: i));
      dailyData.add({
        'date': date.toIso8601String().split('T')[0],
        'revenue': 2000 + _random.nextInt(5000),
        'users': 100 + _random.nextInt(300),
        'orders': 20 + _random.nextInt(50),
        'pageViews': 500 + _random.nextInt(1500),
      });
    }

    return {
      'period': {
        'start': startDate.toIso8601String(),
        'end': endDate.toIso8601String(),
        'days': days,
      },
      'dailyData': dailyData,
      'summary': _calculatePeriodSummary(dailyData),
      'growth': _calculateGrowthMetrics(dailyData),
    };
  }

  Map<String, dynamic> _calculatePeriodSummary(List<Map<String, dynamic>> data) {
    final totalRevenue = data.fold<int>(0, (sum, day) => sum + (day['revenue'] as int));
    final totalUsers = data.fold<int>(0, (sum, day) => sum + (day['users'] as int));
    final totalOrders = data.fold<int>(0, (sum, day) => sum + (day['orders'] as int));
    final totalPageViews = data.fold<int>(0, (sum, day) => sum + (day['pageViews'] as int));

    return {
      'totalRevenue': totalRevenue,
      'totalUsers': totalUsers,
      'totalOrders': totalOrders,
      'totalPageViews': totalPageViews,
      'avgRevenuePerDay': totalRevenue / data.length,
      'avgUsersPerDay': totalUsers / data.length,
      'avgOrdersPerDay': totalOrders / data.length,
      'conversionRate': totalOrders / totalUsers * 100,
    };
  }

  Map<String, dynamic> _calculateGrowthMetrics(List<Map<String, dynamic>> data) {
    if (data.length < 2) return {};

    final firstHalf = data.take(data.length ~/ 2).toList();
    final secondHalf = data.skip(data.length ~/ 2).toList();

    final firstHalfRevenue = firstHalf.fold<int>(0, (sum, day) => sum + (day['revenue'] as int));
    final secondHalfRevenue = secondHalf.fold<int>(0, (sum, day) => sum + (day['revenue'] as int));

    final revenueGrowth = secondHalfRevenue > 0 
        ? ((secondHalfRevenue - firstHalfRevenue) / firstHalfRevenue * 100)
        : 0.0;

    return {
      'revenueGrowth': revenueGrowth,
      'trend': revenueGrowth > 0 ? 'increasing' : 'decreasing',
    };
  }

  // Get competitor analysis data
  Future<Map<String, dynamic>> getCompetitorAnalysis() async {
    await Future.delayed(Duration(milliseconds: 600));

    final competitors = [
      'Competitor A',
      'Competitor B', 
      'Competitor C',
      'Competitor D',
    ];

    return {
      'marketShare': competitors.map((name) {
        return {
          'name': name,
          'share': 15 + _random.nextDouble() * 25,
          'growth': -10 + _random.nextDouble() * 20,
        };
      }).toList(),
      'yourMarketShare': 20 + _random.nextDouble() * 10,
      'industryGrowth': 5 + _random.nextDouble() * 15,
    };
  }

  // Clear cache
  void clearCache() {
    _cachedData = null;
    _lastCacheTime = null;
  }

  // Simulate tracking events
  void trackEvent(String eventName, Map<String, dynamic> properties) {
    // In a real app, this would send data to analytics service
    debugPrint('Analytics Event: $eventName with properties: $properties');
  }

  void trackPageView(String pageName) {
    trackEvent('page_view', {'page': pageName, 'timestamp': DateTime.now().toIso8601String()});
  }

  void trackUserAction(String action, {String? category, String? label, int? value}) {
    trackEvent('user_action', {
      'action': action,
      'category': category,
      'label': label,
      'value': value,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }
}
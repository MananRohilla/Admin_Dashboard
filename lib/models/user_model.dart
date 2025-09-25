import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String role;
  final String avatar;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final bool isActive;
  final String? profileImage;
  final UserPreferences preferences;
  final UserStats stats;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    required this.role,
    required this.avatar,
    required this.createdAt,
    this.lastLoginAt,
    this.isActive = true,
    this.profileImage,
    required this.preferences,
    required this.stats,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'],
      role: json['role'] ?? 'User',
      avatar: json['avatar'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastLoginAt: json['lastLoginAt'] != null 
          ? DateTime.parse(json['lastLoginAt'])
          : null,
      isActive: json['isActive'] ?? true,
      profileImage: json['profileImage'],
      preferences: UserPreferences.fromJson(json['preferences'] ?? {}),
      stats: UserStats.fromJson(json['stats'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'avatar': avatar,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'isActive': isActive,
      'profileImage': profileImage,
      'preferences': preferences.toJson(),
      'stats': stats.toJson(),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? role,
    String? avatar,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    bool? isActive,
    String? profileImage,
    UserPreferences? preferences,
    UserStats? stats,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      isActive: isActive ?? this.isActive,
      profileImage: profileImage ?? this.profileImage,
      preferences: preferences ?? this.preferences,
      stats: stats ?? this.stats,
    );
  }

  String get initials {
    final names = name.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : 'U';
  }

  String get displayName => name.isNotEmpty ? name : email.split('@')[0];

  bool get isAdmin => role.toLowerCase() == 'admin' || role.toLowerCase() == 'administrator';
  bool get isModerator => role.toLowerCase() == 'moderator';
  bool get isCustomer => role.toLowerCase() == 'customer' || role.toLowerCase() == 'user';
}

class UserPreferences {
  final bool darkMode;
  final String language;
  final bool notifications;
  final bool emailNotifications;
  final String timezone;
  final String dateFormat;
  final String currency;

  UserPreferences({
    this.darkMode = false,
    this.language = 'en',
    this.notifications = true,
    this.emailNotifications = true,
    this.timezone = 'UTC',
    this.dateFormat = 'dd/MM/yyyy',
    this.currency = 'INR',
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      darkMode: json['darkMode'] ?? false,
      language: json['language'] ?? 'en',
      notifications: json['notifications'] ?? true,
      emailNotifications: json['emailNotifications'] ?? true,
      timezone: json['timezone'] ?? 'UTC',
      dateFormat: json['dateFormat'] ?? 'dd/MM/yyyy',
      currency: json['currency'] ?? 'INR',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'darkMode': darkMode,
      'language': language,
      'notifications': notifications,
      'emailNotifications': emailNotifications,
      'timezone': timezone,
      'dateFormat': dateFormat,
      'currency': currency,
    };
  }

  UserPreferences copyWith({
    bool? darkMode,
    String? language,
    bool? notifications,
    bool? emailNotifications,
    String? timezone,
    String? dateFormat,
    String? currency,
  }) {
    return UserPreferences(
      darkMode: darkMode ?? this.darkMode,
      language: language ?? this.language,
      notifications: notifications ?? this.notifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      timezone: timezone ?? this.timezone,
      dateFormat: dateFormat ?? this.dateFormat,
      currency: currency ?? this.currency,
    );
  }
}

class UserStats {
  final int totalOrders;
  final double totalSpent;
  final int totalProducts;
  final int loginCount;
  final DateTime? lastActivity;
  final double averageOrderValue;
  final int favoriteProducts;

  UserStats({
    this.totalOrders = 0,
    this.totalSpent = 0.0,
    this.totalProducts = 0,
    this.loginCount = 0,
    this.lastActivity,
    this.averageOrderValue = 0.0,
    this.favoriteProducts = 0,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      totalOrders: json['totalOrders'] ?? 0,
      totalSpent: (json['totalSpent'] ?? 0).toDouble(),
      totalProducts: json['totalProducts'] ?? 0,
      loginCount: json['loginCount'] ?? 0,
      lastActivity: json['lastActivity'] != null 
          ? DateTime.parse(json['lastActivity'])
          : null,
      averageOrderValue: (json['averageOrderValue'] ?? 0).toDouble(),
      favoriteProducts: json['favoriteProducts'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalOrders': totalOrders,
      'totalSpent': totalSpent,
      'totalProducts': totalProducts,
      'loginCount': loginCount,
      'lastActivity': lastActivity?.toIso8601String(),
      'averageOrderValue': averageOrderValue,
      'favoriteProducts': favoriteProducts,
    };
  }
}

// Customer Model extending UserModel
class CustomerModel extends UserModel {
  final String? companyName;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final List<String> tags;
  final CustomerTier tier;

  CustomerModel({
    required super.id,
    required super.name,
    required super.email,
    super.phoneNumber,
    required super.role,
    required super.avatar,
    required super.createdAt,
    super.lastLoginAt,
    super.isActive,
    super.profileImage,
    required super.preferences,
    required super.stats,
    this.companyName,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.tags = const [],
    this.tier = CustomerTier.bronze,
  });

  factory CustomerModel.fromUserModel(UserModel user, {
    String? companyName,
    String? address,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    List<String>? tags,
    CustomerTier? tier,
  }) {
    return CustomerModel(
      id: user.id,
      name: user.name,
      email: user.email,
      phoneNumber: user.phoneNumber,
      role: user.role,
      avatar: user.avatar,
      createdAt: user.createdAt,
      lastLoginAt: user.lastLoginAt,
      isActive: user.isActive,
      profileImage: user.profileImage,
      preferences: user.preferences,
      stats: user.stats,
      companyName: companyName,
      address: address,
      city: city,
      state: state,
      country: country,
      postalCode: postalCode,
      tags: tags ?? [],
      tier: tier ?? CustomerTier.bronze,
    );
  }

  String get fullAddress {
    final addressParts = [address, city, state, country, postalCode]
        .where((part) => part != null && part.isNotEmpty)
        .toList();
    return addressParts.join(', ');
  }

  Color get tierColor {
    switch (tier) {
      case CustomerTier.bronze:
        return Colors.orange[600]!;
      case CustomerTier.silver:
        return Colors.grey[500]!;
      case CustomerTier.gold:
        return Colors.yellow[600]!;
      case CustomerTier.platinum:
        return Colors.purple[600]!;
    }
  }

  IconData get tierIcon {
    switch (tier) {
      case CustomerTier.bronze:
        return Icons.workspace_premium_outlined;
      case CustomerTier.silver:
        return Icons.workspace_premium;
      case CustomerTier.gold:
        return Icons.stars;
      case CustomerTier.platinum:
        return Icons.diamond;
    }
  }
}

enum CustomerTier { bronze, silver, gold, platinum }

extension CustomerTierExtension on CustomerTier {
  String get name {
    switch (this) {
      case CustomerTier.bronze:
        return 'Bronze';
      case CustomerTier.silver:
        return 'Silver';
      case CustomerTier.gold:
        return 'Gold';
      case CustomerTier.platinum:
        return 'Platinum';
    }
  }
}
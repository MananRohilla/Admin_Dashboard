import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../models/dashboard_data.dart';
import '../common/animated_counter.dart';
import '../common/glass_container.dart';

class StatsCard extends StatelessWidget {
  final DashboardStats stats;
  final bool useGlassEffect;

  const StatsCard({
    Key? key,
    required this.stats,
    this.useGlassEffect = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = Card(
      elevation: useGlassEffect ? 0 : AppSizes.elevationS,
      color: useGlassEffect ? Colors.transparent : null,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.spacingL),
        decoration: useGlassEffect ? null : BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
          gradient: LinearGradient(
            colors: [
              stats.color.withOpacity(0.1),
              stats.color.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSizes.spacingM),
                  decoration: BoxDecoration(
                    color: stats.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppSizes.radiusM),
                  ),
                  child: Icon(
                    stats.icon,
                    color: stats.color,
                    size: 24,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.spacingS,
                    vertical: AppSizes.spacingXs,
                  ),
                  decoration: BoxDecoration(
                    color: stats.isPositive 
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusS),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        stats.isPositive 
                            ? Icons.trending_up
                            : Icons.trending_down,
                        size: 14,
                        color: stats.isPositive 
                            ? AppColors.success
                            : AppColors.error,
                      ),
                      const SizedBox(width: AppSizes.spacingXs),
                      Text(
                        stats.change,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: stats.isPositive 
                              ? AppColors.success
                              : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spacingL),
            AnimatedCounter(
              value: stats.value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.spacingXs),
            Text(
              stats.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: AppSizes.spacingXs),
            Text(
              stats.subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );

    return useGlassEffect
        ? GlassContainer(
            padding: EdgeInsets.zero,
            child: card,
          )
        : card;
  }
}
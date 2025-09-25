import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../models/dashboard_data.dart';
import '../common/glass_container.dart';

class ProductCard extends StatelessWidget {
  final ProjectData project;
  final VoidCallback? onTap;
  
  const ProductCard({
    super.key,
    required this.project,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSizes.paddingMD),
        padding: const EdgeInsets.all(AppSizes.paddingLG),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusLG),
          border: Border.all(
            color: AppColors.textLight.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                image: DecorationImage(
                  image: NetworkImage(project.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: AppSizes.paddingLG),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.paddingSM),
                  Text(
                    project.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSizes.paddingMD),
            Icon(
              Icons.edit,
              color: AppColors.textLight,
              size: AppSizes.iconSM,
            ),
          ],
        ),
      ),
    );
  }
}
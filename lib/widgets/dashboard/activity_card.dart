import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../models/dashboard_data.dart';
import '../common/glass_container.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final List<CreatorData> creators;
  
  const ActivityCard({
    super.key,
    required this.title,
    required this.creators,
  });
  
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(AppSizes.paddingLG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.more_vert,
                color: AppColors.textLight,
                size: AppSizes.iconSM,
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingLG),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Name',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  'Artworks',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  'Rating',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingMD),
          ...creators.map((creator) => _buildCreatorRow(context, creator)),
        ],
      ),
    );
  }
  
  Widget _buildCreatorRow(BuildContext context, CreatorData creator) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.paddingMD),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(creator.avatarUrl),
          ),
          const SizedBox(width: AppSizes.paddingMD),
          Expanded(
            child: Text(
              creator.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              creator.artworks.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 60,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingSM,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusSM),
              ),
              child: Text(
                '${creator.rating.toInt()}%',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../models/dashboard_data.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductHeader(),
                  const SizedBox(height: AppSizes.spacingS),
                  _buildProductPrice(),
                  const Spacer(),
                  _buildProductRating(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.secondary.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          const Center(
            child: Icon(
              Icons.phone_iphone,
              size: 50,
              color: AppColors.primary,
            ),
          ),
          if (product.isNew)
            Positioned(
              top: AppSizes.spacingS,
              left: AppSizes.spacingS,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.spacingS,
                  vertical: AppSizes.spacingXs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(AppSizes.radiusS),
                ),
                child: const Text(
                  'NEW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (product.discount > 0)
            Positioned(
              top: AppSizes.spacingS,
              right: AppSizes.spacingS,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.spacingS,
                  vertical: AppSizes.spacingXs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: BorderRadius.circular(AppSizes.radiusS),
                ),
                child: Text(
                  '-${product.discount.toInt()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSizes.spacingXs),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacingS,
            vertical: AppSizes.spacingXs,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSizes.radiusS),
          ),
          child: Text(
            product.category,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductPrice() {
    return Row(
      children: [
        Text(
          '₹${product.price.toStringAsFixed(0)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        if (product.discount > 0) ...[
          const SizedBox(width: AppSizes.spacingS),
          Text(
            '₹${(product.price / (1 - product.discount / 100)).toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 12,
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildProductRating() {
    return Row(
      children: [
        ...List.generate(5, (index) {
          return Icon(
            index < product.rating.floor()
                ? Icons.star
                : index < product.rating
                    ? Icons.star_half
                    : Icons.star_outline,
            size: 12,
            color: Colors.orange,
          );
        }),
        const SizedBox(width: AppSizes.spacingXs),
        Text(
          '${product.rating.toStringAsFixed(1)} (${product.reviews})',
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import '../../core/constants/app_sizes.dart';
// import '../../core/utils/responsive_utils.dart';
import '../../models/navigation_item.dart';
import '../../services/data_service.dart';
import '../../widgets/dashboard/stats_card.dart';
import '../../widgets/dashboard/activity_card.dart';
import '../../widgets/dashboard/product_card.dart';
import '../../widgets/charts/donut_chart.dart';

class MobileDashboard extends StatefulWidget {
  const MobileDashboard({Key? key}) : super(key: key);

  @override
  State<MobileDashboard> createState() => _MobileDashboardState();
}

class _MobileDashboardState extends State<MobileDashboard> {
  int _selectedIndex = 0;

  final List<NavigationItem> _navigationItems = [
    NavigationItem(id: 'dashboard', label: 'Dashboard', icon: Icons.dashboard_outlined, selectedIcon: Icons.dashboard),
    NavigationItem(id: 'analytics', label: 'Analytics', icon: Icons.analytics_outlined, selectedIcon: Icons.analytics),
    NavigationItem(id: 'products', label: 'Products', icon: Icons.inventory_outlined, selectedIcon: Icons.inventory),
    NavigationItem(id: 'customers', label: 'Customers', icon: Icons.people_outline, selectedIcon: Icons.people),
    NavigationItem(id: 'settings', label: 'Settings', icon: Icons.settings_outlined, selectedIcon: Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'AdStacks Dashboard',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
        ),
        const SizedBox(width: AppSizes.spacingS),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsGrid(),
          const SizedBox(height: AppSizes.spacingXl),
          _buildChartsSection(),
          const SizedBox(height: AppSizes.spacingXl),
          _buildActivitiesSection(),
          const SizedBox(height: AppSizes.spacingXl),
          _buildProductsSection(),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    final stats = DataService.getDashboardStats();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSizes.spacingM,
        mainAxisSpacing: AppSizes.spacingM,
        childAspectRatio: 1.2,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) => StatsCard(stats: stats[index]),
    );
  }

  Widget _buildChartsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Analytics Overview',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSizes.spacingL),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.spacingL),
            child: Column(
              children: [
                const Text(
                  'Traffic Sources',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSizes.spacingL),
                DonutChart(
                  data: DataService.getChartData(),
                  size: 180,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivitiesSection() {
    return ActivityCard(activities: DataService.getRecentActivities());
  }

  Widget _buildProductsSection() {
    final products = DataService.getPopularProducts();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Popular Products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spacingL),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSizes.spacingM,
            mainAxisSpacing: AppSizes.spacingM,
            childAspectRatio: 0.75,
          ),
          itemCount: products.take(6).length,
          itemBuilder: (context, index) => ProductCard(product: products[index]),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() => _selectedIndex = index),
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: _navigationItems.map((item) {
        final isSelected = _navigationItems.indexOf(item) == _selectedIndex;
        return BottomNavigationBarItem(
          icon: Icon(isSelected ? (item.selectedIcon ?? item.icon) : item.icon),
          label: item.label,
        );
      }).toList(),
    );
  }
}
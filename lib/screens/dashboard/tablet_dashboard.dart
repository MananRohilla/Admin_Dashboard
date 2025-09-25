import 'package:flutter/material.dart';
import '../../core/constants/app_sizes.dart';
import '../../models/navigation_item.dart';
import '../../services/data_service.dart';
import '../../widgets/dashboard/stats_card.dart';
import '../../widgets/dashboard/activity_card.dart';
// import '../../widgets/dashboard/product_card.dart';
import '../../widgets/charts/donut_chart.dart';
import '../../widgets/charts/animated_chart.dart';

class TabletDashboard extends StatefulWidget {
  const TabletDashboard({Key? key}) : super(key: key);

  @override
  State<TabletDashboard> createState() => _TabletDashboardState();
}

class _TabletDashboardState extends State<TabletDashboard> {
  int _selectedIndex = 0;

  final List<NavigationItem> _navigationItems = [
    NavigationItem(id: 'dashboard', label: 'Dashboard', icon: Icons.dashboard_outlined),
    NavigationItem(id: 'analytics', label: 'Analytics', icon: Icons.analytics_outlined),
    NavigationItem(id: 'products', label: 'Products', icon: Icons.inventory_outlined),
    NavigationItem(id: 'customers', label: 'Customers', icon: Icons.people_outline),
    NavigationItem(id: 'orders', label: 'Orders', icon: Icons.shopping_cart_outlined),
    NavigationItem(id: 'settings', label: 'Settings', icon: Icons.settings_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Row(
        children: [
          _buildNavigationRail(),
          const VerticalDivider(width: 1),
          Expanded(child: _buildMainContent()),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        'AdStacks Dashboard - Tablet View',
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
        const SizedBox(width: AppSizes.spacingM),
        const CircleAvatar(
          radius: 16,
          backgroundColor: Colors.blue,
          child: Text('AD', style: TextStyle(fontSize: 12, color: Colors.white)),
        ),
        const SizedBox(width: AppSizes.spacingM),
      ],
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) => setState(() => _selectedIndex = index),
      labelType: NavigationRailLabelType.selected,
      backgroundColor: Theme.of(context).colorScheme.surface,
      destinations: _navigationItems.map((item) {
        return NavigationRailDestination(
          icon: Icon(item.icon),
          label: Text(item.label),
        );
      }).toList(),
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeSection(),
          const SizedBox(height: AppSizes.spacingXl),
          _buildStatsGrid(),
          const SizedBox(height: AppSizes.spacingXl),
          _buildChartsRow(),
          const SizedBox(height: AppSizes.spacingXl),
          _buildContentRow(),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingL),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, Admin!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingS),
                  Text(
                    'Here\'s what\'s happening with your business today.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                ),
                borderRadius: BorderRadius.circular(AppSizes.radiusL),
              ),
              child: const Icon(
                Icons.dashboard,
                color: Colors.white,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    final stats = DataService.getDashboardStats();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: AppSizes.spacingM,
        mainAxisSpacing: AppSizes.spacingM,
        childAspectRatio: 1.3,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) => StatsCard(
        stats: stats[index],
        useGlassEffect: true,
      ),
    );
  }

  Widget _buildChartsRow() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.spacingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Revenue Trend',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingL),
                  AnimatedLineChart(
                    data: DataService.getLineChartData(),
                    dataKey: 'revenue',
                    height: 250,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSizes.spacingM),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.spacingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Traffic Sources',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingL),
                  DonutChart(
                    data: DataService.getChartData(),
                    size: 200,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              ActivityCard(activities: DataService.getRecentActivities()),
              const SizedBox(height: AppSizes.spacingL),
              _buildQuickActions(),
            ],
          ),
        ),
        const SizedBox(width: AppSizes.spacingM),
        Expanded(
          child: _buildTopProducts(),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.spacingL),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: AppSizes.spacingM,
              mainAxisSpacing: AppSizes.spacingM,
              childAspectRatio: 2,
              children: [
                _buildActionButton('Add Product', Icons.add_shopping_cart, Colors.blue),
                _buildActionButton('New Customer', Icons.person_add, Colors.green),
                _buildActionButton('View Reports', Icons.analytics, Colors.orange),
                _buildActionButton('Settings', Icons.settings, Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, Color color) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(AppSizes.radiusM),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spacingM),
          child: Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: AppSizes.spacingS),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopProducts() {
    final products = DataService.getPopularProducts().take(4).toList();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Top Products',
                  style: TextStyle(
                    fontSize: 18,
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
            ...products.map((product) => _buildProductListItem(product)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductListItem( product) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacingM),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.purple],
              ),
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
            ),
            child: const Icon(
              Icons.phone_iphone,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSizes.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSizes.spacingXs),
                Text(
                  '₹${product.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.star, size: 12, color: Colors.orange),
              const SizedBox(width: AppSizes.spacingXs),
              Text(
                product.rating.toStringAsFixed(1),
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
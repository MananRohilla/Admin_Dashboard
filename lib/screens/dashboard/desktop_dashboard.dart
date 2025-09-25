import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../models/navigation_item.dart';
import '../../services/data_service.dart';
import '../../widgets/dashboard/stats_card.dart';
import '../../widgets/dashboard/activity_card.dart';
import '../../widgets/dashboard/product_card.dart';
import '../../widgets/charts/donut_chart.dart';
import '../../widgets/charts/animated_chart.dart';
// import '../../widgets/common/glass_container.dart';

class DesktopDashboard extends StatefulWidget {
  const DesktopDashboard({Key? key}) : super(key: key);

  @override
  State<DesktopDashboard> createState() => _DesktopDashboardState();
}

class _DesktopDashboardState extends State<DesktopDashboard> {
  int _selectedIndex = 0;

  final List<NavigationItem> _navigationItems = [
    NavigationItem(id: 'dashboard', label: 'Dashboard', icon: Icons.dashboard_outlined),
    NavigationItem(id: 'analytics', label: 'Analytics', icon: Icons.analytics_outlined, badge: '5'),
    NavigationItem(id: 'products', label: 'Products', icon: Icons.inventory_outlined),
    NavigationItem(id: 'customers', label: 'Customers', icon: Icons.people_outline, isNew: true),
    NavigationItem(id: 'orders', label: 'Orders', icon: Icons.shopping_cart_outlined),
    NavigationItem(id: 'marketing', label: 'Marketing', icon: Icons.campaign_outlined),
    NavigationItem(id: 'reports', label: 'Reports', icon: Icons.assessment_outlined),
    NavigationItem(id: 'settings', label: 'Settings', icon: Icons.settings_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(child: _buildMainContent()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: AppSizes.sidebarWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSidebarHeader(),
          Expanded(child: _buildSidebarContent()),
          _buildSidebarFooter(),
        ],
      ),
    );
  }

  Widget _buildSidebarHeader() {
    return Container(
      height: AppSizes.appBarHeight,
      padding: const EdgeInsets.all(AppSizes.spacingL),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
            ),
            child: const Icon(
              Icons.auto_graph,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSizes.spacingM),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'AdStacks',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Dashboard Pro',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarContent() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spacingL),
      itemCount: _navigationItems.length,
      itemBuilder: (context, index) {
        final item = _navigationItems[index];
        final isSelected = index == _selectedIndex;
        
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacingM,
            vertical: AppSizes.spacingXs,
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
              onTap: () => setState(() => _selectedIndex = index),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.spacingM,
                  vertical: AppSizes.spacingM,
                ),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppColors.primary.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppSizes.radiusM),
                  border: isSelected
                      ? Border.all(color: AppColors.primary.withOpacity(0.3))
                      : null,
                ),
                child: Row(
                  children: [
                    Icon(
                      item.icon,
                      color: isSelected 
                          ? AppColors.primary
                          : Colors.grey[600],
                      size: 20,
                    ),
                    const SizedBox(width: AppSizes.spacingM),
                    Expanded(
                      child: Text(
                        item.label,
                        style: TextStyle(
                          color: isSelected 
                              ? AppColors.primary
                              : Colors.grey[700],
                          fontWeight: isSelected 
                              ? FontWeight.w600
                              : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    if (item.badge != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.spacingS,
                          vertical: AppSizes.spacingXs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(AppSizes.radiusS),
                        ),
                        child: Text(
                          item.badge!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    if (item.isNew) ...[
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSidebarFooter() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.spacingL),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primary,
            child: Text(
              'AD',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: AppSizes.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Admin User',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'admin@adstacks.in',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, size: 16),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'profile',
                child: Text('Profile'),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: AppSizes.appBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacingXl),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            'Dashboard Overview',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          _buildSearchBar(),
          const SizedBox(width: AppSizes.spacingL),
          _buildTopBarActions(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: 300,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: const Icon(Icons.search, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacingM,
            vertical: AppSizes.spacingM,
          ),
        ),
      ),
    );
  }

  Widget _buildTopBarActions() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
        ),
        const SizedBox(width: AppSizes.spacingS),
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {},
        ),
        const SizedBox(width: AppSizes.spacingM),
        Container(
          width: 1,
          height: 30,
          color: Colors.grey[300],
        ),
        const SizedBox(width: AppSizes.spacingM),
        const CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.primary,
          child: Text(
            'AD',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spacingXl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsSection(),
          const SizedBox(height: AppSizes.spacingXl),
          _buildChartsSection(),
          const SizedBox(height: AppSizes.spacingXl),
          _buildContentSection(),
          const SizedBox(height: AppSizes.spacingXl),
          _buildProductsGrid(),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    final stats = DataService.getDashboardStats();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: AppSizes.spacingL,
        mainAxisSpacing: AppSizes.spacingL,
        childAspectRatio: 1.4,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) => StatsCard(
        stats: stats[index],
        useGlassEffect: true,
      ),
    );
  }

  Widget _buildChartsSection() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.spacingXl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Revenue Analytics',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        value: 'Last 12 months',
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(value: 'Last 12 months', child: Text('Last 12 months')),
                          DropdownMenuItem(value: 'Last 6 months', child: Text('Last 6 months')),
                          DropdownMenuItem(value: 'Last 3 months', child: Text('Last 3 months')),
                        ],
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacingXl),
                  AnimatedLineChart(
                    data: DataService.getLineChartData(),
                    dataKey: 'revenue',
                    height: 300,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSizes.spacingL),
        Expanded(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.spacingL),
                  child: Column(
                    children: [
                      const Text(
                        'Traffic Sources',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
              const SizedBox(height: AppSizes.spacingL),
              _buildQuickStats(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Stats',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.spacingL),
            _buildQuickStatItem('Conversion Rate', '3.2%', Icons.trending_up, Colors.green),
            _buildQuickStatItem('Avg. Order Value', '₹2,430', Icons.shopping_cart, Colors.blue),
            _buildQuickStatItem('Bounce Rate', '42%', Icons.trending_down, Colors.orange),
            _buildQuickStatItem('Page Views', '15.2K', Icons.visibility, Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatItem(String title, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacingM),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: AppSizes.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: ActivityCard(activities: DataService.getRecentActivities()),
        ),
        const SizedBox(width: AppSizes.spacingL),
        Expanded(
          child: _buildTopCustomers(),
        ),
      ],
    );
  }

  Widget _buildTopCustomers() {
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
                  'Top Customers',
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
            ...List.generate(5, (index) => _buildCustomerItem(index)),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerItem(int index) {
    final names = ['John Doe', 'Jane Smith', 'Mike Johnson', 'Sarah Wilson', 'David Brown'];
    final amounts = ['₹15,230', '₹12,450', '₹11,200', '₹10,800', '₹9,500'];
    final colors = [Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.red];
    
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacingM),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: colors[index].withOpacity(0.1),
            child: Text(
              names[index][0],
              style: TextStyle(
                color: colors[index],
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: AppSizes.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  names[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Customer since 2023',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amounts[index],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid() {
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
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Product'),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spacingL),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: AppSizes.spacingL,
            mainAxisSpacing: AppSizes.spacingL,
            childAspectRatio: 0.8,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) => ProductCard(product: products[index]),
        ),
      ],
    );
  }
}
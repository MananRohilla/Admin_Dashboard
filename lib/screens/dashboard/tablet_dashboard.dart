import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../models/dashboard_data.dart';
import '../../services/data_service.dart';
import '../../widgets/dashboard/activity_card.dart';
import '../../widgets/dashboard/product_card.dart';
import '../../widgets/charts/animated_chart.dart';

class TabletDashboard extends StatelessWidget {
  const TabletDashboard({super.key});
  
  @override
  Widget build(BuildContext context) {
    final data = DataService.getDashboardData();
    
    return Scaffold(
      body: Row(
        children: [
          _buildSidebar(context),
          Expanded(
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSizes.paddingLG),
                    child: Column(
                      children: [
                        _buildHeroSection(),
                        const SizedBox(height: AppSizes.paddingLG),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  _buildProjectsSection(data.projects),
                                  const SizedBox(height: AppSizes.paddingLG),
                                  _buildChartSection(data.chartData),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppSizes.paddingLG),
                            Expanded(
                              child: ActivityCard(
                                title: 'Top Creators',
                                creators: data.topCreators,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 250,
      color: AppColors.sidebarBackground,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.paddingLG),
            child: const Row(
              children: [
                Icon(Icons.business, color: AppColors.primary, size: 32),
                SizedBox(width: 8),
                Text(
                  'AdStacks',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView(
              children: [
                _buildNavItem(Icons.home, 'Home', true),
                _buildNavItem(Icons.people, 'Employees', false),
                _buildNavItem(Icons.assignment, 'Attendance', false),
                _buildNavItem(Icons.summarize, 'Summary', false),
                _buildNavItem(Icons.info, 'Information', false),
              ],
            ),
          ),
          const Divider(),
          _buildNavItem(Icons.settings, 'Settings', false),
          _buildNavItem(Icons.logout, 'Logout', false),
          const SizedBox(height: AppSizes.paddingLG),
        ],
      ),
    );
  }
  
  Widget _buildNavItem(IconData icon, String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.sidebarSelected : null,
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: () {},
      ),
    );
  }
  
  Widget _buildAppBar() {
    return Container(
      height: AppSizes.appBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLG),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: AppColors.textLight,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          const Text(
            'Home',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Container(
            width: 300,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.paddingLG),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: AppSizes.paddingSM),
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&dpr=2',
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingXL),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ETHEREUM 2.0',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Top Rating\nProject',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Trending project and high rating\nProject Created by team.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.3),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Learn More'),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.paddingXL),
          Container(
            width: 200,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusLG),
              color: Colors.white.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildProjectsSection(List<ProjectData> projects) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLG),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'All Projects',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSizes.paddingLG),
          ...projects.map((project) => ProductCard(project: project)),
        ],
      ),
    );
  }
  
  Widget _buildChartSection(ChartData chartData) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLG),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Over All Performance\nThe Years',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSizes.paddingLG),
          AnimatedChart(
            data: chartData,
            height: 250,
          ),
        ],
      ),
    );
  }
}
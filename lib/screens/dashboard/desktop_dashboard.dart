import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../models/dashboard_data.dart';
import '../../services/data_service.dart';
import '../../services/auth_service.dart';
import '../../widgets/dashboard/activity_card.dart';
import '../../widgets/dashboard/product_card.dart';
import '../../widgets/charts/animated_chart.dart';
import '../../widgets/common/animated_counter.dart';

class DesktopDashboard extends StatelessWidget {
  const DesktopDashboard({super.key});
  
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
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
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
                                    child: _buildProjectsSection(data.projects),
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
                              const SizedBox(height: AppSizes.paddingLG),
                              _buildChartSection(data.chartData),
                            ],
                          ),
                        ),
                      ),
                      _buildRightPanel(data),
                    ],
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
      width: AppSizes.sidebarWidth,
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
          const SizedBox(height: AppSizes.paddingLG),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLG),
            padding: const EdgeInsets.all(AppSizes.paddingLG),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppSizes.radiusLG),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(AuthService.currentUserAvatar),
                ),
                const SizedBox(height: AppSizes.paddingMD),
                Text(
                  AuthService.currentUserName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSizes.paddingSM),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingMD,
                    vertical: AppSizes.paddingSM,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                  ),
                  child: Text(
                    AuthService.currentUserRole,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.paddingLG),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
              children: [
                _buildNavItem(Icons.home, 'Home', true),
                _buildNavItem(Icons.people, 'Employees', false),
                _buildNavItem(Icons.assignment, 'Attendance', false),
                _buildNavItem(Icons.summarize, 'Summary', false),
                _buildNavItem(Icons.info, 'Information', false),
                const SizedBox(height: AppSizes.paddingLG),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
                  child: Text(
                    'WORKSPACES',
                    style: TextStyle(
                      color: AppColors.textLight,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.paddingMD),
                _buildExpandableNavItem('Adstacks', [
                  'Projects',
                  'Team',
                  'Analytics',
                ]),
                _buildExpandableNavItem('Finance', [
                  'Reports',
                  'Budgets',
                  'Invoices',
                ]),
              ],
            ),
          ),
          const Divider(),
          _buildNavItem(Icons.settings, 'Setting', false),
          _buildNavItem(Icons.logout, 'Logout', false),
          const SizedBox(height: AppSizes.paddingLG),
        ],
      ),
    );
  }
  
  Widget _buildNavItem(IconData icon, String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.sidebarSelected : null,
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
          size: AppSizes.iconSM,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        onTap: () {},
      ),
    );
  }
  
  Widget _buildExpandableNavItem(String title, List<String> children) {
    return ExpansionTile(
      leading: const Icon(
        Icons.folder,
        color: AppColors.textSecondary,
        size: AppSizes.iconSM,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
      ),
      children: children.map((child) => 
        Padding(
          padding: const EdgeInsets.only(left: AppSizes.paddingXL),
          child: ListTile(
            title: Text(
              child,
              style: const TextStyle(
                color: AppColors.textLight,
                fontSize: 12,
              ),
            ),
            onTap: () {},
          ),
        ),
      ).toList(),
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
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.search, color: Colors.white70),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: AppSizes.paddingLG),
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.access_time),
            onPressed: () {},
          ),
          const SizedBox(width: AppSizes.paddingSM),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(AuthService.currentUserAvatar),
          ),
        ],
      ),
    );
  }
  
  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingXXL),
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
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Top Rating\nProject',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Trending project and high rating\nProject Created by team.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.3),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Learn More'),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.paddingXXL),
          Container(
            width: 250,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusLG),
              color: Colors.white.withOpacity(0.1),
            ),
            child: const Center(
              child: Icon(
                Icons.play_circle_outline,
                color: Colors.white,
                size: 64,
              ),
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
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Over All Performance\nThe Years',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: AppColors.chartSecondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Pending\nDone',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: AppColors.chartPrimary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Project\nDone',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingLG),
          AnimatedChart(
            data: chartData,
            height: 300,
          ),
        ],
      ),
    );
  }
  
  Widget _buildRightPanel(DashboardData data) {
    return Container(
      width: AppSizes.rightPanelWidth,
      color: AppColors.surfaceDark,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildCalendarSection(),
            _buildBirthdaySection(data.birthdays),
            _buildAnniversarySection(data.anniversaries),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCalendarSection() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'GENERAL 10:00 AM TO 7:00 PM',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSizes.paddingLG),
          Container(
            padding: const EdgeInsets.all(AppSizes.paddingLG),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.radiusLG),
            ),
            child: _buildCalendarWidget(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCalendarWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'OCT',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              '2023',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.paddingMD),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
              .map((day) => Text(
                    day,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textLight,
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: AppSizes.paddingMD),
        _buildCalendarGrid(),
      ],
    );
  }
  
  Widget _buildCalendarGrid() {
    final days = List.generate(31, (index) => index + 1);
    
    return SizedBox(
      height: 200, // Fixed height to prevent overflow
      child: GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: days.length,
      itemBuilder: (context, index) {
        final day = days[index];
        final isToday = day == 21;
        final isSelected = day == 24;
        
        return Container(
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary
                : isToday
                    ? AppColors.error
                    : null,
            borderRadius: BorderRadius.circular(AppSizes.radiusSM),
          ),
          child: Center(
            child: Text(
              day.toString(),
              style: TextStyle(
                color: isSelected || isToday
                    ? Colors.white
                    : AppColors.textPrimary,
                fontSize: 12,
                fontWeight: isSelected || isToday
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
          ),
        );
      },
      ),
    );
  }
  
  Widget _buildBirthdaySection(List<BirthdayData> birthdays) {
    return Container(
      margin: const EdgeInsets.only(
        left: AppSizes.paddingLG,
        right: AppSizes.paddingLG,
        bottom: AppSizes.paddingLG,
      ),
      padding: const EdgeInsets.all(AppSizes.paddingLG),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.cake,
                color: Colors.amber,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Today Birthday',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingMD),
          Wrap(
            spacing: 8,
            children: birthdays
                .take(2)
                .map((birthday) => CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(birthday.avatarUrl),
                    ))
                .toList(),
          ),
          const SizedBox(height: AppSizes.paddingMD),
          Row(
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              AnimatedCounter(
                value: birthdays.length,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingMD),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.birthdayColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 36),
            ),
            child: const Text('Birthday Wishing'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAnniversarySection(List<AnniversaryData> anniversaries) {
    return Container(
      margin: const EdgeInsets.only(
        left: AppSizes.paddingLG,
        right: AppSizes.paddingLG,
        bottom: AppSizes.paddingLG,
      ),
      padding: const EdgeInsets.all(AppSizes.paddingLG),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.celebration,
                color: Colors.amber,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Anniversary',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingMD),
          Wrap(
            spacing: 8,
            children: anniversaries
                .take(3)
                .map((anniversary) => CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(anniversary.avatarUrl),
                    ))
                .toList(),
          ),
          const SizedBox(height: AppSizes.paddingMD),
          Row(
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              AnimatedCounter(
                value: anniversaries.length,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingMD),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.anniversaryColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 36),
            ),
            child: const Text('Anniversary Wishing'),
          ),
        ],
      ),
    );
  }
}
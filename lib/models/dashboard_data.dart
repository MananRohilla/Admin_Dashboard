class DashboardData {
  final List<ProjectData> projects;
  final List<CreatorData> topCreators;
  final ChartData chartData;
  final List<BirthdayData> birthdays;
  final List<AnniversaryData> anniversaries;
  
  DashboardData({
    required this.projects,
    required this.topCreators,
    required this.chartData,
    required this.birthdays,
    required this.anniversaries,
  });
}

class ProjectData {
  final String title;
  final String description;
  final String status;
  final double progress;
  final String imageUrl;
  
  ProjectData({
    required this.title,
    required this.description,
    required this.status,
    required this.progress,
    required this.imageUrl,
  });
}

class CreatorData {
  final String name;
  final String username;
  final int artworks;
  final double rating;
  final String avatarUrl;
  
  CreatorData({
    required this.name,
    required this.username,
    required this.artworks,
    required this.rating,
    required this.avatarUrl,
  });
}

class ChartData {
  final List<ChartPoint> pendingData;
  final List<ChartPoint> projectData;
  
  ChartData({
    required this.pendingData,
    required this.projectData,
  });
}

class ChartPoint {
  final String year;
  final double value;
  
  ChartPoint({
    required this.year,
    required this.value,
  });
}

class BirthdayData {
  final String name;
  final String avatarUrl;
  final DateTime date;
  
  BirthdayData({
    required this.name,
    required this.avatarUrl,
    required this.date,
  });
}

class AnniversaryData {
  final String name;
  final String avatarUrl;
  final DateTime date;
  final int years;
  
  AnniversaryData({
    required this.name,
    required this.avatarUrl,
    required this.date,
    required this.years,
  });
}
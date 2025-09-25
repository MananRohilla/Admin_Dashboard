import '../models/dashboard_data.dart';

class DataService {
  static DashboardData getDashboardData() {
    return DashboardData(
      projects: [
        ProjectData(
          title: 'Technology behind the Blockchain',
          description: 'Project #1 • See project details',
          status: 'Active',
          progress: 0.75,
          imageUrl: 'https://images.pexels.com/photos/844124/pexels-photo-844124.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&dpr=2',
        ),
        ProjectData(
          title: 'Technology behind the Blockchain',
          description: 'Project #2 • See project details',
          status: 'Active',
          progress: 0.60,
          imageUrl: 'https://images.pexels.com/photos/1181677/pexels-photo-1181677.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&dpr=2',
        ),
        ProjectData(
          title: 'Technology behind the Blockchain',
          description: 'Project #3 • See project details',
          status: 'Active',
          progress: 0.85,
          imageUrl: 'https://images.pexels.com/photos/3861969/pexels-photo-3861969.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&dpr=2',
        ),
      ],
      topCreators: [
        CreatorData(
          name: '@maddison_c21',
          username: 'maddison_c21',
          artworks: 9821,
          rating: 97.5,
          avatarUrl: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&dpr=2',
        ),
        CreatorData(
          name: '@karl.will02',
          username: 'karl.will02',
          artworks: 7032,
          rating: 92.8,
          avatarUrl: 'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&dpr=2',
        ),
        CreatorData(
          name: '@maddison_c21',
          username: 'maddison_c21',
          artworks: 9821,
          rating: 95.2,
          avatarUrl: 'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&dpr=2',
        ),
        CreatorData(
          name: '@maddison_c21',
          username: 'maddison_c21',
          artworks: 9821,
          rating: 89.7,
          avatarUrl: 'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&dpr=2',
        ),
      ],
      chartData: ChartData(
        pendingData: [
          ChartPoint(year: '2015', value: 25),
          ChartPoint(year: '2016', value: 35),
          ChartPoint(year: '2017', value: 20),
          ChartPoint(year: '2018', value: 45),
          ChartPoint(year: '2019', value: 30),
          ChartPoint(year: '2020', value: 40),
        ],
        projectData: [
          ChartPoint(year: '2015', value: 20),
          ChartPoint(year: '2016', value: 30),
          ChartPoint(year: '2017', value: 25),
          ChartPoint(year: '2018', value: 50),
          ChartPoint(year: '2019', value: 35),
          ChartPoint(year: '2020', value: 45),
        ],
      ),
      birthdays: [
        BirthdayData(
          name: 'John Doe',
          avatarUrl: 'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&dpr=2',
          date: DateTime.now(),
        ),
        BirthdayData(
          name: 'Jane Smith',
          avatarUrl: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&dpr=2',
          date: DateTime.now(),
        ),
      ],
      anniversaries: [
        AnniversaryData(
          name: 'Mike Johnson',
          avatarUrl: 'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&dpr=2',
          date: DateTime.now(),
          years: 5,
        ),
        AnniversaryData(
          name: 'Sarah Wilson',
          avatarUrl: 'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&dpr=2',
          date: DateTime.now(),
          years: 3,
        ),
        AnniversaryData(
          name: 'David Brown',
          avatarUrl: 'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&dpr=2',
          date: DateTime.now(),
          years: 7,
        ),
      ],
    );
  }
}
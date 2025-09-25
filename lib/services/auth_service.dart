class AuthService {
  static const String _currentUserName = 'Pooja Mishra';
  static const String _currentUserRole = 'Admin';
  static const String _currentUserAvatar = 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=100&h=100&dpr=2';
  
  static String get currentUserName => _currentUserName;
  static String get currentUserRole => _currentUserRole;
  static String get currentUserAvatar => _currentUserAvatar;
  
  static bool get isAuthenticated => true;
  
  static Future<void> logout() async {
    // Implement logout logic
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
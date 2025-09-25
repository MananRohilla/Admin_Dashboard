class AuthService {
  static bool _isInitialized = false;
  static String? _userToken;
  static Map<String, dynamic>? _userData;

  static Future<void> initialize() async {
    // Simulate initialization delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Simulate loading user data
    _userData = {
      'name': 'Admin User',
      'email': 'admin@adstacks.in',
      'role': 'Administrator',
      'avatar': 'AD',
    };
    
    _userToken = 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}';
    _isInitialized = true;
  }

  static bool get isInitialized => _isInitialized;
  static String? get userToken => _userToken;
  static Map<String, dynamic>? get userData => _userData;
  
  static bool get isAuthenticated => _userToken != null;
}
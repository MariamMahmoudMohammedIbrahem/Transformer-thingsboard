

import '../commons.dart';

class AppProvider extends ChangeNotifier{

  String? _isFirstTime;
  final String _email = '';
  final String _password = '';
  bool get firstTimeCheck => _isFirstTime?.isEmpty ?? true;
  String get emailCheck => _email;
  String get passwordCheck => _password;

  Future<String?> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isFirstTime = prefs.getString('first_time') ?? '';
    return _isFirstTime;
  }

  Future<void> setFirstTime(String token, String apiEndpoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('first_time', token);
    await prefs.setString('email', emailUser);
    await prefs.setString('password', password);
    await prefs.setString('api_end-point', apiEndpoint);
    notifyListeners();
  }

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  Future<void> checkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('dark_theme') ?? false;

    notifyListeners();
  }

  Future<void> setTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = isDark;
    await prefs.setBool('dark_theme', isDark);
    notifyListeners();
  }
}
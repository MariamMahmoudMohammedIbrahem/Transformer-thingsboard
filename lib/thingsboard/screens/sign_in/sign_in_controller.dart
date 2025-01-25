part of 'sign_in_screen.dart';

abstract class SignInController extends State<SignInScreen> {

  final formKey = GlobalKey<FormState>();
  final emailUserController = TextEditingController();
  final passwordController = TextEditingController();
  String selectedMethod = 'Local';
  String authentication = '01019407823trans';
  final authenticationController = TextEditingController();
  final apiEndIp = TextEditingController();
  final apiEndPort = TextEditingController();
  bool hidePassword = true;
  bool rememberPassword = false;
  /*bool notFound = false; ///TODO:setting to true and resetting*/
  void login(BuildContext context) async {
    try {
      await tbClient.login(LoginRequest(emailUser, password));
      token = tbClient.getJwtToken()!;
      if (rememberPassword) {
        Provider.of<AppProvider>(context, listen: false).setFirstTime(token);
      }
      await FirebaseApi().initNotification();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const GlobalConnectionChecker(
            child: BottomNavigation(),
          ),
        ),
      );
      /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavigation()),
      );*/
    } catch (e) {
      // Handling specific errors
      String errorMessage = 'An unexpected error occurred.';

      if (e is ThingsboardError) {
        if (e.message!.contains('Unable to connect') || e.errorCode == 2) {
          errorMessage = 'Network error. Please check your internet connection.';
        } else {
          errorMessage = 'ThingsBoard error';
        }
      } else if (e is NetworkException) {
        errorMessage = 'Network error. Please check your internet connection.';
      } else if (e is AuthenticationException) {
        errorMessage = 'Invalid credentials. Please check your email and password.';
      } else if (e is TimeoutException) {
        errorMessage = 'Request timed out. Please try again later.';
      }
      _showErrorDialog(context, errorMessage);
    }
  }

// Helper method to show error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }


  bool isEmailValid(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    return emailRegex.hasMatch(email);
  }
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Network error']);
}

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException([this.message = 'Authentication error']);
}
part of 'forget_password_screen.dart';

abstract class ForgetPasswordController extends State<ForgetPasswordScreen> {

  TextEditingController emailController = TextEditingController();

  bool isEmailValid(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    return emailRegex.hasMatch(email);
  }
}
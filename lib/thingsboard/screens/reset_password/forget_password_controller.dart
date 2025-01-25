part of 'forget_password_screen.dart';

abstract class ForgetPasswordController extends State<ForgetPasswordScreen> {

  TextEditingController emailController = TextEditingController();
  /*bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }*/
  bool isEmailValid(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    return emailRegex.hasMatch(email);
  }

  /*Future<void> resetPassword(String email) async {
    final url = Uri.parse('$thingsBoardApiEndpoint/api/noauth/resetPassword');

    try {
      setState(() {
        _isLoading = true;
      });

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Password reset email sent successfully.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        final responseBody = json.decode(response.body);
        throw Exception(responseBody['message'] ?? 'Failed to reset password.');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }*/
}
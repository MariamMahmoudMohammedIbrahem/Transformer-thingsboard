
import '../../commons.dart';
part 'forget_password_controller.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  createState() => _ForgetPasswordScreen();
}

class _ForgetPasswordScreen extends ForgetPasswordController {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: const Text('FORGOT PASSWORD',),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Mail Address Here',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,),),
            const Text('write the email address associated with your account',style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,),
            height16,
            const Align(alignment:Alignment.centerLeft,child: Text('Email', style: TextStyle(fontWeight: FontWeight.w900),)),
            height8,
            TextFormField(
              controller: emailController,
              cursorColor: MyColors.blueDark,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                } else if (!isEmailValid(value)) {
                  return 'Enter a valid email address';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey,),
                hintText: 'user@example.com',
                hintStyle: const TextStyle(color: Colors.grey),
                floatingLabelStyle:
                MaterialStateTextStyle.resolveWith(
                        (Set<MaterialState> states) {
                      final Color color =
                      states.contains(MaterialState.error)
                          ? Theme.of(context).colorScheme.error
                          : MyColors.blueDark;
                      return TextStyle(
                          color: color,
                          letterSpacing: 1.3,
                          fontWeight: FontWeight.bold,
                          fontSize: 18);
                    }),
                labelStyle: MaterialStateTextStyle.resolveWith(
                        (Set<MaterialState> states) {
                      final Color color =
                      states.contains(MaterialState.error)
                          ? Theme.of(context).colorScheme.error
                          : MyColors.blueLight;
                      return TextStyle(color: color, letterSpacing: 1.3);
                    }),
                border: InputBorder.none,
              ),
              onChanged: (value) async {
                emailUser = value;
              },
            ),
            height8,
            ElevatedButton(
              onPressed: (){
                try {
                  tbClient.sendResetPasswordLink(emailUser);
                  tbClient.changePassword('currentPassword', 'newPassword');
                }
                catch(e){
                  throw Exception("Failed to send the reset password link $e");
                }
              },
              child: const Text('Recover Password',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
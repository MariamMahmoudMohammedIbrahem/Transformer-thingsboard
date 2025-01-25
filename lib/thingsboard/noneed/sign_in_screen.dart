/*
import '../../commons.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome Back to the App',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email Address',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: emailUserController,
                        cursorColor: const Color(0xFF305680),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          } else if (!isEmailValid(value)) {
                            return 'Enter a valid email address';
                          } else if (notFound) {
                            return 'This Email is not Signed Up';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'user@example.com',
                          floatingLabelStyle:
                              MaterialStateTextStyle.resolveWith(
                                  (Set<MaterialState> states) {
                            final Color color =
                                states.contains(MaterialState.error)
                                    ? Theme.of(context).colorScheme.error
                                    : const Color(0xFF305680);
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
                                    : const Color(0xFF4A6380);
                            return TextStyle(color: color, letterSpacing: 1.3);
                          }),
                          focusedBorder: const UnderlineInputBorder(
                            // borderRadius:
                            //     BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color(0xFF4A6380),
                            ),
                          ),
                          border: UnderlineInputBorder(
                            // borderRadius:
                            //     BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        onChanged: (value) async {
                          emailUser = value;

                          ///TODO: need to do something?
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        cursorColor: const Color(0xFF305680),
                        keyboardType: TextInputType.text,
                        obscureText: showPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xFF305680),
                            ),
                            onPressed: () {
                              if (showPassword == true) {
                                setState(() {
                                  showPassword = false;
                                });
                              } else {
                                setState(() {
                                  showPassword = true;
                                });
                              }
                            },
                          ),
                          hintText: 'password',
                          floatingLabelStyle:
                              MaterialStateTextStyle.resolveWith(
                                  (Set<MaterialState> states) {
                            final Color color =
                                states.contains(MaterialState.error)
                                    ? Theme.of(context).colorScheme.error
                                    : const Color(0xFF305680);
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
                                    : const Color(0xFF305680);
                            return TextStyle(
                                color: color, letterSpacing: 1.3, fontSize: 20);
                          }),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Color(0xFF113F67),
                            ),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: rememberPassword,
                      onChanged: (value) {
                        setState(() {
                          rememberPassword = value!;
                        });
                      },
                    ),
                    const Text(
                      'Keep me logged in',
                      style: TextStyle(
                          color: Color(0xFF305680),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: width * .7,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        login(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill input')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xFF4A6380),
                      backgroundColor: const Color(0xFF164980),
                      disabledForegroundColor: const Color(0xFF164980),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/

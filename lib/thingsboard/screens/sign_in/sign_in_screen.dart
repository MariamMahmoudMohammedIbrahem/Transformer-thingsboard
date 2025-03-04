import '../../commons.dart';

part 'sign_in_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  createState() => _SignInScreen();
}

class _SignInScreen extends SignInController {
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
                GestureDetector(
                  onLongPress: () {
                    showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                scrollable: true,
                                title: const Text('Authentication'),
                                content: Column(
                                  children: [
                                    TextFormField(
                                      controller: authenticationController,
                                      cursorColor: MyColors.blueDark,
                                      obscureText: hidePassword,
                                      autocorrect: false,
                                      decoration: InputDecoration(
                                        hintText: 'password',
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            hidePassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: MyColors.blueDark,
                                          ),
                                          onPressed: () {
                                            if (hidePassword == true) {
                                              setState(() {
                                                hidePassword = false;
                                              });
                                            } else {
                                              setState(() {
                                                hidePassword = true;
                                              });
                                            }
                                          },
                                        ),
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
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: MyColors.blueLight,
                                          ),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(onPressed: (){
                                        Navigator.pop(context);
                                        authenticationController.clear();
                                      }, child: const Text('Cancel',style: TextStyle(color: Colors.white),),),
                                      ElevatedButton(onPressed: (){
                                        if(authenticationController.text == authentication){
                                          Navigator.pop(context);
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  scrollable: true,
                                                  title: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'Login Options',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 23,
                                                          color: MyColors.blueBoldLight,
                                                        ),
                                                      ),
                                                      DropdownButton<String>(
                                                          value: selectedMethod,
                                                          items: const [
                                                            DropdownMenuItem(
                                                              value: 'Local',
                                                              child: Text(
                                                                'Local',
                                                              ),
                                                            ),
                                                            DropdownMenuItem(
                                                              value: 'Demo',
                                                              child: Text('Demo'),
                                                            ),
                                                          ],
                                                          onChanged: (String? newValue) {
                                                            selectedMethod = newValue!;
                                                          }),
                                                    ],
                                                  ),
                                                  content: Column(
                                                    children: [
                                                      selectedMethod == 'Local'
                                                          ? Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          const Text(
                                                            'Port',
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 22,
                                                              color: MyColors.blueBoldLight,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(
                                                                left: 8.0),
                                                            child: TextFormField(
                                                              controller: apiEndPort,
                                                              cursorColor:
                                                              MyColors.blueDark,
                                                              decoration: InputDecoration(
                                                                floatingLabelStyle:
                                                                MaterialStateTextStyle
                                                                    .resolveWith((Set<
                                                                    MaterialState>
                                                                states) {
                                                                  final Color color = states
                                                                      .contains(
                                                                      MaterialState
                                                                          .error)
                                                                      ? Theme.of(context)
                                                                      .colorScheme
                                                                      .error
                                                                      : MyColors.blueDark;
                                                                  return TextStyle(
                                                                      color: color,
                                                                      letterSpacing: 1.3,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      fontSize: 18);
                                                                }),
                                                                labelStyle:
                                                                MaterialStateTextStyle
                                                                    .resolveWith((Set<
                                                                    MaterialState>
                                                                states) {
                                                                  final Color color = states
                                                                      .contains(
                                                                      MaterialState
                                                                          .error)
                                                                      ? Theme.of(context)
                                                                      .colorScheme
                                                                      .error
                                                                      : MyColors.blueLight;
                                                                  return TextStyle(
                                                                      color: color,
                                                                      letterSpacing: 1.3);
                                                                }),
                                                                focusedBorder:
                                                                const UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                    width: 2,
                                                                    color: MyColors.blueLight,
                                                                  ),
                                                                ),
                                                                border:
                                                                UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .grey.shade300,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const Text(
                                                            'IP',
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 22,
                                                              color: MyColors.blueBoldLight,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(
                                                                left: 8.0),
                                                            child: TextFormField(
                                                              controller: apiEndIp,
                                                              cursorColor: MyColors.blueDark,
                                                              decoration: InputDecoration(
                                                                floatingLabelStyle:
                                                                MaterialStateTextStyle
                                                                    .resolveWith((Set<
                                                                    MaterialState>
                                                                states) {
                                                                  final Color color = states
                                                                      .contains(
                                                                      MaterialState
                                                                          .error)
                                                                      ? Theme.of(context)
                                                                      .colorScheme
                                                                      .error
                                                                      : MyColors.blueDark;
                                                                  return TextStyle(
                                                                      color: color,
                                                                      letterSpacing: 1.3,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      fontSize: 18);
                                                                }),
                                                                labelStyle:
                                                                MaterialStateTextStyle
                                                                    .resolveWith((Set<
                                                                    MaterialState>
                                                                states) {
                                                                  final Color color = states
                                                                      .contains(
                                                                      MaterialState
                                                                          .error)
                                                                      ? Theme.of(context)
                                                                      .colorScheme
                                                                      .error
                                                                      : MyColors.blueLight;
                                                                  return TextStyle(
                                                                      color: color,
                                                                      letterSpacing: 1.3);
                                                                }),
                                                                focusedBorder:
                                                                const UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                    width: 2,
                                                                    color: MyColors.blueLight,
                                                                  ),
                                                                ),
                                                                border:
                                                                UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .grey.shade300,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                          : kEmptyWidget,
                                                    ],
                                                  ),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: const Text(
                                                            'Cancel',
                                                            style: TextStyle(color: Colors.white),
                                                          ),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            if (selectedMethod == 'Demo') {
                                                              setState(() {
                                                                thingsBoardApiEndpoint =
                                                                'https://demo.thingsboard.io';
                                                              });
                                                            } else {
                                                              if (apiEndPort.value
                                                                  .toString()
                                                                  .isNotEmpty &&
                                                                  apiEndIp.value
                                                                      .toString()
                                                                      .isNotEmpty) {
                                                                setState(() {
                                                                  thingsBoardApiEndpoint =
                                                                  'http://$apiEndIp:$apiEndPort';
                                                                });
                                                              }
                                                            }
                                                            Navigator.pop(context);
                                                          },
                                                          child: const Text(
                                                            'Update',
                                                            style: TextStyle(color: Colors.white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              });
                                          setState(() {
                                            authenticationController.clear();
                                          });
                                        }
                                      }, child: const Text('Next',style: TextStyle(color: Colors.white),),),
                                    ],
                                  ),
                                ],
                              );
                            });
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: MyColors.blueBoldLight,
                      ),
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
                height10,
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
                            color: MyColors.blueBoldLight,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: emailUserController,
                        cursorColor: MyColors.blueDark,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          } else if (!isEmailValid(value)) {
                            return 'Enter a valid email address';
                          } /*else if (notFound) {
                            return 'This Email is not Signed Up';
                          }*/
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
                          focusedBorder: const UnderlineInputBorder(
                            // borderRadius:
                            //     BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                              width: 2,
                              color: MyColors.blueLight,
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
                        },
                      ),
                      height10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: MyColors.blueBoldLight,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetPasswordScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Forget Password?',
                              style: TextStyle(color: MyColors.blueBoldLight),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: passwordController,
                        cursorColor: MyColors.blueDark,
                        keyboardType: TextInputType.text,
                        obscureText: hidePassword,
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
                              hidePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: MyColors.blueDark,
                            ),
                            onPressed: () {
                              if (hidePassword == true) {
                                setState(() {
                                  hidePassword = false;
                                });
                              } else {
                                setState(() {
                                  hidePassword = true;
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
                                    : MyColors.blueDark;
                            return TextStyle(
                                color: color, letterSpacing: 1.3, fontSize: 20);
                          }),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: MyColors.blueBoldDark,
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
                          color: MyColors.blueDark,
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

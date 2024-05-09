import 'package:admin/API/AuthenticationService/AuthToken/auth_token.dart';
import 'package:admin/API/AuthenticationService/service.dart';
import 'package:admin/Routes/routes.dart';
import 'package:admin/screens/main/main_screen.dart';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      content: const Text('Invalid Credentials. Please Retry.'),
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.white,
        onPressed: () {
          setState(() {});
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSuccessSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      content: const Text('Login Successful. Welcome.'),
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.white,
        onPressed: () {
          setState(() {});
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void toggle() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 550,
          child: Card(
            elevation: 5.0,
            margin: EdgeInsets.all(20.0),
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  SizedBox(height: 100.0),
                  Container(
                    width: 330,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Log In",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: 330,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Log in to access your Account",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 330,
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(10.0)),
                                labelText: 'Email'),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(
                          width: 330,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: hidePassword,
                            decoration: InputDecoration(
                                suffixIcon: TextButton(
                                  onPressed: toggle,
                                  child: Text(hidePassword ? "Show" : "Hide"),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                labelText: 'Password'),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                            width: 340,
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              child: const Text(
                                "Forgot Password",
                                style: TextStyle(color: Colors.blue),
                              ),
                              onPressed: () {},
                            )),
                        SizedBox(height: 10.0),
                        SizedBox(
                          width: 330,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                            color: Colors.blue)))),
                            onPressed: () {
                              String email = emailController.text;
                              String password = passwordController.text;
                              isAPIcallProcess = true;
                              if (email != '' && password != '') {
                                AuthService()
                                    .login(email, password)
                                    .then((response) async => {
                                          if (response.accessToken != "")
                                            {
                                              AuthClass().storeToken(
                                                  response.accessToken),
                                              RouteNavigation()
                                                  .navigateToRoute("/Sales"),
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MainScreen()),
                                              )
                                            }
                                          else
                                            {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Invalid Credentials. Try again'),
                                                ),
                                              ),
                                            }
                                        })
                                    .onError((error, stackTrace) => {
                                          if (error != "")
                                            {
                                              print(error),
                                              showSnackBar(context),
                                            }
                                        });
                              }
                            },
                            child: Text('Login'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

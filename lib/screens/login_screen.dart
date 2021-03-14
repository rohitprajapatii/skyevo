import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:skyevo/blocs/authBloc.dart';
import 'package:skyevo/components/Rounded_button.dart';
import 'package:skyevo/components/snackbar.dart';
import 'package:skyevo/components/title.dart';
import 'package:skyevo/constants/constants.dart';
import 'package:skyevo/screens/home_screen.dart';
import 'package:skyevo/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String email;
  String password;

  StreamSubscription<User> loginScreenSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginScreenSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginScreenSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                buildCenterTitle(),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    //Do something with the user input.
                    email = value;
                  },
                  decoration: kInputContainerDecoration.copyWith(
                      hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kInputContainerDecoration.copyWith(
                      hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                    selectedColor: Colors.blueAccent,
                    selectedText: 'Login',
                    onPressed: () async {
                      if (email != null && password != null) {
                        setState(() {
                          showSpinner = true;
                        });
                        final status = await authBloc
                            .signInWithEmailAndPassword(email, password);
                        if (status == false) {
                          setState(() {
                            showSpinner = false;
                          });
                          showInSnackBar(
                              context, "Invalid username or password.");
                        }
                      } else {
                        showInSnackBar(
                            context, "Please enter email and password.");
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have any account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()));
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.blueAccent),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

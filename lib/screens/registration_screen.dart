import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:skyevo/blocs/authBloc.dart';
import 'package:skyevo/components/Rounded_button.dart';
import 'package:skyevo/components/title.dart';
import 'package:skyevo/constants/constants.dart';
import 'package:skyevo/screens/home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  String email;
  String password;
  StreamSubscription<User> registrationScreenSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    registrationScreenSubscription = authBloc.currentUser.listen((user) {
      if (user != null) {
        Navigator.pop(context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    registrationScreenSubscription.cancel();
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
                  selectedText: 'Register',
                  selectedColor: Colors.indigo,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    final status = await authBloc
                        .createUserWithEmailAndPassword(email, password);
                    if (status == false) {
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

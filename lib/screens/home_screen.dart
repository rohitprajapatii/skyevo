import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyevo/blocs/authBloc.dart';
import 'package:skyevo/components/title.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription<User> chatScreenSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    chatScreenSubscription = authBloc.currentUser.listen((user) {
      if (user == null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    chatScreenSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.power_settings_new),
              onPressed: () {
                authBloc.logOut();
              })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WELCOME TO',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  wordSpacing: 10,
                  letterSpacing: 5),
            ),
            buildCenterTitle(),
          ],
        ),
      ),
    );
  }
}

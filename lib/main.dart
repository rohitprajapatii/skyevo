import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyevo/screens/home_screen.dart';
import 'package:skyevo/screens/login_screen.dart';

import 'blocs/authBloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        home: StreamBuilder<User>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.data == null) {
              return LoginScreen();
            } else {
              return HomeScreen();
            }
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

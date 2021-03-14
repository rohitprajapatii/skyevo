import 'package:firebase_auth/firebase_auth.dart';
import 'package:skyevo/services/authService.dart';

class AuthBloc {
  final authService = AuthService();

  Stream<User> get currentUser => authService.currentUser;

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      print('logging in with email and password');
      final loggedUser =
          await authService.signInWithEmailAndPassword(email, password);
      if (loggedUser.user == null) {
        return false;
      }
    } catch (e) {
      print('login screen error $e');
      return false;
    }
  }

  Future<bool> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final loggedUser =
          await authService.createUserWithEmailAndPassword(email, password);
      if (loggedUser.user == null) {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  logOut() {
    authService.logout();
    print('logging out user');
  }
}

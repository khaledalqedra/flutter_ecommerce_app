import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthServices {
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future<bool> registerWithEmailAndPassword(String email, String password);
  Future<bool> authenticateWithGoogle();
  User? CurrentUser();
  Future<void> logout();
}

class AuthServicesImpl implements AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    final UserCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    final user = UserCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> registerWithEmailAndPassword(
      String email, String password) async {
    final UserCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = UserCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  User? CurrentUser() {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> authenticateWithGoogle() async {
    final gUser = await GoogleSignIn().signIn();
    final gAuth = await gUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth?.accessToken,
      idToken: gAuth?.idToken);
     final UserCredential = await _firebaseAuth.signInWithCredential(credential);
    
    if (UserCredential.user != null) {
      return true;
    } else {
      return false;
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/services/auth_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthServices authServices = AuthServicesImpl();

  Future<void> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    emit(AuthLoading());

    try {
      await authServices.loginWithEmailAndPassword(email, password);

      emit(const AuthDone());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(const AuthError('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(const AuthError('Wrong password provided.'));
      } else {
        emit(AuthError(e.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(const AuthError('Something went wrong'));
    }
  }

  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    emit(AuthLoading());

    try {
      await authServices.registerWithEmailAndPassword(email, password);

      emit(const AuthDone());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(const AuthError('This email is already registered.'));
      } else if (e.code == 'weak-password') {
        emit(const AuthError('The password is too weak.'));
      } else if (e.code == 'invalid-email') {
        emit(const AuthError('The email address is invalid.'));
      } else {
        emit(AuthError(e.message ?? 'Registration failed'));
      }
    } catch (e) {
      emit(const AuthError('Something went wrong'));
    }
  }

  void checkAuth() {
    final user = authServices.CurrentUser();
    if (user != null) {
      emit(const AuthDone());
    }
  }

  Future<void> logout() async {
    emit(const AuthLoggingOut());
    try {
      await authServices.logout();
      emit(const AuthLoggedOut());
    } catch (e) {
      emit(AuthLogoutError(e.toString()));
    }
  }

  Future<void> authenticateWithGoogle() async {
    emit(const GoogleAuthenticating());
    try {
      final success = await authServices.authenticateWithGoogle();
      if (success) {
        emit(const GoogleAuthDone());
      } else {
        emit(const GoogleAuthError('Google authentication failed'));
      }
    } catch (e) {
      emit(GoogleAuthError(e.toString()));
    }
  }
}

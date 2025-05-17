import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:utavine/data/models/auth/create_user_auth.dart';

abstract class AuthFirebaseServices {
  Future<Either> signup(CreateUserAuth createUserAuth);
  Future<void> signin();
}

class AuthFirebaseServicesImpl extends AuthFirebaseServices {
  @override
  Future<Either> signup(CreateUserAuth createUserAuth) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: createUserAuth.email,
        password: createUserAuth.password,
      );
      return Right('User signed up successfully');
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';

      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else {
        errorMessage = 'Error: ${e.message}';
      }
      return Left(errorMessage);
    }
  }

  @override
  Future<void> signin() async {}
}

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:utavine/core/error/failure.dart';
import 'package:utavine/data/models/auth/create_user_req.dart';
import 'package:utavine/data/models/auth/login_user_req.dart';
import 'package:utavine/domain/entities/auth/user.dart';

abstract class AuthFirebaseServices {
  Future<Either> signup(CreateUserReq createUserAuth);
  Future<Either> signin(LoginUserReq loginUserAuth);
}

class AuthFirebaseServicesImpl extends AuthFirebaseServices {
  // Signup Auth
  @override
  Future<Either<Failure, UserEntity>> signup(
    CreateUserReq createUserAuth,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: createUserAuth.email,
            password: createUserAuth.password,
          );

      final user = credential.user;

      if (user != null) {
        return Right(
          UserEntity(
            fullName: createUserAuth.fullName,
            email: user.email ?? '',
          ),
        );
      } else {
        return Left(ServerFailure('User creation failed.'));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'email-already-in-use') {
        errorMessage = 'This email is already registered.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'This email address is invalid.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'The password is too weak.';
      } else {
        errorMessage = e.message ?? 'An unknown error occurred.';
      }

      return Left(ServerFailure(errorMessage));
    }
  }

  // Signin Auth
  @override
  Future<Either<Failure, UserEntity>> signin(LoginUserReq loginUserAuth) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginUserAuth.email,
        password: loginUserAuth.password,
      );

      final user = credential.user;

      if (user != null) {
        return Right(UserEntity(fullName: '', email: user.email ?? ''));
      } else {
        return Left(ServerFailure('Login Failed.'));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided.';
      } else {
        errorMessage = e.message ?? 'An unknown error occurred.';
      }

      return Left(ServerFailure(errorMessage));
    }
  }
}

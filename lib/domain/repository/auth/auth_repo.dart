// import 'package:dartz/dartz.dart';
// import 'package:utavine/data/models/auth/create_user_auth.dart';

// abstract class AuthRepository{
//   Future<Either> signup(CreateUserAuth createUserAuth);
//   Future<void> signin();
// }

import 'package:dartz/dartz.dart';
import 'package:utavine/data/models/auth/create_user_req.dart';
import 'package:utavine/core/error/failure.dart';
import 'package:utavine/data/models/auth/login_user_req.dart';
import 'package:utavine/domain/entities/auth/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signup(CreateUserReq createUserAuth);
  Future<Either<Failure, UserEntity>> signin(LoginUserReq loginUserAuth);
}

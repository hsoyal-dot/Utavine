import 'package:dartz/dartz.dart';
import 'package:utavine/data/models/auth/create_user_auth.dart';

abstract class AuthRepository{
  Future<Either> signup(CreateUserAuth createUserAuth);
  Future<void> signin();
}
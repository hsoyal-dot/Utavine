import 'package:dartz/dartz.dart';
import 'package:utavine/core/configs/usecase/usecase.dart';
import 'package:utavine/data/models/auth/create_user_auth.dart';
import 'package:utavine/domain/repository/auth/auth_repo.dart';
import 'package:utavine/service_locator.dart';

class SignupUsecase implements UseCase<Either, CreateUserAuth> {
  @override
  Future<Either> call(CreateUserAuth? params) {
    return sl<AuthRepository>().signup(params!);
  }
}
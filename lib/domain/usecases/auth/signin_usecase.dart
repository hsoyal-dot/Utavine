// import 'package:dartz/dartz.dart';
// import 'package:utavine/core/configs/usecase/usecase.dart';
// import 'package:utavine/data/models/auth/create_user_auth.dart';
// import 'package:utavine/domain/repository/auth/auth_repo.dart';
// import 'package:utavine/service_locator.dart';

// class SignupUsecase implements UseCase<Either, CreateUserAuth> {
//   @override
//   Future<Either> call({CreateUserAuth? params}) async {
//     return sl<AuthRepository>().signup(params!);
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:utavine/core/configs/usecase/usecase.dart';
import 'package:utavine/core/error/failure.dart';
import 'package:utavine/data/models/auth/login_user_req.dart';
import 'package:utavine/data/repository/auth/auth_repo_impl.dart';
import 'package:utavine/domain/entities/auth/user.dart';
import 'package:utavine/service_locator.dart';

class SigninUsecase
    implements UseCase<Either<Failure, UserEntity>, LoginUserReq> {
  @override
  Future<Either<Failure, UserEntity>> call(LoginUserReq params) async {
    return sl<AuthRepositoryImpl>().signin(params);
  }
}

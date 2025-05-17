import 'package:dartz/dartz.dart';
import 'package:utavine/data/models/auth/create_user_auth.dart';
import 'package:utavine/data/sources/auth/auth_firebase_services.dart';
import 'package:utavine/domain/repository/auth/auth_repo.dart';
import 'package:utavine/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<void> signin() {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<Either> signup(CreateUserAuth createUserAuth) async {
    return await sl<AuthFirebaseServicesImpl>().signup(createUserAuth);
  }
}

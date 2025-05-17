import 'package:get_it/get_it.dart';
import 'package:utavine/data/repository/auth/auth_repo_impl.dart';
import 'package:utavine/data/sources/auth/auth_firebase_services.dart';
import 'package:utavine/domain/usecases/auth/signup_usecase.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseServicesImpl>(AuthFirebaseServicesImpl());
  sl.registerSingleton<AuthRepositoryImpl>(AuthRepositoryImpl());
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:utavine/data/models/auth/create_user_auth.dart';

abstract class AuthFirebaseServices {
  Future<void> signup(CreateUserAuth createUserAuth);
  Future<void> signin();
}

class AuthFirebaseServicesImpl extends AuthFirebaseServices {
  @override
  Future<void> signup(CreateUserAuth createUserAuth) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: createUserAuth.email,
        password: createUserAuth.password,
      );
    } catch (e) {
      
    }
  }

  @override
  Future<void> signin() async {}
}

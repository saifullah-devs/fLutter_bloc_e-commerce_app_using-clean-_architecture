import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

abstract class SplashFirebaseService {
  Future<Either> isUserLoggedIn();
}

class SplashFirebaseServiceImpl extends SplashFirebaseService {
  @override
  Future<Either> isUserLoggedIn() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } catch (e) {
      return const Left('Authentication error');
    }
  }
}

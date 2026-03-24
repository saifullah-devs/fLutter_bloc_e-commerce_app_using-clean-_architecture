import 'package:dartz/dartz.dart';

abstract class SplashRepository {
  Future<Either> isUserLoggedIn();
}

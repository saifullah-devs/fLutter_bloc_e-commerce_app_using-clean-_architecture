import 'package:dartz/dartz.dart';
import 'package:e_commerce_bloc/features/splash/data/resource/splash_firebase_service.dart';
import '../../../../service_locator.dart';
import '../../domain/repository/splash_repository.dart';

class SplashRepositoryImpl extends SplashRepository {
  @override
  Future<Either> isUserLoggedIn() async {
    return await sl<SplashFirebaseService>().isUserLoggedIn();
  }
}

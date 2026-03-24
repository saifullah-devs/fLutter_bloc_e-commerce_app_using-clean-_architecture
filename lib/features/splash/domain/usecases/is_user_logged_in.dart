import 'package:dartz/dartz.dart';
import 'package:e_commerce_bloc/core/usecase/usecase.dart';
import 'package:e_commerce_bloc/service_locator.dart';
import '../repository/splash_repository.dart';

class IsUserLoggedInUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SplashRepository>().isUserLoggedIn();
  }
}

import 'package:dartz/dartz.dart';
import 'package:e_commerce_bloc/core/usecase/usecase.dart';
import 'package:e_commerce_bloc/features/auth/auth_barrel.dart';
import 'package:e_commerce_bloc/service_locator.dart';

class GetUserUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<AuthRepository>().getUser();
  }
}

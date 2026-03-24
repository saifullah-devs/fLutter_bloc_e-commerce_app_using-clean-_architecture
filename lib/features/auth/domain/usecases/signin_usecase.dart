import 'package:dartz/dartz.dart';
import 'package:e_commerce_bloc/core/usecase/usecase.dart';

import '../../../../service_locator.dart';
import '../repository/auth.dart';

class SigninUseCase implements UseCase<Either, Map<String, dynamic>> {
  @override
  Future<Either> call({Map<String, dynamic>? params}) async {
    return await sl<AuthRepository>().signin(params!);
  }
}

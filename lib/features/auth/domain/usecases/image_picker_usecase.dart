// features/auth/domain/usecases/image_picker_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:e_commerce_bloc/core/usecase/usecase.dart';
import 'package:e_commerce_bloc/features/auth/domain/repository/auth.dart';
import 'package:e_commerce_bloc/service_locator.dart';

class ImagePickerUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<AuthRepository>().imagePicker();
  }
}

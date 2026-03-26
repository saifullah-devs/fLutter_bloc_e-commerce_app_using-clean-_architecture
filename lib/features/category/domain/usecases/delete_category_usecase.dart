import 'package:dartz/dartz.dart';
import 'package:e_commerce_bloc/service_locator.dart';
import '../repositories/category.dart';

class DeleteCategoryUseCase {
  Future<Either> call(String categoryId) async {
    // Calling the repository we just built!
    return await sl<CategoryRepository>().deleteCategory(categoryId);
  }
}

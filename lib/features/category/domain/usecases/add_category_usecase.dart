import 'package:dartz/dartz.dart';
import 'package:e_commerce_bloc/service_locator.dart';
import '../../data/models/category.dart';
import '../repositories/category.dart';

class AddCategoryUseCase {
  Future<Either> call(CategoryModel category) async {
    // Calling the repository we just built!
    return await sl<CategoryRepository>().addCategory(category);
  }
}

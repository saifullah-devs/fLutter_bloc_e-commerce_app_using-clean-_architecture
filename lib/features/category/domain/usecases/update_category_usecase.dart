import 'package:dartz/dartz.dart';
import 'package:e_commerce_bloc/service_locator.dart';
import '../../data/models/category.dart';
import '../repositories/category.dart';

class UpdateCategoryUseCase {
  Future<Either> call(CategoryModel category) async {
    return await sl<CategoryRepository>().updateCategory(category);
  }
}

import 'package:e_commerce_bloc/core/response/api_response.dart';
import 'package:e_commerce_bloc/features/category/domain/entities/category.dart';
import 'package:e_commerce_bloc/features/category/domain/usecases/get_category_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../service_locator.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc()
    : super(CategoryState(getcategoriesResponse: ApiResponse.loading())) {
    on<DisplayCategoriesEvent>(_onDisplayCategories);
  }

  Future<void> _onDisplayCategories(
    DisplayCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(getcategoriesResponse: const ApiResponse.loading()));

    try {
      var returnedData = await sl<GetCategoriesUseCase>().call();

      returnedData.fold(
        (error) {
          emit(
            state.copyWith(
              getcategoriesResponse: ApiResponse.error(error.toString()),
            ),
          );
        },
        (data) {
          emit(
            state.copyWith(
              categoryList: List<CategoryEntity>.from(data),
              getcategoriesResponse: ApiResponse.completed(data),
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          getcategoriesResponse: ApiResponse.error(
            "Unexpected Bloc Error: ${e.toString()}",
          ),
        ),
      );
    }
  }
}

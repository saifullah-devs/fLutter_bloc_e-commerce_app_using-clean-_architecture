import 'package:e_commerce_bloc/core/response/api_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_bloc/features/category/data/models/category.dart';
import '../../../../service_locator.dart';
import '../../../category/domain/usecases/category_usecase.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(const AdminState()) {
    on<AdminAddCategoryEvent>(_onAddCategory);
    on<AdminUpdateCategoryEvent>(_onUpdateCategory);
    on<AdminDeleteCategoryEvent>(_onDeleteCategory);
  }

  Future<void> _onAddCategory(
    AdminAddCategoryEvent event,
    Emitter<AdminState> emit,
  ) async {
    emit(state.copyWith(addCategoryResponse: const ApiResponse.loading()));

    final result = await sl<AddCategoryUseCase>().call(event.category);

    result.fold(
      (error) {
        emit(
          state.copyWith(
            addCategoryResponse: ApiResponse.error(error.toString()),
          ),
        );
      },
      (successMessage) {
        emit(
          state.copyWith(
            addCategoryResponse: ApiResponse.completed(
              successMessage as String,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onUpdateCategory(
    AdminUpdateCategoryEvent event,
    Emitter<AdminState> emit,
  ) async {
    emit(state.copyWith(updateCategoryResponse: const ApiResponse.loading()));

    final result = await sl<UpdateCategoryUseCase>().call(event.category);

    result.fold(
      (error) {
        emit(
          state.copyWith(
            updateCategoryResponse: ApiResponse.error(error.toString()),
          ),
        );
      },
      (successMessage) {
        emit(
          state.copyWith(
            updateCategoryResponse: ApiResponse.completed(
              successMessage as String,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onDeleteCategory(
    AdminDeleteCategoryEvent event,
    Emitter<AdminState> emit,
  ) async {
    emit(state.copyWith(deleteCategoryResponse: const ApiResponse.loading()));

    final result = await sl<DeleteCategoryUseCase>().call(event.categoryId);

    result.fold(
      (error) {
        emit(
          state.copyWith(
            deleteCategoryResponse: ApiResponse.error(error.toString()),
          ),
        );
      },
      (successMessage) {
        emit(
          state.copyWith(
            deleteCategoryResponse: ApiResponse.completed(
              successMessage as String,
            ),
          ),
        );
      },
    );
  }
}

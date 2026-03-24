import 'package:e_commerce_bloc/core/response/api_response.dart';
import 'package:e_commerce_bloc/features/auth/domain/usecases/get_ages_usecase.dart';
import 'package:e_commerce_bloc/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'user_requirements_event.dart';
part 'user_requirements_state.dart';

class UserRequirementsBloc
    extends Bloc<UserRequirementsEvent, UserRequirementsState> {
  UserRequirementsBloc() : super(const UserRequirementsState()) {
    on<SelectGenderEvent>((event, emit) {
      emit(state.copyWith(selectedGender: event.genderIndex));
    });

    on<SelectAgeEvent>((event, emit) {
      emit(state.copyWith(selectedAge: event.age));
    });

    on<DisplayAgesEvent>((event, emit) async {
      emit(state.copyWith(agesResponse: const ApiResponse.loading()));

      var returnedData = await sl<GetAgesUseCase>().call();

      returnedData.fold(
        (message) =>
            emit(state.copyWith(agesResponse: ApiResponse.error(message))),
        (data) =>
            emit(state.copyWith(agesResponse: ApiResponse.completed(data))),
      );
    });
  }
}

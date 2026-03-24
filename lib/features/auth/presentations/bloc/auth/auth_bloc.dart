import 'package:e_commerce_bloc/core/response/api_response.dart';
import 'package:e_commerce_bloc/features/auth/data/models/user_creation_req.dart';
import 'package:e_commerce_bloc/features/auth/domain/usecases/send_password_reset_email_usecase.dart';
import 'package:e_commerce_bloc/features/auth/domain/usecases/signin_usecase.dart';
import 'package:e_commerce_bloc/features/auth/domain/usecases/signout_usecase.dart';
import 'package:e_commerce_bloc/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
    : super(
        const AuthState(
          signOutResponse: ApiResponse.initial(),
          signinResponse: ApiResponse.initial(),
          signupResponse: ApiResponse.initial(),
          passwordResetResponse: ApiResponse.initial(),
        ),
      ) {
    on<SignupEvent>(_onSignup);
    on<SigninEvent>(_onSignin);
    on<SignOutEvent>(_onSignOut);
    on<SendPasswordResetEmailEvent>(_onSendPasswordResetEmail);
  }

  Future<void> _onSignup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(signupResponse: const ApiResponse.loading()));

    final result = await sl<SignupUsecase>().call(params: event.userReq);

    result.fold(
      (message) =>
          emit(state.copyWith(signupResponse: ApiResponse.error(message))),
      (data) =>
          emit(state.copyWith(signupResponse: ApiResponse.completed(data))),
    );
  }

  Future<void> _onSignin(SigninEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(signinResponse: const ApiResponse.loading()));

    final result = await sl<SigninUseCase>().call(
      params: {'email': event.email, 'password': event.password},
    );

    result.fold(
      (message) =>
          emit(state.copyWith(signinResponse: ApiResponse.error(message))),
      (data) =>
          emit(state.copyWith(signinResponse: ApiResponse.completed(data))),
    );
  }

  Future<void> _onSendPasswordResetEmail(
    SendPasswordResetEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(passwordResetResponse: const ApiResponse.loading()));

    final result = await sl<SendPasswordResetEmailUseCase>().call(
      params: event.email,
    );

    result.fold(
      (message) => emit(
        state.copyWith(passwordResetResponse: ApiResponse.error(message)),
      ),
      (data) => emit(
        state.copyWith(passwordResetResponse: ApiResponse.completed(data)),
      ),
    );
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(signOutResponse: const ApiResponse.loading()));

    final result = await sl<SignOutUseCase>().call();

    result.fold(
      (message) =>
          emit(state.copyWith(signOutResponse: ApiResponse.error(message))),
      (data) =>
          emit(state.copyWith(signOutResponse: ApiResponse.completed(data))),
    );
  }
}

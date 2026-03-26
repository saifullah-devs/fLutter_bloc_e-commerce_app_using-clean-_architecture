import 'package:e_commerce_bloc/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../service_locator.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(DisplaySplash()) {
    on<AppStartedEvent>(_onAppStarted);
  }

  Future<void> _onAppStarted(
    AppStartedEvent event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    final result = await sl<GetUserUseCase>().call();

    result.fold(
      (failure) {
        // ADD THIS:
        print("=== DEBUG: Fetch Failed! Error: $failure ===");
        emit(UnAuthenticated());
      },
      (user) {
        // ADD THESE:
        print("=== DEBUG: User fetch SUCCESS ===");
        print("=== DEBUG: Email: ${user.email} ===");
        print("=== DEBUG: Role exactly parsed as: '${user.role}' ===");

        if (user.role == 'admin') {
          emit(const Authenticated(isAdmin: true));
        } else {
          emit(const Authenticated(isAdmin: false));
        }
      },
    );
  }
}

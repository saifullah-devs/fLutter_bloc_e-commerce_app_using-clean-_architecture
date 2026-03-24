import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_bloc/features/splash/domain/usecases/is_user_logged_in.dart';
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

    final result = await sl<IsUserLoggedInUseCase>().call();

    result.fold((failure) => emit(UnAuthenticated()), (isLoggedIn) {
      if (isLoggedIn) {
        emit(Authenticated());
      } else {
        emit(UnAuthenticated());
      }
    });
  }
}

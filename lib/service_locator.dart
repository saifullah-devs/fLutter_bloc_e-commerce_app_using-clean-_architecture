import 'package:e_commerce_bloc/features/auth/auth_barrel.dart';
import 'package:e_commerce_bloc/features/splash/splash_barrel.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Blocs
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc());
  sl.registerLazySingleton<UserRequirementsBloc>(() => UserRequirementsBloc());

  // Services
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceimpl());
  sl.registerSingleton<SplashFirebaseService>(SplashFirebaseServiceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SplashRepository>(SplashRepositoryImpl());

  // Usecases
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<GetAgesUseCase>(GetAgesUseCase());
  sl.registerSingleton<IsUserLoggedInUseCase>(IsUserLoggedInUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<SignOutUseCase>(SignOutUseCase());
  sl.registerSingleton<SendPasswordResetEmailUseCase>(
    SendPasswordResetEmailUseCase(),
  );
}

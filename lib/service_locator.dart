import 'package:e_commerce_bloc/features/auth/auth_barrel.dart';
import 'package:e_commerce_bloc/features/auth/domain/usecases/image_picker_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Blocs
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc());
  sl.registerLazySingleton<UserRequirementsBloc>(() => UserRequirementsBloc());

  // Services
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceimpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // Usecases
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<GetAgesUseCase>(GetAgesUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
  sl.registerSingleton<IsUserLoggedInUseCase>(IsUserLoggedInUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<SignOutUseCase>(SignOutUseCase());
  sl.registerSingleton<SendPasswordResetEmailUseCase>(
    SendPasswordResetEmailUseCase(),
  );
  sl.registerSingleton<ImagePickerUseCase>(ImagePickerUseCase());
}

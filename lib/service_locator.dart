import 'package:e_commerce_bloc/features/category/presentation/bloc/category_bloc.dart';

import 'features/auth/auth_barrel.dart';
import 'features/category/category_barrel.dart';

import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Blocs
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc());
  sl.registerLazySingleton<UserRequirementsBloc>(() => UserRequirementsBloc());
  sl.registerLazySingleton<CategoryBloc>(() => CategoryBloc());

  // Services
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceimpl());
  sl.registerSingleton<CategoryFirebaseService>(CategoryFirebaseServiceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<CategoryRepository>(CategoryRepositoryImpl());

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
  sl.registerSingleton<GalleryImagePickerUseCase>(GalleryImagePickerUseCase());
  sl.registerSingleton<CameraImagePickerUseCase>(CameraImagePickerUseCase());
  sl.registerSingleton<NoneImagePickerUseCase>(NoneImagePickerUseCase());
  sl.registerSingleton<GetCategoriesUseCase>(GetCategoriesUseCase());
}

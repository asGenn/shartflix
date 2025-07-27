import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shartflix/core/error/dio_error_interceptor.dart';
import 'package:shartflix/config/navigation/navigation_service.dart';
import 'package:shartflix/config/navigation/navigation_service_impl.dart';
import 'package:shartflix/core/shared/services/analytics_service.dart';
import 'package:shartflix/core/shared/services/logger_service.dart';
import 'package:shartflix/core/shared/widgets/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:shartflix/features/auth/data/data_sources/local/secure_storage_service.dart';
import 'package:shartflix/features/auth/data/data_sources/local/secure_storage_service_impl.dart';
import 'package:shartflix/features/auth/data/data_sources/remote/user_api_service.dart';
import 'package:shartflix/features/auth/data/repository/user_repository_impl.dart';
import 'package:shartflix/features/auth/domain/repository/user_repository.dart';
import 'package:shartflix/features/auth/domain/usecases/login_use_case.dart';
import 'package:shartflix/features/auth/domain/usecases/register_use_case.dart';
import 'package:shartflix/features/auth/domain/usecases/upload_photo_use_case.dart';
import 'package:shartflix/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:shartflix/features/auth/presentation/bloc/signup/signup_bloc.dart';
import 'package:shartflix/features/auth/presentation/bloc/upload_photo/upload_photo_bloc.dart';
// Movie feature imports
import 'package:shartflix/features/main/data/data_sources/remote/movie_api_service.dart';
import 'package:shartflix/features/main/data/data_sources/remote/user_profile_api_service.dart';
import 'package:shartflix/features/main/data/repository/movie_repository_impl.dart';
import 'package:shartflix/features/main/data/repository/profile_repository_impl.dart';
import 'package:shartflix/features/main/data/repository/user_repository_impl.dart';
import 'package:shartflix/features/main/domain/repository/main_user_repository.dart';
import 'package:shartflix/features/main/domain/repository/movie_repository.dart';
import 'package:shartflix/features/main/domain/repository/profile_repository.dart';
import 'package:shartflix/features/main/domain/usecases/get_favorite_movies_use_case.dart';
import 'package:shartflix/features/main/domain/usecases/get_movies_use_case.dart';
import 'package:shartflix/features/main/domain/usecases/toggle_favorite_use_case.dart';
import 'package:shartflix/features/main/domain/usecases/update_profile_photo_use_case.dart';
import 'package:shartflix/features/main/presentation/bloc/home/home_bloc.dart';
import 'package:shartflix/features/main/presentation/bloc/profile/profile_bloc.dart';
import 'package:shartflix/features/main/presentation/bloc/profile_photo/profile_photo_bloc.dart';
import 'package:shartflix/features/splash/bloc/splash_bloc.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // Initialize logger service
  final loggerService = LoggerService();
  loggerService.init();
  sl.registerLazySingleton<LoggerService>(() => loggerService);

  // Analytics service
  sl.registerLazySingleton<AnalyticsService>(() => AnalyticsService());

  // secure storage
  sl.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());

  final secureStorageService = SecureStorageService(sl());
  sl.registerLazySingleton<AuthLocalStorage>(() => secureStorageService);
  sl.registerLazySingleton<SecureStorageService>(() => secureStorageService);

  // dio
  final dio = Dio();
  dio.interceptors.add(DioErrorInterceptor());

  //navigation
  sl.registerLazySingleton<NavigationService>(() => NavigationServiceImpl());

  // Register services...
  sl.registerSingleton<Dio>(dio);

  // Auth dependencies
  sl.registerLazySingleton<UserApiService>(() => UserApiService(sl()));
  sl.registerLazySingleton<UserRepositoryImpl>(
    () => UserRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<UserRepository>(() => sl<UserRepositoryImpl>());

  // Main dependencies
  sl.registerLazySingleton<UserProfileApiService>(
    () => UserProfileApiService(sl()),
  );

  // Movie dependencies
  sl.registerLazySingleton<MovieApiService>(() => MovieApiService(sl()));
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      sl<MovieApiService>(),
      sl<AuthLocalStorage>(),
      sl<Dio>(),
    ),
  );

  // Auth use cases
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));
  sl.registerLazySingleton<UploadPhotoUseCase>(() => UploadPhotoUseCase(sl()));

  // Movie use cases
  sl.registerLazySingleton<GetMoviesUseCase>(() => GetMoviesUseCase(sl()));
  sl.registerLazySingleton<GetFavoriteMoviesUseCase>(
    () => GetFavoriteMoviesUseCase(sl()),
  );
  sl.registerLazySingleton<ToggleFavoriteUseCase>(
    () => ToggleFavoriteUseCase(sl()),
  );

  // Profile use cases
  sl.registerLazySingleton<UpdateProfilePhotoUseCase>(
    () => UpdateProfilePhotoUseCase(sl()),
  );

  // Main dependencies

  sl.registerLazySingleton<MainUserRepository>(
    () => MainUserRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl(), sl()),
  );

  // Auth blocs
  sl.registerFactory<LoginBloc>(() => LoginBloc(sl(), sl()));
  sl.registerFactory<SignupBloc>(() => SignupBloc(sl(), sl()));
  sl.registerFactory<UploadPhotoBloc>(() => UploadPhotoBloc(sl()));
  sl.registerFactory<BottomNavigationBloc>(() => BottomNavigationBloc());

  // Movie blocs
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl(), sl()));
  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(getFavoriteMoviesUseCase: sl(), userRepository: sl()),
  );
  sl.registerFactory<ProfilePhotoBloc>(() => ProfilePhotoBloc(sl(), sl()));

  // Splash blocs
  sl.registerFactory<SplashBloc>(() => SplashBloc(sl()));
}

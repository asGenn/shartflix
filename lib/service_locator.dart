import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shartflix/core/error/dio_error_interceptor.dart';
import 'package:shartflix/features/auth/data/data_sources/remote/user_api_service.dart';
import 'package:shartflix/features/auth/data/repository/user_repository_impl.dart';
import 'package:shartflix/features/auth/domain/repository/user_repository.dart';
import 'package:shartflix/features/auth/domain/usecases/login_use_case.dart';
import 'package:shartflix/features/auth/presentation/bloc/login/login_bloc.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // dio
  final dio = Dio();
  dio.interceptors.add(DioErrorInterceptor());

  // Register services...
  sl.registerSingleton<Dio>(dio);

  // dependencies
  sl.registerLazySingleton<UserApiService>(() => UserApiService(sl()));

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));

  //usecase
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));

  //bloc
  sl.registerFactory<LoginBloc>(() => LoginBloc(sl()));
}

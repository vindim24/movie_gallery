import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_gallery/core/platform/network_info.dart';
import 'package:movie_gallery/feature/data/datasources/movie_local_data_source.dart';
import 'package:movie_gallery/feature/data/datasources/movie_remote_data_source.dart';
import 'package:movie_gallery/feature/domain/usecases/get_all_movies.dart';
import 'package:movie_gallery/feature/presentation/bloc/movies_list_cubit/movies_list_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/data/repositories/movie_repository_impl.dart';
import 'feature/domain/repositories/movie_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Cubit
  sl.registerFactory(
    () => MoviesListCubit(getAllMovies: sl()),
  );

  //UseCases
  sl.registerLazySingleton(
    () => GetAllMovies(sl()),
  );

  //Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(
      client: http.Client(),
    ),
  );

  sl.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );
  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

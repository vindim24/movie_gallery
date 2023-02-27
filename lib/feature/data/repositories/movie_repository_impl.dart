import 'package:dartz/dartz.dart';
import 'package:movie_gallery/core/error/failure.dart';
import 'package:movie_gallery/feature/data/datasources/movie_local_data_source.dart';
import 'package:movie_gallery/feature/data/datasources/movie_remote_data_source.dart';
import 'package:movie_gallery/feature/domain/entities/movie_entity.dart';
import 'package:movie_gallery/feature/domain/repositories/movie_repository.dart';

import '../../../core/error/exception.dart';
import '../../../core/platform/network_info.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<MovieEntity>>> getAllMovies(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMovie = await remoteDataSource.getAllMovies(page);
        localDataSource.setMoviesToCache(remoteMovie);
        return Right(remoteMovie);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try{
        final localMovie = await localDataSource.getLastMoviesFromCache();
        return Right(localMovie);
      } on CacheException{
        return Left(CacheFailure());
      }
    }
  }
}

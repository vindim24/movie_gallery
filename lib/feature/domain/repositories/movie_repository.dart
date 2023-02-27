import 'package:dartz/dartz.dart';
import 'package:movie_gallery/feature/domain/entities/movie_entity.dart';

import '../../../core/error/failure.dart';

abstract class MovieRepository{
  Future<Either<Failure,List<MovieEntity>>> getAllMovies(int page);
}


import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_gallery/core/usecases/usecase.dart';

import '../../../core/error/failure.dart';
import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetAllMovies extends UseCase<List<MovieEntity>, PageMovieParams>{
  final MovieRepository movieRepository;

  GetAllMovies(this.movieRepository);

  Future<Either<Failure,List<MovieEntity>>> call(PageMovieParams params) async {
    return await movieRepository.getAllMovies(params.page);
  }
}

class PageMovieParams extends Equatable{

  final int page;

  const PageMovieParams({required this.page});

  @override
  List<Object?> get props => [page];
}
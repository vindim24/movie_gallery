import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie_entity.dart';

abstract class MoviesState extends Equatable{
  const MoviesState();

  @override
  List<Object?> get props => [];
}

class MoviesEmpty extends MoviesState{
  @override
  List<Object?> get props => [];
}

class MoviesLoading extends MoviesState{
  final List<MovieEntity> oldMoviesList;
  final bool isFirstFetch;

  MoviesLoading(this.oldMoviesList, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldMoviesList];
}

class MoviesLoaded extends MoviesState{
  final List<MovieEntity> moviesList;

  const MoviesLoaded(this.moviesList);

  @override
  List<Object?> get props => [];
}


class MoviesError extends MoviesState{
  final String message;

  const MoviesError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
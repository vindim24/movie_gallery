import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_gallery/core/error/failure.dart';
import 'package:movie_gallery/feature/domain/entities/movie_entity.dart';

import '../../../domain/usecases/get_all_movies.dart';
import 'movies_list_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class MoviesListCubit extends Cubit<MoviesState> {
  final GetAllMovies getAllMovies;

  MoviesListCubit({required this.getAllMovies}) : super(MoviesEmpty());

  int page = 1;

  void loadMovies() async {
    if (state is MoviesLoading) return;

    final currentState = state;

    var oldMovie = <MovieEntity>[];
    if (currentState is MoviesLoaded) {
      oldMovie = currentState.moviesList;
    }

    emit(MoviesLoading(oldMovie, isFirstFetch: page == 1));

    final failureOrMovie = await getAllMovies(PageMovieParams(page: page));

    failureOrMovie.fold(
        (error) => emit(MoviesError(message: _mapFailureToMessage(error))),
        (movie) {
      page++;
      final movies = (state as MoviesLoading).oldMoviesList;
      movies.addAll(movie);
      emit(MoviesLoaded(movies));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}

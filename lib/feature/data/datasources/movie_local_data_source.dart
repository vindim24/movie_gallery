import 'dart:convert';

import 'package:movie_gallery/core/error/exception.dart';
import 'package:movie_gallery/feature/data/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MovieLocalDataSource {
  Future<List<MovieModel>> getLastMoviesFromCache();

  Future<void> setMoviesToCache(List<MovieModel> movies);
}

const CACHED_MOVIES_LIST = 'CACHED_MOVIES_LIST';

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final SharedPreferences sharedPreferences;

  MovieLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<MovieModel>> getLastMoviesFromCache() {
    final jsonMoviesList = sharedPreferences.getStringList(CACHED_MOVIES_LIST);
    if (jsonMoviesList != null && jsonMoviesList.isNotEmpty) {
      return Future.value(jsonMoviesList
          .map((movie) => MovieModel.fromJson(json.decode(movie)))
          .toList());
    } else {
      throw CacheException;
    }
  }

  @override
  Future<void> setMoviesToCache(List<MovieModel> movies) {
    final List<String> jsonMoviesList =
        movies.map((movie) => json.encode(movie.toJson())).toList();

    sharedPreferences.setStringList(CACHED_MOVIES_LIST, jsonMoviesList);
    print('Movies to write Cache: ${jsonMoviesList.length}');
    return Future.value(jsonMoviesList);
  }
}

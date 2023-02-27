import 'dart:convert';

import 'package:movie_gallery/core/error/exception.dart';
import 'package:movie_gallery/feature/data/models/movie_model.dart';
import 'package:http/http.dart' as http;

abstract class MovieRemoteDataSource{
  Future<List<MovieModel>> getAllMovies(int page);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {

  final http.Client client;

  static const String _BASE_URL = "https://api.themoviedb.org/3";
  static const String _IMAGE_URL = "https://image.tmdb.org/t/p/w500";
  static const String _API_KEY = "f3433e1fff6fbd43f694c177f7d256a9";

  MovieRemoteDataSourceImpl({required this.client});

  static String imageUrl(String poster_path) => _IMAGE_URL + poster_path;

  @override
  Future<List<MovieModel>> getAllMovies(int page) async {
    String _queryUrl = "/trending/movie/day?page=$page&api_key=$_API_KEY";
    final response = await client.get(
        Uri.parse(_BASE_URL + _queryUrl),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final movies = json.decode(response.body);
      print(movies['results']);
      return (movies['results'] as List).map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw ServerException();
    }
  }
}
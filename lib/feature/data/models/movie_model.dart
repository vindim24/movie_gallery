import 'package:movie_gallery/feature/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel(
      {required super.id,
      required super.title,
      required super.overview,
      required super.poster_path,
      required super.vote_average,
      required super.vote_count,
      required super.popularity,
      required super.release_date});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      poster_path: json['poster_path'],
      vote_average: json['vote_average'],
      vote_count: json['vote_count'],
      popularity: json['popularity'],
      release_date: json['release_date'],
    );
  }

  Map<String, dynamic> toJson() {
     return {
       'id': id,
       'title': title,
       'overview': overview,
       'posterPath': poster_path,
       'voteAverage': vote_average,
       'voteCount': vote_count,
       'popularity': popularity,
       'releaseDate': release_date,
     };
  }
}

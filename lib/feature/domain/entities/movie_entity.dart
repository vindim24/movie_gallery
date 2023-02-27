import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String poster_path;
  final double vote_average;
  final int vote_count;
  final double popularity;
  final String release_date;

  const MovieEntity(
      {required this.id,
      required this.title,
      required this.overview,
      required this.poster_path,
      required this.vote_average,
      required this.vote_count,
      required this.popularity,
      required this.release_date});

  @override
  List<Object?> get props => [id, title, overview, poster_path, vote_average, vote_count, popularity, release_date];
}

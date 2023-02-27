import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_gallery/common/app_colors.dart';
import 'package:movie_gallery/feature/domain/entities/movie_entity.dart';
import 'package:movie_gallery/feature/presentation/bloc/movies_list_cubit/movies_list_cubit.dart';
import 'package:movie_gallery/feature/presentation/bloc/movies_list_cubit/movies_list_state.dart';
import 'package:movie_gallery/feature/presentation/pages/detail_movies_screen.dart';
import 'package:movie_gallery/feature/presentation/widgets/movie_card_widget.dart';
import 'package:movie_gallery/feature/presentation/widgets/movies_cache_image_widget.dart';

class MoviesListWidget extends StatelessWidget {
  MoviesListWidget({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<MoviesListCubit>(context).loadMovies();
        }
      }
    });
  }

   // void jumpToStart() =>
   //    scrollController.jumpTo(scrollController.position.minScrollExtent);

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    bool _isLoading = false;
    return BlocBuilder<MoviesListCubit, MoviesState>(
      builder: (context, state) {

        List<MovieEntity> movies = [];

        if (state is MoviesLoading && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is MoviesLoading) {
          movies = state.oldMoviesList;
          _isLoading = true;
        } else if (state is MoviesLoaded) {
          movies = state.moviesList;
        } else if (state is MoviesError) {
          return SafeArea(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
          );
        }
        return SafeArea(
          child: ListView.builder(
              controller: scrollController,
              itemBuilder: (context, index) {
                if (index < movies.length) {
                  return MovieCardWidget(movie: movies[index]);
                } else {
                  Timer(const Duration(milliseconds: 40), () {
                    scrollController
                        .jumpTo(scrollController.position.maxScrollExtent);
                  });
                  return _loadingIndicator();
                }
              },
              itemCount: movies.length + (_isLoading ? 1 : 0)),
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

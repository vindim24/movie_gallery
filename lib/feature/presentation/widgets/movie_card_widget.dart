import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_gallery/feature/domain/entities/movie_entity.dart';

import '../../../common/app_colors.dart';
import '../pages/detail_movies_screen.dart';
import 'movies_cache_image_widget.dart';

class MovieCardWidget extends StatelessWidget {
  final MovieEntity movie;

  const MovieCardWidget({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailMoviesScreen(
                          movie: movie,
                        )),
              );
            },
            child: SizedBox(
              height: 146,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: AppColors.cellBackground,
                child: Row(
                  children: [
                    MoviesCacheImageWidget(
                      width: 110,
                      height: 146,
                      imageUrl: movie.poster_path,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: GoogleFonts.sarabun(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                "${movie.vote_average.toString()}/10 ",
                                style: GoogleFonts.sarabun(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.greyBackground),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 17,
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}

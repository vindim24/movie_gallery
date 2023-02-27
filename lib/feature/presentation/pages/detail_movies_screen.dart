import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_gallery/feature/domain/entities/movie_entity.dart';

import '../../../common/app_colors.dart';
import '../widgets/movies_cache_image_widget.dart';

class DetailMoviesScreen extends StatelessWidget {
  final MovieEntity movie;

  const DetailMoviesScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MoviesCacheImageWidget(
                    width: 200,
                    height: 246,
                    imageUrl: movie.poster_path,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          "Date of release:",
                          style: GoogleFonts.sarabun(
                            fontSize: 15,
                            color: AppColors.greyBackground
                          ),
                        ),
                        Text(
                          movie.release_date,
                          style: GoogleFonts.sarabun(
                            fontSize: 15,
                            color: AppColors.greyBackground,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      movie.overview,
                      style: GoogleFonts.sarabun(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${movie.vote_average.toString()}/10 ',
                              style: GoogleFonts.sarabun(
                                fontSize: 15,
                                color: AppColors.greyBackground,
                              ),
                            ),
                            const Icon(
                              Icons.star,
                              size: 15,
                              color: Colors.amber,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                        Row(
                          children: [
                            Text(
                              '${movie.vote_count.toString()} ',
                              style: GoogleFonts.sarabun(
                                fontSize: 15,
                                color: AppColors.greyBackground,
                              ),
                            ),
                            const Icon(
                              Icons.where_to_vote,
                              size: 15,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                        Row(
                          children: [
                            Text(
                              '${movie.popularity.round().toString()} ',
                              style: GoogleFonts.sarabun(
                                fontSize: 15,
                                color: AppColors.greyBackground,
                              ),
                            ),
                            const Icon(
                              Icons.people,
                              size: 15,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

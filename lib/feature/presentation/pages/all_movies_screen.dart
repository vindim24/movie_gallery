import 'package:flutter/material.dart';
import 'package:movie_gallery/feature/domain/entities/movie_entity.dart';

import '../widgets/movies_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MoviesListWidget(),
    );
  }
}

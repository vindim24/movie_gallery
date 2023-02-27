import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_gallery/common/app_colors.dart';
import 'package:movie_gallery/feature/presentation/bloc/movies_list_cubit/movies_list_cubit.dart';
import 'package:movie_gallery/locator_service.dart' as di;

import 'feature/presentation/pages/all_movies_screen.dart';
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesListCubit>(
            create: (context) => sl<MoviesListCubit>()..loadMovies()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        home: const HomePage(),
      ),
    );
  }
}


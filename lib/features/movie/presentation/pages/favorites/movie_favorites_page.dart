import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_movie/app/resources/routs.dart';
import 'package:test_movie/core/extentions/ext_failure.dart';
import 'package:test_movie/features/movie/data/models/route_arguments.dart';
import 'package:test_movie/features/movie/domain/entities/movie_entity.dart';
import 'package:test_movie/features/movie/presentation/pages/favorites/movie_favorites_cubit.dart';
import 'package:test_movie/features/movie/presentation/widgets/movie_favorites_item_widget.dart';
import 'package:test_movie/injection_container.dart';
import 'package:test_movie/share/failure_widget.dart';
import 'package:test_movie/share/progressbar_widget.dart';
import 'package:test_movie/generated/i18n.dart';

class MovieFavoritesPage extends StatefulWidget {
  const MovieFavoritesPage({super.key});

  @override
  State<MovieFavoritesPage> createState() => _MovieFavoritesPageState();
}

class _MovieFavoritesPageState extends State<MovieFavoritesPage> {
  final MovieFavoritesCubit _cubit = get<MovieFavoritesCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit..getMovies(),
      child: BlocBuilder<MovieFavoritesCubit, MovieFavoritesState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(S.of(context).movie_favorites_toolbar),
              centerTitle: true,
            ),
            body: Column(children: [Expanded(child: _getResultBody(state))]),
          );
        },
      ),
    );
  }

  Widget _getResultBody(MovieFavoritesState state) {
    if (state is StateInitial) {
      return HorizontalProgressBar();
    } else if (state is StateError) {
      return FailureWidget(
        failure: state.failure.message(context),
        retry: state.onRetry,
      );
    } else {
      return MovieFavoritesItemWidget(
        movies: _cubit.movies,
        onSelect: (MovieEntity movie) {
          if (movie.id != null) {
            _navigateToMovieInfo(movie.id!);
          }
        },
        onRefresh: _cubit.getMovies,
        onRemove: _cubit.removeFav,
      );
    }
  }

  void _navigateToMovieInfo(int movieId) {
    Navigator.pushNamed(
      context,
      routeMovieInfo,
      arguments: MovieInfoPageArguments(movieId: movieId),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_movie/features/movie/domain/usecases/delete_movie_usecase.dart';
import '/core/error/failure.dart';
import '/features/movie/domain/entities/movie_entity.dart';
import '/features/movie/domain/repositories/params.dart';
import '/features/movie/domain/usecases/query_movie_usecase.dart';

part 'movie_favorites_state.dart';

class MovieFavoritesCubit extends Cubit<MovieFavoritesState> {
  final QueryMoviesUseCase _queryMoviesUseCase;
  final DeleteMovieUseCase _deleteMovieUseCase;

  MovieFavoritesCubit(this._queryMoviesUseCase, this._deleteMovieUseCase)
    : super(StateInitial());

  List<MovieEntity> movies = [];

  Future<void> getMovies() async {
    final result = await _queryMoviesUseCase.call(
      QueryMovieParams(page: 0, isFavorite: true),
    );
    result.fold(
      (failure) {
        emit(StateError(failure, notify));
      },
      (data) {
        movies.clear();
        movies = data;
        notify();
      },
    );
  }

  void notify() => emit(StateRefresh(DateTime.now().toString()));

  Future<void> removeFav(MovieEntity movie) async {
    final result = await _deleteMovieUseCase.call(
      DeleteMovieParams(movieId: movie.id!),
    );
    result.fold(
      (failure) {
        emit(StateError(failure, notify));
      },
      (data) {
        movies.remove(movie);
        notify();
      },
    );
  }
}

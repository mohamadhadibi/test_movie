
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_movie/core/error/failure.dart';
import 'package:test_movie/features/movie/domain/entities/movie_entity.dart';
import 'package:test_movie/features/movie/domain/repositories/params.dart';
import 'package:test_movie/features/movie/domain/usecases/delete_movie_usecase.dart';
import 'package:test_movie/features/movie/domain/usecases/get_movie_usecase.dart';
import 'package:test_movie/features/movie/domain/usecases/submit_movie_usecase.dart';

part 'movie_info_state.dart';

class MovieInfoCubit extends Cubit<MovieInfoState> {
  final GetMovieUseCase _getMovieUseCase;
  final SubmitMovieUseCase _submitMovieUseCase;
  final DeleteMovieUseCase _deleteMovieUseCase;
  MovieInfoCubit(
    this._getMovieUseCase,
    this._submitMovieUseCase,
    this._deleteMovieUseCase,
  ) : super(StateInitial());

  late MovieEntity movie;

  Future<void> getMovie(int movieId) async {
    final result = await _getMovieUseCase.call(GetMovieParams(
      movieId: movieId,
    ));
    result.fold((failure) {
      emit(StateError(failure, notify));
    }, (data) {
      movie = data;
    });
  }

  Future<void> addRemoveFavorite() async {
    if(movie.getIsFav()) {
      await _removeFav();
    } else {
      await _addFav();
    }
  }

  Future<void> _addFav() async {
    final result = await _submitMovieUseCase.call(SubmitMovieParams(
      id: movie.id,
      title: movie.title,
      description: movie.description,
      poster: movie.poster,
      rate: movie.rate,
    ));
    result.fold((failure) {
      emit(StateError(failure, notify));
    }, (data) {
      movie.setIsFav(false);
      notify();
    });
  }

  Future<void> _removeFav() async {
    final result = await _deleteMovieUseCase.call(DeleteMovieParams(
      movieId: movie.id!,
    ));
    result.fold((failure) {
      emit(StateError(failure, notify));
    }, (data) {
      movie.setIsFav(true);
      notify();
    });
  }

  void notify() => emit(StateNotify(DateTime.now().toString()));

}
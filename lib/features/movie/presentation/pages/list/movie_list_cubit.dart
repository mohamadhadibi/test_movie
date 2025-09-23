import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/core/error/failure.dart';
import '/features/movie/domain/entities/movie_entity.dart';
import '/features/movie/domain/repositories/params.dart';
import '/features/movie/domain/usecases/query_movie_usecase.dart';

part 'movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  final QueryMoviesUseCase _queryMoviesUseCase;
  MovieListCubit(this._queryMoviesUseCase) : super(StateInitial());

  String searchText = '';
  QueryMovieParams params = QueryMovieParams(page: 0);

  Future<List<MovieEntity>> getMovies() async {
    final result = await _queryMoviesUseCase.call(params);
    return result.fold((failure) {
      emit(StateError(failure, notify));
      return [];
    }, (data) {
      params.page = params.page + 1;
      return data;
    });
  }

  void notify() => emit(StateRefresh(DateTime.now().toString()));

  void refreshList() {
    params.page = 1;
    notify();
  }

  Future<void> search() async {
    params.text = searchText;
    refreshList();
  }
}
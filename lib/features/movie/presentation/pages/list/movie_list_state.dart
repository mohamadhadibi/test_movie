part of 'movie_list_cubit.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();
}

class StateInitial extends MovieListState {
  @override
  List<Object> get props => [];
}

class StateError extends MovieListState {
  final Failure failure;
  final Function onRetry;

  const StateError(this.failure, this.onRetry);

  @override
  List<Object> get props => [failure, onRetry];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StateError && other.failure == failure
        && other.onRetry == onRetry;
  }

  @override
  int get hashCode => failure.hashCode;
}

class StateRefresh extends MovieListState {
  final String notify;

  const StateRefresh(this.notify);

  @override
  List<Object> get props => [notify];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StateRefresh && other.notify == notify;
  }

  @override
  int get hashCode => notify.hashCode;
}
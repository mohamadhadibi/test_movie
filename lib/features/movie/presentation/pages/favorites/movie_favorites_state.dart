part of 'movie_favorites_cubit.dart';

abstract class MovieFavoritesState extends Equatable {
  const MovieFavoritesState();
}

class StateInitial extends MovieFavoritesState {
  @override
  List<Object> get props => [];
}

class StateError extends MovieFavoritesState {
  final Failure failure;
  final Function onRetry;

  const StateError(this.failure, this.onRetry);

  @override
  List<Object> get props => [failure, onRetry];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StateError &&
        other.failure == failure &&
        other.onRetry == onRetry;
  }

  @override
  int get hashCode => failure.hashCode;
}

class StateRefresh extends MovieFavoritesState {
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

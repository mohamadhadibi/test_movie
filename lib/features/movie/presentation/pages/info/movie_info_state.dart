part of 'movie_info_cubit.dart';

abstract class MovieInfoState extends Equatable {
  const MovieInfoState();
}

class StateInitial extends MovieInfoState {
  @override
  List<Object> get props => [];
}

class StateError extends MovieInfoState {
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

class StateNotify extends MovieInfoState {
  final String notify;

  const StateNotify(this.notify);

  @override
  List<Object> get props => [notify];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StateNotify && other.notify == notify;
  }

  @override
  int get hashCode => notify.hashCode;
}
part of 'application_cubit.dart';

@immutable
class ApplicationState extends Equatable {
  final ThemeMode themeMode;
  const ApplicationState(this.themeMode);

  @override
  List<Object> get props => [themeMode];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApplicationState && other.themeMode == themeMode;
  }

  @override
  int get hashCode => themeMode.hashCode;
}

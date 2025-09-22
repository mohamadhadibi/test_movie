import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit()
      : super(ApplicationState(
          ThemeMode.light,
        ));

  List<Locale> localeList = [
    const Locale('en'),
  ];

  Future<void> getApplicationUiData() async {
    emit(ApplicationState(ThemeMode.light));
  }

  void changeTheme(ThemeMode theme) {
    emit(ApplicationState(ThemeMode.light));
  }
}

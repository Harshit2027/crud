import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(super.initialState) {
    _loadTheme();
  }

  void _loadTheme() {
    final isLight = state.themeMode == ThemeMode.light;
    emit(state.copyWith(themeMode: isLight ? ThemeMode.light : ThemeMode.dark, brightness: isLight ? Brightness.light : Brightness.dark));
  }

  void toggleTheme() {
    final isLight = state.themeMode == ThemeMode.light;

    emit(state.copyWith(themeMode: isLight ? ThemeMode.dark : ThemeMode.light, brightness: isLight ? Brightness.dark : Brightness.light));
  }

  void setTheme(ThemeMode mode) {
    emit(
      state.copyWith(
        themeMode: mode,
        brightness: mode == ThemeMode.dark
            ? Brightness.dark
            : Brightness.light,
      ),
    );
  }

  void setBrightness(Brightness brightness) {
    emit(
      state.copyWith(
        brightness: brightness,
        themeMode: brightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light,
      ),
    );
  }
}

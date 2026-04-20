part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final Brightness brightness;
  final ThemeMode themeMode;

  const ThemeState({
    required this.themeMode,
    this.brightness = Brightness.light,
  });

  @override
  List<Object?> get props => [themeMode, brightness];

  bool get isDarkTheme =>
      themeMode == ThemeMode.dark || brightness == Brightness.dark;

  ThemeState copyWith({ThemeMode? themeMode, Brightness? brightness}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      brightness: brightness ?? this.brightness,
    );
  }
}

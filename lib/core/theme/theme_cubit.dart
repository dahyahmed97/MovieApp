import 'package:fh_movie_app/core/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(true));

  void toggleTheme() {
    emit(ThemeState(!state.isLightTheme));
  }
}

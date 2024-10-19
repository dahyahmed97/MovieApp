import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  final bool isLightTheme;

  const ThemeState(this.isLightTheme);

  @override
  List<Object> get props => [isLightTheme];
}
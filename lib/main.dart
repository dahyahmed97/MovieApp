import 'package:fh_movie_app/core/navigation/routes_catalog.dart';
import 'package:fh_movie_app/core/navigation/routing.dart';
import 'package:fh_movie_app/core/theme/theme_cubit.dart';
import 'package:fh_movie_app/core/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/services/service_locator.dart';
import 'core/theme/theme_state.dart';
import 'features/cubits/favoritesCubit/favorites_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1440, 1024),
        // Set the design size for responsiveness
        builder: (context, child) {
          return MultiBlocProvider(
              providers: [
                BlocProvider<ThemeCubit>(
                    create: (BuildContext context) => ThemeCubit()),
                BlocProvider<FavoritesCubit>(
                    create: (BuildContext context) => FavoritesCubit()..fetchFavoriteMovies())
              ],
              child: BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, themeState) {
                    return MaterialApp(
                      title: 'FH Movie App',
                      theme: ThemeHelper()
                          .getTheme(isLight: themeState.isLightTheme),
                      debugShowCheckedModeBanner: false,
                      initialRoute: RoutesCatalog.homeScreen,
                      onGenerateRoute: AppRouter().generateRoute,
                    );
                  }));
        }
    );
  }
}

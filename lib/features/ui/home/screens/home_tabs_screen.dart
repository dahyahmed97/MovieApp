import 'package:fh_movie_app/core/theme/theme_cubit.dart';
import 'package:fh_movie_app/features/ui/favoriteMoviesScreen/favorite_movies_screen.dart';
import 'package:fh_movie_app/features/ui/home/screens/home_screen.dart';
import 'package:fh_movie_app/features/ui/searchMovieScreen/search_movie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';  // Connectivity checker
import 'dart:async';  // For StreamSubscription

import '../cubit/tabs_cubit.dart';

class HomeTabsScreen extends StatefulWidget {
  const HomeTabsScreen({super.key});

  @override
  State<HomeTabsScreen> createState() => _HomeTabsScreenState();
}

class _HomeTabsScreenState extends State<HomeTabsScreen> {
  final List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoriteMoviesScreen()
  ];

  late StreamSubscription<DataConnectionStatus> _subscription;
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkInitialConnection();
    _listenToConnectionChanges();
  }

  // Check the internet connection on startup
  Future<void> _checkInitialConnection() async {
    bool status = await DataConnectionChecker().hasConnection;
    setState(() {
      isConnected = status;
    });

    if (!isConnected) {
      _showNoConnectionSnackbar();
    }
  }

  // Monitor connection changes in real-time
  void _listenToConnectionChanges() {
    _subscription = DataConnectionChecker().onStatusChange.listen((status) {
      bool newStatus = status == DataConnectionStatus.connected;
      setState(() {
        isConnected = newStatus;
      });

      if (!newStatus) {
        _showNoConnectionSnackbar();
      }
    });
  }

  // Show a snackbar when the connection is lost
  void _showNoConnectionSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No internet connection. Please check your connection.'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel(); // Avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabCubit(),
      child: BlocBuilder<TabCubit, int>(
        builder: (context, activeTab) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("TMDB"),
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(
                  Theme.of(context).brightness == Brightness.light
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
              ),
            ),
            body: isConnected
                ? screens[activeTab]  // Show selected screen if connected
                : const Center(
              child: Text(
                'No Internet Connection',
                style: TextStyle(fontSize: 24),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: activeTab,
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
              onTap: (index) => context.read<TabCubit>().changeTab(index),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

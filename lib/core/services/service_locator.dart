
import 'package:fh_movie_app/core/preferences/pref_utils.dart';
import 'package:fh_movie_app/core/preferences/preferences_manager.dart';
import 'package:get_it/get_it.dart';

import '../../features/dataSource/data_source.dart';
import '../../features/dataSource/data_source_impl.dart';
import '../../features/repo/repo.dart';
import '../../features/repo/repo_impl.dart';
import '../network/network.dart';
import '../network/network_client.dart';

GetIt sl = GetIt.instance;
class ServicesLocator {
  Future<void> init() async {
    sl.registerLazySingleton<INetworkClient>(() => NetworkClient());
    sl.registerLazySingleton<INetwork>(() => Network(networkClient: sl<INetworkClient>(),),);
    sl.registerLazySingleton<DataSource>(() => DataSource(sl<INetwork>()),);
    sl.registerLazySingleton<Repository>(() => Repository(sl<DataSource>()));
    sl.registerLazySingleton<PreferenceManager>(()=>PreferenceManager(PrefUtils()));
  }
}
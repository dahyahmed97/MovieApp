import 'package:fh_movie_app/core/preferences/pref_utils.dart';
import 'keyCatalog.dart';

class PreferenceManager {
  final PrefUtils _prefUtils;
  PreferenceManager(this._prefUtils);

  Future<void> setAccessToken(String data) async {
    await _prefUtils.saveData<String>(KeyCatalog.bearerToken, data);
  }

  Future<String?> getAccessToken() async {
    return await _prefUtils.getData<String>(KeyCatalog.bearerToken);
  }

  Future<void> setFavoriteMovies(String data) async {
    await _prefUtils.saveData<String>(KeyCatalog.favoriteMovies, data);
  }

  Future<String?> getFavoriteMovies() async {
    return await _prefUtils.getData<String>(KeyCatalog.favoriteMovies);
  }


}

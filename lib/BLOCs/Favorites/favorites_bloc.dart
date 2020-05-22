import 'package:hacker_news/APIs/repository.dart';
import 'package:hacker_news/Models/user_prefs.dart';

// update the user prefs object

// refresh the database upon dispose

class FavoritesBloc {
  final repo = getRepository;

  List<int> _favorites = [];

  // get the user prefs object
  List<int> get getFavorites => _favorites;

// does item exist in  _favorites
  Function(int) get doesIdExistInFavorites => _isItemInFavorites;

// preload the userPrefs object

  get preloadUserPrefs => _preloadUserPrefsIntoUserPrefsObject();

// update the DB store of the user prefs, call on dispose
  get updateUserPrefStore => _updateTheUserPrefDB();

  // update an itemId on the favorites list add/remove if exist or not
  Function(int) get updateItemInFavorites => _updateFavoritesList;

// lookup for itemId in the favorites list of ints
  bool _isItemInFavorites(int itemId) {
    return _favorites.indexOf(itemId) != -1;
  }

// preload the userPrefs into the _userPrefs object
  Future<dynamic> _preloadUserPrefsIntoUserPrefsObject() async {
    UserPrefs userPrefs = await repo.getUserPrefs();
    _favorites = userPrefs.favorites.cast<int>();
  }

// update the user prefs object
  void _updateTheUserPrefDB() async {
    UserPrefs userPrefs = await repo.getUserPrefs();
    userPrefs.favorites = _favorites;
    await repo.updateFavorites(userPrefs: userPrefs);
  }

// add or remove an itemId from the _favorites list
  _updateFavoritesList(int itemId) {
    _isItemInFavorites(itemId)
        ? _favorites.remove(itemId)
        : _favorites.add(itemId);

    _updateTheUserPrefDB();
  }
}

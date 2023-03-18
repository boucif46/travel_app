import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {
  static Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<bool> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }


  static Future<void> updateToken(String key,String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, token);
  }

  static Future<String> getToken(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? 'nothing';
  }

  static Future<void> removeToken(String key) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}




 static  Future<void> addToFavorites(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<int> favorites = prefs.getStringList('favorites')?.map(int.parse).toList() ?? [];
  favorites.add(id);
  prefs.setStringList('favorites', favorites.map((e) => e.toString()).toList());
}
static Future<List<int>> getFavorites() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> favorites = prefs.getStringList('favorites') ?? [];
  return favorites.map(int.parse).toList();
}

static Future<void> removeFromFavorites(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<int> favorites = prefs.getStringList('favorites')?.map(int.parse).toList() ?? [];
  favorites.remove(id);
  prefs.setStringList('favorites', favorites.map((e) => e.toString()).toList());
}

   static Future<bool> isFavorite(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> favorites = prefs.getStringList('favorites') ?? [];
  List<int> favoriteIds = favorites.map(int.parse).toList();
  return favoriteIds.contains(id);
}

  static Future<void> setUserId(String key,int userId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setInt(key, userId);
  }
  static Future<int> getUserId(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return   prefs.getInt(key) ?? 0 ;
  }
}

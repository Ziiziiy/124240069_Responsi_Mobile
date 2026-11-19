import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/anime.dart';

class FavoriteController extends GetxController {
  final Box box = Hive.box('favorites');

  final favorites = <Anime>[].obs;

  @override
  void onInit() {
    loadFavorites();
    super.onInit();
  }

  void loadFavorites() {
    favorites.assignAll(
      box.values.map((e) => Anime.fromMap(Map<String, dynamic>.from(e))),
    );
  }

  bool isFavorite(int id) {
    return favorites.any((a) => a.id == id);
  }

  void toggleFavorite(Anime anime) {
    if (isFavorite(anime.id)) {
      removeFavorite(anime.id);
    } else {
      box.put(anime.id, anime.toMap());
      loadFavorites();
    }
  }

  void removeFavorite(int id) {
    box.delete(id);
    loadFavorites();
  }
}
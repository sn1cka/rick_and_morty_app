import 'package:mobx/mobx.dart';
import 'package:rick_and_morty_app/core/character/src/model/character.dart';
import 'package:rick_and_morty_app/feature/favorites/data/favorites_repository.dart';

part 'favorites_store.g.dart';

class FavoritesStore = _FavoritesStore with _$FavoritesStore;

abstract class _FavoritesStore with Store {
  _FavoritesStore({
    required FavoritesRepository favoritesRepository,
  }) : _favoritesRepository = favoritesRepository;

  final FavoritesRepository _favoritesRepository;

  @readonly
  ObservableList<Character> _favorites = ObservableList<Character>();

  @action
  void addToFavorites(Character character) {
    if (!_favorites.contains(character)) {
      _favorites.add(character);
    }
  }

  @action
  void removeFromFavorites(Character character) {
    _favorites.removeWhere((fav) => fav.id == character.id);
  }

  @action
  Future<void> updateStorage() async {
    await transaction(
      () async {
        await _favoritesRepository.rewriteFavoriteCharacters(_favorites);
      },
    );
  }

  @action
  Future<void> getFavorites() async {
    try {
      final favoriteCharacters = await _favoritesRepository.getFavoriteCharacters();
      _favorites.clear();
      _favorites.addAll(favoriteCharacters);
    } catch (e) {
      print('Failed to fetch favorite characters: $e');
    }
  }

  bool isFavorite(int id) => _favorites.any((element) => element.id == id);
}

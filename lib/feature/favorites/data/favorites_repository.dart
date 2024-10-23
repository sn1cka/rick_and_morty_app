import 'package:rick_and_morty_app/core/character/src/model/character.dart';
import 'package:rick_and_morty_app/feature/favorites/data/favorites_datasource.dart';

abstract interface class FavoritesRepository {
  Future<List<Character>> getFavoriteCharacters();

  Future<void> rewriteFavoriteCharacters(List<Character> characters);
}

final class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesDatasource _datasource;

  FavoritesRepositoryImpl({
    required FavoritesDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<List<Character>> getFavoriteCharacters() => _datasource.getFavoriteCharacters();

  @override
  Future<void> rewriteFavoriteCharacters(List<Character> characters) =>
      _datasource.rewriteFavoriteCharacters(characters);
}

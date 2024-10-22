import 'package:rick_and_morty_app/feature/character/src/model/character.dart';
import 'package:rick_and_morty_app/feature/character/src/model/pagination.dart';

abstract interface class CharacterRepository {
  Future<Pagination<List<Character>>> getPage(int page);

  Future<Pagination<List<Character>>> getFavoriteCharacters();

  Future<Character> getCharacter(int id);

  Future<void> addToFavorites(Character character);

  Future<void> updateStorage();
}

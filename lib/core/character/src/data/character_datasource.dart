import 'package:rick_and_morty_app/core/character/src/data/character_rest_client.dart';
import 'package:rick_and_morty_app/core/character/src/model/character.dart';
import 'package:rick_and_morty_app/core/character/src/model/pagination.dart';

abstract interface class CharacterDatasource {
  Future<Pagination<Character>> getPage(int page);

  Future<Character> getCharacter(int id);
}

final class NetworkCharacterDatasource implements CharacterDatasource {
  const NetworkCharacterDatasource({required CharacterRestClient client}) : _client = client;
  final CharacterRestClient _client;

  @override
  Future<Character> getCharacter(int id) => _client.getCharacterById(id);

  @override
  Future<Pagination<Character>> getPage(int page) async {
    try {
      final result = await _client.getCharacters(page);

      return Pagination(
        currentPage: page,
        isLastPage: result.info.next == null,
        items: result.results,
      );
    } catch (e) {
      rethrow;
    }
  }
}

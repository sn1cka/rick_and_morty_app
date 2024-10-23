import 'package:rick_and_morty_app/core/character/character.dart';

abstract interface class CharacterRepository {
  Future<Pagination<Character>> getPage(int page);

  Future<Character> getCharacter(int id);
}

final class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterDatasource _datasource;

  const CharacterRepositoryImpl({
    required CharacterDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Character> getCharacter(int id) => _datasource.getCharacter(id);

  @override
  Future<Pagination<Character>> getPage(int page) async {
    final savedData = await _datasource.getPage(page);
    return savedData;
  }
}

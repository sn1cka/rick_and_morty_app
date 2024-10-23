import 'package:drift/drift.dart';
import 'package:rick_and_morty_app/core/character/src/model/character.dart';
import 'package:rick_and_morty_app/feature/favorites/data/database/favorites_database.dart';

abstract interface class FavoritesDatasource {
  Future<List<Character>> getFavoriteCharacters();

  Future<void> rewriteFavoriteCharacters(List<Character> characters);
}

final class FavoritesLocalDataSource implements FavoritesDatasource {
  final AppDatabase _db;

  const FavoritesLocalDataSource({required AppDatabase db}) : _db = db;

  @override
  Future<List<Character>> getFavoriteCharacters() async {
    final records = await _db.select(_db.favoriteCharacters).get();

    return records
        .map(
          (record) => Character(
            id: record.id,
            name: record.name,
            status: Status.values.firstWhere(
              (element) => element.name == record.status,
            ),
            species: record.species,
            type: record.type,
            gender: Gender.values.firstWhere((element) => element.name == record.gender),
            origin: Origin(name: record.originName, url: record.originUrl),
            location: Location(name: record.locationName, url: record.locationUrl),
            image: record.image,
            episode: record.episode.split(','),
            url: record.url,
            created: record.created,
          ),
        )
        .toList();
  }

  @override
  Future<void> rewriteFavoriteCharacters(List<Character> characters) async {
    await _db.transaction(() async {
      await _db.delete(_db.favoriteCharacters).go();

      final newRecords = characters
          .map(
            (character) => FavoriteCharactersCompanion(
              episode: Value(character.episode.join(',')),
              id: Value(character.id),
              status: Value(character.status.name),
              name: Value(character.name),
              species: Value(character.species),
              type: Value(character.type),
              gender: Value(character.gender.name),
              originName: Value(character.origin.name),
              originUrl: Value(character.origin.url),
              locationName: Value(character.location.name),
              locationUrl: Value(character.location.url),
              image: Value(character.image),
              url: Value(character.url),
              created: Value(character.created),
            ),
          )
          .toList();

      await _db.batch((batch) {
        batch.insertAll(_db.favoriteCharacters, newRecords);
      });
    });
  }
}

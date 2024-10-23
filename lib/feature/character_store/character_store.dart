import 'package:mobx/mobx.dart';
import 'package:rick_and_morty_app/core/character/character.dart';

part 'character_store.g.dart';

class CharacterStore = _CharacterStore with _$CharacterStore;

abstract class _CharacterStore with Store {
  _CharacterStore({
    required CharacterRepository characterRepository,
  }) : _characterRepository = characterRepository;

  final CharacterRepository _characterRepository;

  @observable
  ObservableList<Character> characters = ObservableList<Character>();

  @observable
  Character? selectedCharacter;

  @observable
  bool isLoading = false;

  @observable
  bool isDetailsLoading = false;

  @observable
  int currentPage = 1;

  @observable
  bool isLastPageReached = false;

  @action
  Future<void> fetchCharacters(int page) async {
    if (isLastPageReached) {
      return;
    }
    isLoading = true;
    try {
      final response = await _characterRepository.getPage(page);
      currentPage = page;
      isLastPageReached = response.isLastPage;
      characters.addAll(response.items);
    } catch (e) {
      print('Failed to fetch characters: $e');
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> fetchCharacterDetails(int id) async {
    selectedCharacter = null;
    isDetailsLoading = true;
    try {
      selectedCharacter = await _characterRepository.getCharacter(id);
    } catch (e) {
      print('Failed to fetch character details: $e');
    } finally {
      isDetailsLoading = false;
    }
  }
}

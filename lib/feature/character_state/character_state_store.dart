import 'package:mobx/mobx.dart';
import 'package:rick_and_morty_app/core/character/character.dart';

part 'character_state_store.g.dart';

class CharacterStore = _CharacterStore with _$CharacterStore;

abstract class _CharacterStore with Store {
  _CharacterStore({
    required CharacterRepository characterRepository,
  }) : _characterRepository = characterRepository;

  final CharacterRepository _characterRepository;

  @readonly
  ObservableList<Character> _characters = ObservableList<Character>();

  @readonly
  Character? _selectedCharacter;

  @readonly
  bool _isLoading = false;

  @readonly
  bool _isDetailsLoading = false;

  @readonly
  int _currentPage = 1;

  @readonly
  bool _isLastPageReached = false;

  @action
  Future<void> fetchCharacters(int page) async {
    if (_isLastPageReached) {
      return;
    }
    _isLoading = true;
    try {
      final response = await _characterRepository.getPage(page);
      _currentPage = page;
      _isLastPageReached = response.isLastPage;
      _characters.addAll(response.items);
    } catch (e) {
      print('Failed to fetch characters: $e');
    } finally {
      _isLoading = false;
    }
  }

  @action
  Future<void> fetchCharacterDetails(int id) async {
    _selectedCharacter = null;
    _isDetailsLoading = true;
    try {
      _selectedCharacter = await _characterRepository.getCharacter(id);
    } catch (e) {
      print('Failed to fetch character details: $e');
    } finally {
      _isDetailsLoading = false;
    }
  }
}

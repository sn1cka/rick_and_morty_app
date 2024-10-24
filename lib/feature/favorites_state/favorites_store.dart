import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty_app/core/character/src/model/character.dart';
import 'package:rick_and_morty_app/feature/favorites/data/favorites_repository.dart';

part 'favorites_store.freezed.dart';

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.addToFavorites(Character character) = _AddToFavorites;

  const factory FavoritesEvent.removeFromFavorites(Character character) = _RemoveFromFavorites;

  const factory FavoritesEvent.getFavorites() = _GetFavorites;

  const factory FavoritesEvent.updateStorage() = _UpdateStorage;
}

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    required List<Character> favorites,
    required bool isLoading,
    Object? error,
  }) = _Idle;
  const FavoritesState._();


  bool get hasError => error != null;

  bool isFavorite(int id) => favorites.any((e) => e.id == id);
}

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository _favoritesRepository;

  FavoritesBloc({required FavoritesRepository favoritesRepository})
      : _favoritesRepository = favoritesRepository,
        super(const FavoritesState(isLoading: false, favorites: [])) {
    on<_AddToFavorites>(_onAddToFavorites);
    on<_RemoveFromFavorites>(_onRemoveFromFavorites);
    on<_GetFavorites>(_onGetFavorites);
    on<_UpdateStorage>(_onUpdateStorage);
  }

  Future<void> _onAddToFavorites(_AddToFavorites event, Emitter<FavoritesState> emit) async {
    if (!state.isLoading) {
      final currentFavorites = state.favorites.toList();
      if (!currentFavorites.contains(event.character)) {
        currentFavorites.add(event.character);
        emit(FavoritesState(favorites: currentFavorites, isLoading: false));
      }
    }
  }

  Future<void> _onRemoveFromFavorites(_RemoveFromFavorites event, Emitter<FavoritesState> emit) async {
    if (!state.isLoading) {
      final currentFavorites = state.favorites.toList();
      currentFavorites.removeWhere((fav) => fav.id == event.character.id);
      emit(FavoritesState(favorites: currentFavorites, isLoading: false));
    }
  }

  Future<void> _onGetFavorites(_GetFavorites event, Emitter<FavoritesState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final favoriteCharacters = await _favoritesRepository.getFavoriteCharacters();
      emit(FavoritesState(favorites: favoriteCharacters, isLoading: false));
    } catch (e) {
      emit(FavoritesState(error: e, isLoading: false, favorites: state.favorites));
    }
  }

  Future<void> _onUpdateStorage(_UpdateStorage event, Emitter<FavoritesState> emit) async {
    if (!state.isLoading && !state.hasError) {
      final currentFavorites = state.favorites;
      await _favoritesRepository.rewriteFavoriteCharacters(currentFavorites);
    }
  }
}

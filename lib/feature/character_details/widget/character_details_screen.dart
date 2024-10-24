import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/core/character/src/model/character.dart';
import 'package:rick_and_morty_app/core/character/src/widget/character_card.dart';
import 'package:rick_and_morty_app/feature/character_state/character_state_store.dart';
import 'package:rick_and_morty_app/feature/favorites_state/favorites_store.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key});

  void _onFavoriteTap(
    BuildContext context, {
    required Character character,
    required bool value,
  }) {
    final store = Provider.of<FavoritesStore>(context, listen: false);
    if (value) {
      store.addToFavorites(character);
    } else {
      store.removeFromFavorites(character);
    }
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (context) {
          final characterStore = Provider.of<CharacterStore>(context, listen: false);
          final favoritesStore = Provider.of<FavoritesStore>(context, listen: false);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(characterStore.selectedCharacter?.name ?? ''),
            ),
            body: Column(
              children: [
                if (characterStore.isDetailsLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (characterStore.selectedCharacter != null)
                  CharacterCard(
                    character: characterStore.selectedCharacter!,
                    isFavorite: favoritesStore.isFavorite(characterStore.selectedCharacter!.id),
                    onFavoriteTap: (bool value) {
                      _onFavoriteTap(context, character: characterStore.selectedCharacter!, value: value);
                    },
                  ),
              ],
            ),
          );
        },
      );
}

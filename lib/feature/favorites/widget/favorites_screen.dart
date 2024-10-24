import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/core/character/src/model/character.dart';
import 'package:rick_and_morty_app/core/character/src/widget/character_card.dart';
import 'package:rick_and_morty_app/feature/favorites_state/favorites_store.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
  Widget build(BuildContext context) => Scaffold(
    body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const SliverAppBar(
              title: Text('Favorites'),
              pinned: true,
            ),
          ],
          body: Observer(
            builder: (context) {
              final store = Provider.of<FavoritesStore>(context, listen: false);

              return CustomScrollView(
                slivers: [
                  SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 500,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final character = store.favorites[index];

                        return Observer(
                          builder: (context) {
                            final favoriteStore = Provider.of<FavoritesStore>(context, listen: false);
                            final isFavorite = favoriteStore.isFavorite(character.id);
                            return CharacterCard(
                              character: character,
                              isFavorite: isFavorite,
                              onFavoriteTap: (bool value) {
                                _onFavoriteTap(context, value: value, character: character);
                              },
                            );
                          },
                        );
                      },
                      childCount: store.favorites.length,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
  );
}

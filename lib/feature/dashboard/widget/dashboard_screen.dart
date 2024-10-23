import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/core/character/src/model/character.dart';
import 'package:rick_and_morty_app/core/character/src/widget/character_card.dart';
import 'package:rick_and_morty_app/feature/character_store/character_store.dart';
import 'package:rick_and_morty_app/feature/details_screen/details_screen.dart';
import 'package:rick_and_morty_app/feature/favorites/widget/favorites_screen.dart';
import 'package:rick_and_morty_app/feature/favorites_store/favorites_store.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _onCharacterSelected(BuildContext context, Character character) {
    Provider.of<CharacterStore>(context, listen: false).fetchCharacterDetails(character.id);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const DetailsScreen(),
      ),
    );
  }

  void _onFavoritesCollectionButtonTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) => const FavoritesScreen()));
  }

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
            SliverAppBar(
              title: const Text('All characters'),
              actions: [
                IconButton(
                  onPressed: () => _onFavoritesCollectionButtonTap(context),
                  icon: const Icon(Icons.bookmark),
                ),
              ],
              pinned: true,
            ),
          ],
          body: Observer(
            builder: (context) {
              final characterStore = Provider.of<CharacterStore>(context, listen: false);

              return NotificationListener(
                onNotification: (ScrollNotification notification) {
                  if (!characterStore.isLastPageReached &&
                      notification.metrics.pixels >= notification.metrics.maxScrollExtent - 200) {
                    if (!characterStore.isLoading) {
                      characterStore.fetchCharacters(characterStore.currentPage + 1);
                    }
                  }
                  return true;
                },
                child: Scrollbar(
                  trackVisibility: true,
                  interactive: true,
                  child: CustomScrollView(
                    slivers: [
                      SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 500,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final character = characterStore.characters[index];

                            return Observer(
                              builder: (context) {
                                final favoriteStore = Provider.of<FavoritesStore>(context, listen: false);
                                final isFavorite = favoriteStore.isFavorite(character.id);
                                return CharacterCard(
                                  character: character,
                                  onTap: () => _onCharacterSelected(context, character),
                                  isFavorite: isFavorite,
                                  onFavoriteTap: (bool value) {
                                    _onFavoriteTap(context, value: value, character: character);
                                  },
                                );
                              },
                            );
                          },

                          childCount: characterStore.characters.length,
                        ),
                      ),
                      SliverOffstage(
                        offstage: !characterStore.isLoading,
                        sliver: const SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      SliverOffstage(
                        offstage: !characterStore.isLastPageReached,
                        sliver: const SliverSafeArea(
                          sliver: SliverToBoxAdapter(
                            child: Center(child: Text('Thats all Folks')),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
}
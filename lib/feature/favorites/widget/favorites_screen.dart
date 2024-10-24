import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final bloc = BlocProvider.of<FavoritesBloc>(context);
    if (value) {
      bloc.add(FavoritesEvent.addToFavorites(character));
    } else {
      bloc.add(FavoritesEvent.removeFromFavorites(character));
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
          body: BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) => CustomScrollView(
              slivers: [
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 500,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final character = state.favorites[index];

                      return CharacterCard(
                        character: character,
                        isFavorite: state.isFavorite(character.id),
                        onFavoriteTap: (bool value) {
                          _onFavoriteTap(context, value: value, character: character);
                        },
                      );
                    },
                    childCount: state.favorites.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

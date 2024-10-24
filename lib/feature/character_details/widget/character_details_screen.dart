import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/core/character/src/model/character.dart';
import 'package:rick_and_morty_app/core/ui_kit/ui_kit.dart';
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
          final character = characterStore.selectedCharacter;
          return Scaffold(
            body: Column(
              children: [
                if (characterStore.isDetailsLoading)
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (characterStore.selectedCharacter != null)
                  Expanded(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CachedNetworkImage(
                                    imageUrl: character!.image,
                                    height: 380,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    _ListTile(icon: AppIcons.info, title: 'Name', text: character.name),
                                    _Status(status: character.status),
                                    _ListTile(icon: AppIcons.info, title: 'Species', text: character.species),
                                    _Gender(gender: character.gender),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          left: 20,
                          top: kToolbarHeight,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const CircleAvatar(
                              radius: 22,
                              backgroundColor: Color(0xffF1F1F1),
                              child: Icon(
                                AppIcons.back_arrow,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      );
}

class _ListTile extends StatelessWidget {
  const _ListTile({required this.icon, required this.title, required this.text});

  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 12),
            child: CircleAvatar(
              backgroundColor: AppColors.irisBlue,
              radius: 20,
              child: Icon(
                icon,
                size: 24,
                color: AppColors.whiteSmoke,
                applyTextScaling: true,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.body2.copyWith(color: AppColors.grey),
                ),
                Text(
                  text[0].toUpperCase() + text.substring(1),
                  style: AppTextStyles.subtitle,
                ),
              ],
            ),
          ),
        ],
      );
}

class _Status extends StatelessWidget {
  const _Status({required this.status});

  final Status status;

  @override
  Widget build(BuildContext context) {
    final icon = switch (status) {
      Status.alive => AppIcons.alive,
      Status.dead => AppIcons.dead,
      Status.unknown => AppIcons.status_unknown,
    };

    return _ListTile(icon: icon, title: 'Status', text: status.name);
  }
}

class _Gender extends StatelessWidget {
  const _Gender({required this.gender});

  final Gender gender;

  @override
  Widget build(BuildContext context) {
    final icon = switch (gender) {
      Gender.male => AppIcons.male,
      Gender.female => AppIcons.female,
      _ => AppIcons.unknown_1,
    };

    return _ListTile(icon: icon, title: 'Gender', text: gender.name);
  }
}

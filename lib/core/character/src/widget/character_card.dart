import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/character/src/model/character.dart';
import 'package:rick_and_morty_app/core/ui_kit/ui_kit.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    required this.character,
    required this.isFavorite,
    required this.onFavoriteTap,
    this.onTap,
    super.key,
  });

  final Character character;
  final VoidCallback? onTap;
  final void Function(bool value) onFavoriteTap;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 160,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Material(
            color: AppColors.white,
            child: InkWell(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 160,
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: character.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              padding: const EdgeInsets.all(5.0),
                              onPressed: () => onFavoriteTap(!isFavorite),
                              icon: Icon(
                                isFavorite ? AppIcons.liked : AppIcons.unliked,
                                color: AppColors.irisBlue,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        character.name,
                        style: AppTextStyles.body1,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      );
}

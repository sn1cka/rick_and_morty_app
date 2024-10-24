import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/character/src/model/character.dart';

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
          child: InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: character.image,
                      fit: BoxFit.contain,
                      height: 200,
                      width: double.infinity,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => onFavoriteTap(!isFavorite),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  character.name,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 3,
                  textAlign: TextAlign.left,
                ),
                _Status(status: character.status),
                _Species(species: character.species),
                _Gender(gender: character.gender),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.redAccent),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        character.origin.name,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}

class _Status extends StatelessWidget {
  const _Status({required this.status});

  final Status status;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (status) {
      case Status.alive:
        icon = Icons.health_and_safety;
        color = Colors.green;
      case Status.dead:
        icon = Icons.circle;
        color = Colors.red;
      case Status.unknown:
      default:
        icon = Icons.help_outline;
        color = Colors.grey;
    }

    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 5),
        Text(
          status.name,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class _Species extends StatelessWidget {
  const _Species({required this.species});

  final String species;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          const Icon(Icons.account_circle_rounded, color: Colors.orange, size: 20),
          const SizedBox(width: 5),
          Text(
            species,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      );
}

class _Gender extends StatelessWidget {
  const _Gender({required this.gender});

  final Gender gender;

  @override
  Widget build(BuildContext context) {
    late final Color color;

    color = switch (gender) {
      Gender.female => Colors.pinkAccent,
      Gender.male => Colors.blue,
      Gender.genderless => Colors.grey,
      Gender.unknown => Colors.black,
    };

    return Row(
      children: [
        Icon(Icons.person, size: 16, color: color),
        const SizedBox(width: 5),
        Text(
          gender.name,
          style: TextStyle(fontSize: 16, color: color),
        ),
      ],
    );
  }
}

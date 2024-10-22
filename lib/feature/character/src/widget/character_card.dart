import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/src/model/character.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key, required this.character, this.onTap});

  final Character character;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Card(
        elevation: 5,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: character.image,
                  fit: BoxFit.contain,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                character.name,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),
              _StatusRow(
                status: character.status,
              ),
              Text(
                character.species,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.blueAccent),
                  const SizedBox(width: 5),
                  Text(
                    character.gender,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.redAccent),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      character.origin.name,
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
      );
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({required this.status});

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
        )
      ],
    );
  }
}

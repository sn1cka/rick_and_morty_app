import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/src/model/character.dart';
import 'package:rick_and_morty_app/feature/character/src/widget/character_card.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(character.name),
        ),
        body: Center(
          child: CharacterCard(
            character: character,
          ),
        ),
      );
}

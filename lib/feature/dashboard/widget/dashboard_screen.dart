import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/src/model/character.dart';
import 'package:rick_and_morty_app/feature/character/src/widget/character_card.dart';
import 'package:rick_and_morty_app/feature/character/src/widget/test_card.dart';
import 'package:rick_and_morty_app/feature/details_screen/details_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _onCharacterTap(BuildContext context, Character character) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => DetailsScreen(character: character),
    ));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const SliverAppBar(
              title: Text('All characters'),
            )
          ],
          body: CustomScrollView(
            slivers: [
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 500,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => CharacterCard(
                    character: testCharacters[index],
                    onTap: () => _onCharacterTap(context, testCharacters[index]),
                  ),
                  childCount: testCharacters.length,
                ),
              )
            ],
          ),
        ),
      );
}

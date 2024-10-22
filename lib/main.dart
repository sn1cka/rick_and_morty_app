import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/src/model/character.dart';
import 'package:rick_and_morty_app/feature/character/src/widget/character_card.dart';
import 'package:rick_and_morty_app/feature/character/src/widget/test_card.dart';
import 'package:rick_and_morty_app/feature/dashboard/widget/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: DashboardScreen(),
      );
}

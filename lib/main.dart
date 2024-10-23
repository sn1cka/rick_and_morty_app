import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/core/character/character.dart';
import 'package:rick_and_morty_app/feature/character_store/character_store.dart';
import 'package:rick_and_morty_app/feature/dashboard/widget/dashboard_screen.dart';
import 'package:rick_and_morty_app/feature/favorites/data/database/favorites_database.dart';
import 'package:rick_and_morty_app/feature/favorites/data/favorites_datasource.dart';
import 'package:rick_and_morty_app/feature/favorites/data/favorites_repository.dart';
import 'package:rick_and_morty_app/feature/favorites_store/favorites_store.dart';

void main() async {
  runApp(
    MyApp(
      characterStore: _createCharacterStore(),
      favoritesStore: _createFavoritesStore(),
    ),
  );
}

CharacterStore _createCharacterStore() {
  final charRepo = CharacterRepositoryImpl(
    datasource: NetworkCharacterDatasource(
      client: CharacterRestClient(
        Dio(),
      ),
    ),
  );
  return CharacterStore(characterRepository: charRepo)..fetchCharacters(1);
}

FavoritesStore _createFavoritesStore() {
  final favoritesRepo = FavoritesRepositoryImpl(
    datasource: FavoritesLocalDataSource(
      db: AppDatabase.defaults(),
    ),
  );

  return FavoritesStore(favoritesRepository: favoritesRepo)..getFavorites();
}

class MyApp extends StatefulWidget {
  const MyApp({
    required this.characterStore,
    required this.favoritesStore,
    super.key,
  });

  final CharacterStore characterStore;
  final FavoritesStore favoritesStore;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider.value(value: widget.characterStore),
          Provider.value(value: widget.favoritesStore),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const DashboardScreen(),
        ),
      );

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      if (widget.favoritesStore.favorites.isNotEmpty) {
        widget.favoritesStore.updateStorage();
      }
      print('pause');
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

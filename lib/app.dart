import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/core/character/character.dart';
import 'package:rick_and_morty_app/core/ui_kit/src/colors.dart';
import 'package:rick_and_morty_app/feature/character_list/widget/character_list_screen.dart';
import 'package:rick_and_morty_app/feature/character_state/character_state_store.dart';
import 'package:rick_and_morty_app/feature/favorites/data/database/favorites_database.dart';
import 'package:rick_and_morty_app/feature/favorites/data/favorites_datasource.dart';
import 'package:rick_and_morty_app/feature/favorites/data/favorites_repository.dart';
import 'package:rick_and_morty_app/feature/favorites_state/favorites_store.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late final CharacterStore characterStore;
  late final FavoritesStore favoritesStore;

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

  @override
  void initState() {
    super.initState();
    favoritesStore = _createFavoritesStore();
    characterStore = _createCharacterStore();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider.value(value: characterStore),
          Provider.value(value: favoritesStore),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          color: AppColors.white,
          theme: ThemeData(
            progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: AppColors.irisBlue,
            ),
            appBarTheme: const AppBarTheme(iconTheme: IconThemeData(fill: 1, color: AppColors.nero)),
            scaffoldBackgroundColor: AppColors.whiteSmoke,
            textTheme: GoogleFonts.latoTextTheme(),
            useMaterial3: true,
          ),
          home: const DashboardScreen(),
        ),
      );

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      favoritesStore.updateStorage();
    }
    super.didChangeAppLifecycleState(state);
  }
}

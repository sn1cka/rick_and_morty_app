# Rick and Morty Application

# This is BLOC version fo application 

Navigate to [lib/feature/favorites_state/favorites_store.dart] to view bloc





# Screen recording path: [app_output](app_output)
# Release apk build : [app-release.apk](app_output%2Fapp-release.apk)


# Steps to run application from source code

1. Install FVM
2. Activate 3.24.3 flutter version by running 'fvm use 3.24.3'
3. run 'fvm flutter pub get'
4. Generate files using 'fvm flutter run build_runner --delete conflicting outputs'
5. Run application through 'fvm flutter run'

# Core functionalities

[lib/core/character] -- Main component for all application (repository, data source, rest client,
card widget)

[lib/feature/character_state] -- Main application state, provided to the root of application 
its used to manage actions (getting list of character and getting detailed info about character)

[lib/feature/favorites] -- Favorites component based on core character (repository,data source,
database, favorites screen)

[lib/feature/favorites_state] -- Favorites application state manager used for CRUD actions 

# Core packages

1. mobx([main branch]) and bloc ([bloc branch]) for core state management
2. Provider for dependency injection in widget tree
3. Freezed for code generation and every data model
4. retrofit as rest service code generation
5. dio for REST actions
6. drift as database


# Compatability
Application was tested on Iphone 13 Pro Max, iOS Simulator (17.2, Iphone 15 Pro Max) and Anidroid
API32 emulator 

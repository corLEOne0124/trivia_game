import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_game/features/home/repository.dart';
import 'package:trivia_game/shared/foundation/services/rest_client_service.dart';
import 'package:trivia_game/shared/foundation/services/secure_storage_service.dart';

import '../../services/preferences_service.dart';

final locator = GetIt.instance;
final _navigatorKey = GlobalKey<NavigatorState>();
final ctx = _navigatorKey.currentContext;
Future<void> setupLocator() async {
  locator.registerLazySingleton(() => RestClientService());
  locator.registerSingleton<GlobalKey<NavigatorState>>(_navigatorKey);
  //! SharedPreferences
  final preferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => preferences);
  locator.registerLazySingleton(() => PreferencesService(prefs: locator()));
  //! Secure Storage
  const secureStorage = FlutterSecureStorage();
  locator.registerLazySingleton(() => secureStorage);
  locator.registerLazySingleton(
      () => SecureStorageService(secureStorage: locator()));

  locator.registerLazySingleton(() => TriviaRepository());
}

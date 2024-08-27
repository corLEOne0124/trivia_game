import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trivia_game/app.dart';

import 'shared/foundation/helpers/functions/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );
  runApp(const App());
}

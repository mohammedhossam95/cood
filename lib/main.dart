import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/services/local_database/database_helper.dart';
import 'app.dart';
import 'core/services/bloc_observer/bloc_observer.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff297AFF),
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Color(0xff297AFF),
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  Bloc.observer = AppBlocObserver();
  dioConsumer.updateDeviceTypeHeader();
  await DBHelper.initDB();
  runApp(const App());
}

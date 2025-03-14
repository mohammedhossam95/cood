import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
 //getData();
  Bloc.observer = AppBlocObserver();
  dioConsumer.updateDeviceTypeHeader();
  await DBHelper.initDB();
  runApp(const App());
}
  


// Future<void> getData() async {
//   final headers = {
//     'Authorization': 'Bearer 3|tiLlHT6fseS3KLa5yiDLur94T6HCibEw2opQ4NYS27f0ce1d',
//     'Content-Type': 'application/json',
//   };

//   try {
//     final response = await http.get(
//       Uri.parse('https://cood.testworks.top/api/v1/gallery'),
//       headers: headers,
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       print('ali---------gallery---$data');
//     } else {
//       print('Error: ${response.statusCode}');
//       print('Response body: ${response.body}');
//     }
//   } catch (e) {
//     print('Exception occurred: $e');
//   }
// }

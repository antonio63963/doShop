import 'package:doshop_app/db/abstract_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';

import 'package:doshop_app/db/localDB/local_db.dart';
import 'package:doshop_app/doshop_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Future.delayed(const Duration(seconds: 4));
  FlutterNativeSplash.remove();

  LocalDB.instance.database;
  GetIt.I.registerLazySingleton<AbstractDB>(() => LocalDB.instance);
  runApp(const DoshopApp());
}

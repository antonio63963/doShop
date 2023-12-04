import 'package:doshop_app/db/abstractDB.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:doshop_app/db/localDB/local_db.dart';
import 'package:doshop_app/doshop_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  LocalDB.instance.database;
  GetIt.I.registerLazySingleton<AbstractDB>(() => LocalDB.instance);
  runApp(const DoshopApp());
}

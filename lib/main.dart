import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:henri_sedjame/models/data.dart';
import 'package:henri_sedjame/models/value.dart';
import 'package:henri_sedjame/presentation/notifiers/data-notifier.dart';
import 'package:henri_sedjame/presentation/pages/home-page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  GetIt getIt = GetIt.I;

  var data = await rootBundle.loadString("data/data.json")
  .then((value) => json.decode(value))
  .then((value) => Value<dynamic>.fromJson(value))
  .then((value)=>
    Value<Data>()
        ..fr = Data.fromJson(value.fr)
        ..en = Data.fromJson(value.en)
  );

  getIt.registerSingleton(DataNotifier(data.fr));

  runApp(MyApp(data: data));
}

class MyApp extends StatelessWidget {

  final Value<Data> data;
  const MyApp({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WHOAMI",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(data: data),
    );
  }

}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:okoted/data/local/box/note_model.dart';
import 'package:okoted/data/local/ok_noted_db.dart';
import 'package:okoted/presentation/pages/homepage/homepage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(NoteModelAdapter());

  await Hive.openBox<NoteModel>(OkNotedDB.todoBox);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OkNoted',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

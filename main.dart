import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


import 'package:todo_notes/sceens/home/home_screen.dart';
import 'package:todo_notes/services/db_handler.dart';

import 'package:todo_notes/utils/media_query_utils.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();



  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
DbHandler dbHandler = DbHandler();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MediaQueryService().initialize(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

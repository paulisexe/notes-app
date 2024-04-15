

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/firebase_options.dart';
import 'package:project1/models/note_database.dart';
import 'package:project1/pages/home_page.dart';
import 'package:project1/pages/notes_page.dart';
import 'package:project1/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized() ;
  await NoteDatabase.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
  MultiProvider(
    providers: [
    // Note provider
    ChangeNotifierProvider(create: (context) => NoteDatabase()),
    // Theme Provider
    ChangeNotifierProvider(create: (context) => ThemeProvider())
  ],
    child : const MyApp(),
  ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      home: const HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}


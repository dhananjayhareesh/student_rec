import 'package:flutter/material.dart';
import 'package:student_records/database/db_functions.dart';
import 'package:student_records/screen/homescreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreeen(),
    );
  }
}

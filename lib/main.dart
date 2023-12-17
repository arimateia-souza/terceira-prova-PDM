import 'package:flutter/material.dart';
import 'package:terceira_prova/ui/tela_Home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const TelaHome(),
    );
  }
}

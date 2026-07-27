import 'package:flutter/material.dart';
import 'theme/nocturne_theme.dart';
import 'shell/app_shell.dart';

void main() {
  runApp(const CamisApp());
}

class CamisApp extends StatelessWidget {
  const CamisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camila Ferreira',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Nocturne.dark),
      home: const AppShell(),
    );
  }
}

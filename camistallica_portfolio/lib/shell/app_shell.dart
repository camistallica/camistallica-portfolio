import 'package:flutter/material.dart';
import '../theme/nocturne_theme.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final n = context.n;

    return Scaffold(
      backgroundColor: n.bg,
      body: const Center(
        child: Text('shell'),
      ),
    );
  }
}
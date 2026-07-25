import 'package:flutter/material.dart';
import '../theme/nocturne_theme.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final n = context.n;

    return Scaffold(
      backgroundColor: n.bg,
      body: Center(
        child: Column(
          children: [Container(
            height: 48, color: Colors.red
          ),
          Expanded(child: Container(
            color:Colors.green
          )),
          Container(
            height: 56, color: Colors.blue
          )],
        ),
      ),
    );
  }
}
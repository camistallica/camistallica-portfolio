import 'package:flutter/material.dart';
import '../theme/nocturne_theme.dart';

enum AppTab{
  home('01', 'Casa'),
  work('02', 'Obras'),
  path('03', 'Linha'),
  stack('04', 'Stack'),
  sound('05', 'Trilha'),
  about('06', 'Sobre');

  const AppTab(this.number, this.label);

final String number;
final String label;
}

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
            height: 56, color: Colors.blue,
          child: Row(children:AppTab.values.map((tab) => Expanded(child: Center(
            child: Text(tab.label),
          ),
          )).toList(),
          ),
        )],
        ),
      ),
    );
  }
}
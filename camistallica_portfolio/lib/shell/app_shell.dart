import 'package:flutter/material.dart';
import '../theme/nocturne_theme.dart';

enum AppTab {
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

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  AppTab _tab = AppTab.home;

  @override
  Widget build(BuildContext context) {
    final n = context.n;

    return Scaffold(
      backgroundColor: n.bg,
      body: Column(
        children: [
          Container(height: 48, color: Colors.red),

          Expanded(
            child: Container(
              color: Colors.green,
              child: Center(child: Text(_tab.label)),
            ),
          ),

          Container(
            height: 56,
            color: Colors.blue,
            child: Row(
              children: AppTab.values.map((tab) {
                final ativo = tab == _tab;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _tab = tab),
                    child: Center(
                      child: Text(
                        tab.label,
                        style: TextStyle(
                          color: ativo ? Colors.white : Colors.white54,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
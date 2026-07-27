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

  Widget _header() {
    final n = context.n;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      decoration: BoxDecoration(
        color: n.bg,
        border: Border(bottom: BorderSide(color: n.line)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  border: Border.all(color: n.acc),
                  borderRadius: R.ctrl,
                ),
                child: Center(
                  child: Text(
                    'CF',
                    style: display(11, tracking: -.02, color: n.acc),
                  ),
                ),
              ),

              const SizedBox(width: 9),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'CAMILA FERREIRA',
                    style: display(
                      12,
                      tracking: .02,
                      height: 1.2,
                      color: n.ink,
                    ),
                  ),
                  Text(
                    'DEV MOBILE · KOTLIN',
                    style: label(9.5, tracking: .14, color: n.dim),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _navItem(AppTab tab) {
    final n = context.n;
    final ativo = tab == _tab;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() => _tab = tab),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tab.number,
                  style: label(8, tracking: .08, color: ativo ? n.acc : n.dim),
                ),
                const SizedBox(height: 3),
                Text(
                  tab.label.toUpperCase(),
                  style: label(9, tracking: .08, color: ativo ? n.ink : n.dim),
                ),
              ],
            ),
            if (ativo)
              FractionallySizedBox(
                widthFactor: .52,
                child: Container(height: 2, color: n.acc),
              ),
          ],
        ),
      ),
    );
  }

  Widget _navBar() {
    final n = context.n;

    return Container(
      decoration: BoxDecoration(
        color: n.bg,
        border: Border(top: BorderSide(color: n.line)),
      ),
      padding: const EdgeInsets.fromLTRB(2, 9, 2, 10),
      child: Row(children: AppTab.values.map(_navItem).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final n = context.n;

    return Scaffold(
      backgroundColor: n.bg,
      body: Column(
        children: [
          _header(),
          Expanded(
            child: Container(
              color: Colors.green,
              child: Center(child: Text(_tab.label)),
            ),
          ),
          _navBar(),
        ],
      ),
    );
  }
}

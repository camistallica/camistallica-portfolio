// lib/widgets/effects.dart
//
// Os quatro efeitos do handoff que não têm equivalente direto no Flutter:
// grão animado, vinheta, texto vazado (text-stroke), wipe de transição
// e o equalizador de 4 barras.

import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// ---------------------------------------------------------------- GRÃO
// CSS: feTurbulence + mix-blend-mode:overlay + opacity .3 + drift 6s steps(6).
// Flutter não tem feTurbulence. Gere UMA vez um PNG de ruído tileável
// (200x200, ruído gaussiano cinza) e coloque em assets/noise.png.
// O ImageShader repete o tile e a matriz de translação faz o drift.

class GrainOverlay extends StatefulWidget {
  const GrainOverlay({super.key, required this.child, this.opacity = .3});
  final Widget child;
  final double opacity;

  @override
  State<GrainOverlay> createState() => _GrainOverlayState();
}

class _GrainOverlayState extends State<GrainOverlay>
    with SingleTickerProviderStateMixin {
  ui.Image? _noise;
  late final Ticker _ticker;
  double _t = 0;

  @override
  void initState() {
    super.initState();
    _load();
    _ticker = createTicker((d) {
      // steps(6) em 6s: 1 passo por segundo, 20px por passo.
      final step = (d.inMilliseconds / 1000).floor() % 6;
      if (step * 20.0 != _t) setState(() => _t = step * 20.0);
    })
      ..start();
  }

  Future<void> _load() async {
    final data = await DefaultAssetBundle.of(context).load('assets/noise.png');
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    if (mounted) setState(() => _noise = frame.image);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_noise == null) return widget.child;
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: _GrainPainter(_noise!, _t, widget.opacity),
            ),
          ),
        ),
      ],
    );
  }
}

class _GrainPainter extends CustomPainter {
  _GrainPainter(this.image, this.offset, this.opacity);
  final ui.Image image;
  final double offset;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..blendMode = BlendMode.overlay
      ..color = Colors.white.withValues(alpha: opacity)
      ..shader = ImageShader(
        image,
        TileMode.repeated,
        TileMode.repeated,
        Matrix4.translationValues(offset, offset, 0).storage,
      );
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(_GrainPainter old) => old.offset != offset;
}

// ------------------------------------------------------------- VINHETA
// radial-gradient(120% 80% at 50% 0%, transparent 40%, rgba(0,0,0,.55) 100%)

class Vignette extends StatelessWidget {
  const Vignette({super.key});

  @override
  Widget build(BuildContext context) => IgnorePointer(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, -1),
              radius: 1.2,
              stops: [0.4, 1.0],
              colors: [Colors.transparent, Color(0x8C000000)],
            ),
          ),
          child: SizedBox.expand(),
        ),
      );
}

// -------------------------------------------------- TEXTO VAZADO (stroke)
// CSS: color:transparent; -webkit-text-stroke:1px var(--acc)

class StrokeText extends StatelessWidget {
  const StrokeText(
    this.text, {
    super.key,
    required this.style,
    required this.color,
    this.width = 1,
  });

  final String text;
  final TextStyle style;
  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: style.copyWith(
          color: null,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = width
            ..color = color,
        ),
      );
}

// ----------------------------------------------------------------- WIPE
// Retângulo em --acc que faz scaleY 0->1 (origem embaixo) e 1->0 (origem
// em cima), 540ms. Dispare a cada troca de tela.
// hard-light não existe como blend de widget; opacity .9 fica próximo.

class WipeOverlay extends StatelessWidget {
  const WipeOverlay({super.key, required this.animation, required this.color});
  final Animation<double> animation; // 0..1, controller de 540ms
  final Color color;

  @override
  Widget build(BuildContext context) => IgnorePointer(
        child: AnimatedBuilder(
          animation: animation,
          builder: (_, __) {
            final t = animation.value;
            final first = t <= .5;
            final scale = first ? t * 2 : (1 - t) * 2;
            if (scale <= 0) return const SizedBox.shrink();
            return Align(
              alignment: first ? Alignment.bottomCenter : Alignment.topCenter,
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: scale.clamp(0, 1),
                child: ColoredBox(
                  color: color.withValues(alpha: first ? .9 : .5),
                ),
              ),
            );
          },
        ),
      );
}

// -------------------------------------------------------- EQUALIZADOR
// 4 barras de 3px, noc-bar .9s, delays 0/.15/.3/.45s, scaleY .25 -> 1.

class Equalizer extends StatefulWidget {
  const Equalizer({super.key, required this.color, this.height = 14});
  final Color color;
  final double height;

  @override
  State<Equalizer> createState() => _EqualizerState();
}

class _EqualizerState extends State<Equalizer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _c,
        builder: (_, __) => Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(4, (i) {
            final phase = (_c.value + i * .1667) % 1.0;
            final s = .25 + .75 * (1 - (math.cos(phase * 2 * math.pi) + 1) / 2);
            return Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Container(
                width: 3,
                height: widget.height * s,
                color: widget.color,
              ),
            );
          }),
        ),
      );
}

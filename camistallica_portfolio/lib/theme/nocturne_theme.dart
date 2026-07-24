// lib/theme/nocturne_theme.dart
//
// Tokens do handoff -> Flutter. Ponto único de verdade de cor e tipografia.
// letterSpacing no CSS está em `em`; no Flutter é em px lógicos.
// Por isso os helpers multiplicam o tracking pelo fontSize.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class Nocturne extends ThemeExtension<Nocturne> {
  const Nocturne({
    required this.bg,
    required this.surf,
    required this.raise,
    required this.ink,
    required this.dim,
    required this.line,
    required this.acc,
    required this.accDim,
    required this.accTint,
  });

  final Color bg, surf, raise, ink, dim, line, acc, accDim, accTint;

  static const dark = Nocturne(
    bg: Color(0xFF161826),
    surf: Color(0xFF232532),
    raise: Color(0xFF292B31),
    ink: Color(0xFFE9E9ED),
    dim: Color(0xFF9397AB),
    line: Color(0x29E9E9ED), // rgba(233,233,237,.16)
    acc: Color(0xFF9184D9),
    accDim: Color(0xFF5D5294),
    accTint: Color(0x249184D9), // rgba(145,132,217,.14)
  );

  static const light = Nocturne(
    bg: Color(0xFFF3F5FE),
    surf: Color(0xFFE4E7F5),
    raise: Color(0xFFCFD3E5),
    ink: Color(0xFF292B31),
    dim: Color(0xFF595D6C),
    line: Color(0x29292B31),
    acc: Color(0xFF5D5294),
    accDim: Color(0xFF423A6A),
    accTint: Color(0x1F5D5294),
  );

  @override
  Nocturne copyWith({
    Color? bg,
    Color? surf,
    Color? raise,
    Color? ink,
    Color? dim,
    Color? line,
    Color? acc,
    Color? accDim,
    Color? accTint,
  }) =>
      Nocturne(
        bg: bg ?? this.bg,
        surf: surf ?? this.surf,
        raise: raise ?? this.raise,
        ink: ink ?? this.ink,
        dim: dim ?? this.dim,
        line: line ?? this.line,
        acc: acc ?? this.acc,
        accDim: accDim ?? this.accDim,
        accTint: accTint ?? this.accTint,
      );

  @override
  Nocturne lerp(ThemeExtension<Nocturne>? other, double t) {
    if (other is! Nocturne) return this;
    return Nocturne(
      bg: Color.lerp(bg, other.bg, t)!,
      surf: Color.lerp(surf, other.surf, t)!,
      raise: Color.lerp(raise, other.raise, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      dim: Color.lerp(dim, other.dim, t)!,
      line: Color.lerp(line, other.line, t)!,
      acc: Color.lerp(acc, other.acc, t)!,
      accDim: Color.lerp(accDim, other.accDim, t)!,
      accTint: Color.lerp(accTint, other.accTint, t)!,
    );
  }
}

extension NocturneContext on BuildContext {
  Nocturne get n => Theme.of(this).extension<Nocturne>()!;
}

/// Archivo Black. `tracking` em `em` (ex.: -0.045), convertido para px.
TextStyle display(
  double size, {
  double tracking = -0.02,
  double height = 0.85,
  Color? color,
}) =>
    GoogleFonts.archivoBlack(
      fontSize: size,
      height: height,
      letterSpacing: size * tracking,
      color: color,
    );

/// Inter Tight.
TextStyle body(
  double size, {
  FontWeight weight = FontWeight.w400,
  double tracking = 0,
  double height = 1.45,
  Color? color,
}) =>
    GoogleFonts.interTight(
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: size * tracking,
      color: color,
    );

/// Rótulos versaletes do design: uppercase + tracking largo.
/// Ex.: label(9.5, tracking: .2) para o kicker "LADO A · SETLIST".
TextStyle label(
  double size, {
  double tracking = 0.14,
  FontWeight weight = FontWeight.w600,
  Color? color,
}) =>
    body(size, weight: weight, tracking: tracking, height: 1.1, color: color);

ThemeData buildTheme(Nocturne n) {
  final base = n == Nocturne.dark ? ThemeData.dark() : ThemeData.light();
  return base.copyWith(
    scaffoldBackgroundColor: n.bg,
    extensions: [n],
    splashColor: n.accTint,
    highlightColor: n.accTint,
    // Cartões/superfícies não usam sombra: elevação = borda 1px --line.
    cardTheme: CardThemeData(
      color: n.surf,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: n.line),
      ),
    ),
  );
}

/// Raios do DS: 3 (controles), 5-6 (miniaturas), 8 (cartões), 99 (chips).
class R {
  static const ctrl = BorderRadius.all(Radius.circular(3));
  static const thumb = BorderRadius.all(Radius.circular(6));
  static const card = BorderRadius.all(Radius.circular(8));
  static const chip = BorderRadius.all(Radius.circular(99));
}

import 'package:flutter/material.dart';

class GradientExtension extends ThemeExtension<GradientExtension> {
  const GradientExtension({
    required this.gradient,
    required this.radarGradient,
    required this.viewGradient,
  });

  final Gradient? gradient;
  final Gradient? radarGradient;
  final RadialGradient? viewGradient;

  @override
  GradientExtension copyWith(
      {Gradient? gradient,
      Gradient? radarGradient,
      RadialGradient? viewGradient}) {
    return GradientExtension(
        gradient: gradient ?? this.gradient,
        radarGradient: radarGradient ?? this.radarGradient,
        viewGradient: viewGradient ?? this.viewGradient,
    );
  }

  @override
  GradientExtension lerp(GradientExtension? other, double t) {
    if (other is! GradientExtension) {
      return this;
    }
    return GradientExtension(
        gradient: Gradient.lerp(gradient, other.gradient, t),
        radarGradient: Gradient.lerp(radarGradient, other.radarGradient, t),
        viewGradient: RadialGradient.lerp(viewGradient, viewGradient, t)
    );
  }
}

extension GradientExt on ThemeData {
  GradientExtension get gradients => extension<GradientExtension>()!;
}

import 'package:flutter/material.dart';

class GradientExtension extends ThemeExtension<GradientExtension> {
  const GradientExtension({required this.gradient});

  final Gradient? gradient;

  @override
  GradientExtension copyWith(
      {Color? brandColor, Color? danger, Gradient? gradient}) {
    return GradientExtension(gradient: gradient ?? this.gradient);
  }

  @override
  GradientExtension lerp(GradientExtension? other, double t) {
    if (other is! GradientExtension) {
      return this;
    }
    return GradientExtension(
        gradient: Gradient.lerp(gradient, other.gradient, t));
  }
}

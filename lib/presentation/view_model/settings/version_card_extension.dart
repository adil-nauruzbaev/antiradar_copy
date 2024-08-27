import 'package:flutter/material.dart';

class VersionCardExtension extends ThemeExtension<VersionCardExtension> {
  const VersionCardExtension({
    required this.strokeColor,
    required this.highlightedStrokeColor,
  });

  final Color? strokeColor;
  final Color? highlightedStrokeColor;

  @override
  VersionCardExtension copyWith(
      {Color? strokeColor, Color? highlightedStrokeColor}) {
    return VersionCardExtension(
        strokeColor: strokeColor ?? this.strokeColor,
        highlightedStrokeColor:
            highlightedStrokeColor ?? this.highlightedStrokeColor);
  }

  @override
  VersionCardExtension lerp(VersionCardExtension? other, double t) {
    if (other is! VersionCardExtension) {
      return this;
    }
    return VersionCardExtension(
        strokeColor: Color.lerp(strokeColor, other.strokeColor, t),
        highlightedStrokeColor: Color.lerp(
            highlightedStrokeColor, other.highlightedStrokeColor, t));
  }
}

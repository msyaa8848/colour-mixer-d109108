import 'package:flutter/material.dart';

class ColorValueChanger extends StatelessWidget {
  final String label;
  final double value;
  final Color activeColor;
  final ValueChanged<double> onChanged;

  const ColorValueChanger({
    super.key,
    required this.label,
    required this.value,
    required this.activeColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$label: ${value.toInt()}"),
        Slider(
          value: value,
          min: 0,
          max: 255,
          activeColor: activeColor,
          onChanged: onChanged,
        ), // Slider
      ],
    ); // Column
  }
}

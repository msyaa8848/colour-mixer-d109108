import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fav_movie/main.dart';
import 'package:fav_movie/color_circle.dart';

void main() {
  testWidgets('Color mixer updates color values when sliders are moved', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the sliders initial texts are Red: 0, Green: 0, Blue: 0.
    expect(find.text('Red: 0'), findsOneWidget);
    expect(find.text('Green: 0'), findsOneWidget);
    expect(find.text('Blue: 0'), findsOneWidget);

    // Verify ColorCircle is present and check its initial color is black (0,0,0)
    final colorCircleFinder = find.byType(ColorCircle);
    expect(colorCircleFinder, findsOneWidget);
    ColorCircle circle = tester.widget<ColorCircle>(colorCircleFinder);
    expect(circle.color, const Color.fromRGBO(0, 0, 0, 1));

    // Slide the Red slider (the first Slider widget)
    final redSliderFinder = find.byType(Slider).at(0);
    // Drag it by some offset to change the value.
    await tester.drag(redSliderFinder, const Offset(100.0, 0.0));
    await tester.pumpAndSettle();

    // Verify that the Red value changed from 0
    expect(find.text('Red: 0'), findsNothing);
    
    // Find the current Red value by checking text starting with "Red:"
    final redTextFinder = find.byWidgetPredicate((widget) => widget is Text && widget.data != null && widget.data!.startsWith('Red:'));
    expect(redTextFinder, findsOneWidget);
    final String text = (tester.widget<Text>(redTextFinder)).data!;
    final int redValue = int.parse(text.split(': ')[1]);
    expect(redValue, isPositive);

    // The circle color should also be updated
    circle = tester.widget<ColorCircle>(colorCircleFinder);
    expect(circle.color, Color.fromRGBO(redValue, 0, 0, 1.0));
  });
}

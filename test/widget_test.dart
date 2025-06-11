import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:untitled/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CurrencyApp()); // заменили MyApp

    // Ожидаем, что на главном экране будет написан какой-то текст
    expect(find.text('Main Screen Content Here'), findsOneWidget);
  });
}

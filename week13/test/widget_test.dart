// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:week13/main.dart';
import 'package:week13/shared.dart';

void main() {
  testWidgets('Custom Widgets Test', (WidgetTester tester) async {
    // Mock data and controllers
    String buttonPressed = '';
    String textFieldValue = '';
    final TextEditingController controller = TextEditingController();

    // A dummy widget to test your custom widgets
    Widget testWidget = MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            buildButton(
              text: 'Test Button',
              onPressed: () {
                buttonPressed = 'Test Button Pressed';
              },
            ),
            buildTextfield(
              text: 'Test TextField',
              controller: controller,
              obscureText: false,
            ),
            buildElevatedButton(
              text: 'Test ElevatedButton',
              onPressed: () {
                buttonPressed = 'Test ElevatedButton Pressed';
              },
            ),
          ],
        ),
      ),
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(testWidget);

    // Verify that our button and text field widgets are present
    expect(find.text('Test Button'), findsOneWidget);
    expect(find.text('Test TextField'), findsOneWidget);
    expect(find.text('Test ElevatedButton'), findsOneWidget);

    // Test Button Click
    await tester.tap(find.byType(TextButton));
    await tester.pump();
    expect(buttonPressed, 'Test Button Pressed');

    // Test Elevated Button Click
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(buttonPressed, 'Test ElevatedButton Pressed');

    // Test TextField Entry
    await tester.enterText(find.byType(TextField), 'Hello');
    expect(controller.text, 'Hello');
  });
}

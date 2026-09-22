import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Fixed: Changed from a placeholder package name to a relative path
import '../lib/LoginPage.dart';

void main() {
  testWidgets('Login page renders fields and triggers validation errors', (WidgetTester tester) async {
    // 1. Load the LoginPage inside a MaterialApp wrapper for testing
    await tester.pumpWidget(const MaterialApp(
      home: LoginPage(),
    ));

    // 2. Verify that the login UI elements are present
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2)); // Expecting Email and Password fields
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);

    // 3. Tap the login button without filling out the form to trigger validation
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));

    // 4. Re-render the widget tree to display the error messages
    await tester.pump();

    // 5. Verify that the validation error messages appear on screen
    expect(find.text('Enter your email'), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);
  });
}
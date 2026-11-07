import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shotoregistrationpage/main.dart';

void main() {
  testWidgets('Registration screen renders core fields', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AvonApp());

    expect(find.text('Avon'), findsOneWidget);
    expect(find.text('Create your account'), findsOneWidget);
    expect(find.text('Email address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
  });

  testWidgets('Shows validation errors on empty submit', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AvonApp());

    await tester.tap(find.text('Create account'));
    await tester.pump();

    expect(find.text('Email address is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
  });

  testWidgets('Navigates to home screen on valid submit', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AvonApp());

    await tester.enterText(
      find.widgetWithText(TextFormField, 'you@example.com').first,
      'test@avon.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Create a password').first,
      'password123',
    );
    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();

    expect(find.text("You're in!"), findsOneWidget);
    expect(find.textContaining('test@avon.com'), findsOneWidget);
  });
}

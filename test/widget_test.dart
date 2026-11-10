import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shotoregistrationpage/main.dart';
import 'package:shotoregistrationpage/widgets/aven_checkbox_row.dart';

void main() {
  testWidgets('Registration screen renders core fields', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AvonApp());

    expect(find.text('Avon'), findsOneWidget);
    expect(find.text('Create your account'), findsOneWidget);
    expect(find.text('Full name'), findsOneWidget);
    expect(find.text('Email address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
  });

  testWidgets('Shows validation errors on empty submit', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AvonApp());

    await tester.ensureVisible(find.text('Create account'));
    await tester.tap(find.text('Create account'));
    await tester.pump();

    expect(find.text('Full name is required'), findsOneWidget);
    expect(find.text('Email address is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
    expect(find.text('You must accept the terms to continue'), findsOneWidget);
  });

  testWidgets('Password visibility toggle switches obscureText', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AvonApp());

    final passwordFieldFinder = find
        .widgetWithText(TextFormField, 'Create a password')
        .first;
    final editableTextFinder = find.descendant(
      of: passwordFieldFinder,
      matching: find.byType(EditableText),
    );

    expect(tester.widget<EditableText>(editableTextFinder).obscureText, isTrue);

    await tester.ensureVisible(find.byIcon(Icons.visibility_outlined).first);
    await tester.tap(find.byIcon(Icons.visibility_outlined).first);
    await tester.pump();

    expect(
      tester.widget<EditableText>(editableTextFinder).obscureText,
      isFalse,
    );
  });

  testWidgets('Navigates to home screen on valid submit', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AvonApp());

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Your name').first,
      'Test User',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'you@example.com').first,
      'test@avon.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Create a password').first,
      'password123',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Re-enter your password').first,
      'password123',
    );
    await tester.ensureVisible(find.byType(AvenCheckboxRow).first);
    final checkboxTopLeft = tester.getTopLeft(
      find.byType(AvenCheckboxRow).first,
    );
    await tester.tapAt(checkboxTopLeft + const Offset(12, 12));
    await tester.pump();

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.ensureVisible(find.text('Create account'));
    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();

    expect(find.text('Full name is required'), findsNothing);
    expect(find.text('Email address is required'), findsNothing);
    expect(find.text('Password is required'), findsNothing);
    expect(find.text('You must accept the terms to continue'), findsNothing);
    expect(find.text("You're in!"), findsOneWidget);
    expect(find.textContaining('test@avon.com'), findsOneWidget);
  });
}

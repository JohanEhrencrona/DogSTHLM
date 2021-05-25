// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hund_pvt/Pages/registration_page.dart';
import 'package:hund_pvt/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

typedef Callback = void Function(MethodCall call);

void setupFirebaseAuthMocks([Callback customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFirebase.channel.setMockMethodCallHandler((call) async {
    if (call.method == 'Firebase#initializeCore') {
      return [
        {
          'name': defaultFirebaseAppName,
          'options': {
            'apiKey': '123',
            'appId': '123',
            'messagingSenderId': '123',
            'projectId': '123',
          },
          'pluginConstants': {},
        }
      ];
    }

    if (call.method == 'Firebase#initializeApp') {
      return {
        'name': call.arguments['appName'],
        'options': call.arguments['options'],
        'pluginConstants': {},
      };
    }

    if (customHandlers != null) {
      customHandlers(call);
    }

    return null;
  });
}

Future<T> neverEndingFuture<T>() async {
  // ignore: literal_only_boolean_expressions
  while (true) {
    await Future.delayed(const Duration(minutes: 5));
  }
}

void setUppAll () async {
  await Firebase.initializeApp();
}

void main() {
  setupFirebaseAuthMocks();
  setUppAll();

  Widget createWidgetForTesting({Widget child}){
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Test registration', (WidgetTester tester) async {

    await tester.pumpWidget(createWidgetForTesting(child: new RegistrationPage()));

     final emailSignInField = find.bySemanticsLabel("Email");
     expect(emailSignInField, findsOneWidget);
     await tester.pump();
     await tester.enterText(emailSignInField, "testtest@test.nu");
     expect(find.text('testtest@test.nu'), findsOneWidget);

    /* final dogNameField = find.text('Dog Name');
    expect(dogNameField, findsOneWidget);

    await tester.pump();
    await tester.enterText(find.byType(EditableText), "Fido");

     final dogAgeField = find.text('Dog Age');
    expect(dogAgeField, findsOneWidget);

    await tester.pump();
    await tester.enterText(find.byType(EditableText), "10");

    final dogRaceField = find.text('Dog race');
    expect(dogRaceField, findsOneWidget);

    await tester.pump();
    await tester.enterText(find.byType(EditableText), "Mastiff");

    final passwordField = find.text('Password');
    expect(passwordField, findsOneWidget);

    await tester.pump();
    await tester.enterText(find.byType(EditableText), "lösenord");

    final confirmPasswordField = find.text('Confirm Password');
    expect(confirmPasswordField, findsOneWidget);

    await tester.pump();
    await tester.enterText(find.byType(EditableText), "lösenord");

    */

  });
  /*
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

   */

}

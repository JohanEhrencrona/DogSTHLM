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


// Credit to FireBase Developers
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

void  main() {
  setupFirebaseAuthMocks();
  setUppAll();

  Widget createWidgetForTesting({Widget child}){
    return MaterialApp(
      home: child,
    );
  }



  testWidgets('Test registrate account', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: new RegistrationPage()));
     final emailSignInField = find.bySemanticsLabel("Email");
     expect(emailSignInField, findsOneWidget);
     await tester.enterText(emailSignInField, "testtest@test.nu");
     expect(find.text('testtest@test.nu'), findsOneWidget);

    final dogNameField = find.bySemanticsLabel("Dog name");
    expect(dogNameField, findsOneWidget);
    await tester.enterText(dogNameField, "Fido");
    expect(find.text('Fido'), findsOneWidget);

    final dogAgeField = find.bySemanticsLabel("Dog age");
    expect(dogAgeField, findsOneWidget);
    await tester.enterText(dogAgeField, "10");
    expect(find.text('10'), findsOneWidget);

    final dogRaceField = find.bySemanticsLabel("Dog race");
    expect(dogRaceField, findsOneWidget);
    await tester.enterText(dogRaceField, "Mastiff");
    expect(find.text('Mastiff'), findsOneWidget);

    final passwordField = find.bySemanticsLabel("Password");
    expect(passwordField, findsOneWidget);
    await tester.enterText(passwordField, "123456");

    final confirmPasswordField = find.bySemanticsLabel("Confirm Password");
    expect(confirmPasswordField, findsOneWidget);
    await tester.enterText(passwordField, "123456");

    final registerButton = find.byKey(ValueKey("RegisterButton"));
    expect(registerButton, findsOneWidget);
    await tester.pumpAndSettle();
    await tester.tap(registerButton);

    await tester.pump(new Duration(milliseconds: 1000));
    final successMessage = find.byKey(ValueKey("successMessage"));
    expect(successMessage, findsOneWidget);
  });



}

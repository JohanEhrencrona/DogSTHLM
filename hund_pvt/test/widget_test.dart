// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';
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



// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
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
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();


  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Widget createWidgetForTesting({Widget child}){
    return MaterialApp(
      home: child,
    );
  }



  testWidgets('Test register account', (WidgetTester tester) async {
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

  testWidgets('Test email validator', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: new RegistrationPage()));

    final emailSignInField = find.bySemanticsLabel("Email");
    expect(emailSignInField, findsOneWidget);

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    //final findErrorText = find.text("Please enter a valid email");

    for (int i = 0; i < 100; ++i) {
      String email =  getRandomString(_rnd.nextInt(15)) + "@" + getRandomString(_rnd.nextInt(5)) + "." + getRandomString(_rnd.nextInt(5));
      print(email);
      await tester.enterText(emailSignInField, email);
      expect(find.text(email), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 500)); // add delay
      final findErrorText = find.text("Please enter a valid email");
      if (!regex.hasMatch(email)){
        expect(findErrorText, findsOneWidget);
        // ignore: unnecessary_statements
      } else () {
        // ignore: unnecessary_statements
        expect(findErrorText, findsNothing);
      };
    }
  });



  testWidgets('Test password validator', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: new RegistrationPage()));

    final PasswordSignInField = find.bySemanticsLabel("Password");
    expect(PasswordSignInField, findsOneWidget);

    Pattern passwordPattern = r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])';
    RegExp passwordRegex = new RegExp(passwordPattern);;

    for (int i = 0; i < 100; ++i) {
      String password =  getRandomString(_rnd.nextInt(10)) + _rnd.nextInt(10).toString() + getRandomString(_rnd.nextInt(5));
      print(password);
      await tester.enterText(PasswordSignInField, password);
      await tester.pump(const Duration(milliseconds: 500)); // add delay
      final findErrorText = find.text("(8-16 characters), 1 capitalized letter, 1 number");
      if (!passwordRegex.hasMatch(password)){
        expect(findErrorText, findsOneWidget);
        // ignore: unnecessary_statements
      } else () {
        // ignore: unnecessary_statements
        expect(findErrorText, findsNothing);
      };
    }
  });

}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hund_pvt/JSON/parsejsonlocationfirebase.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:hund_pvt/Pages/login_page.dart';

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

Future <void> setUppAll () async {
  await Firebase.initializeApp();
}

void main() async {

  setupFirebaseAuthMocks();
  await setUppAll();
  final FirebaseAuth auth = FirebaseAuth.instance;

  test('Location added to favorites', () {

    String email = 'JA@JA.se';
    String password = '123456';

    final LocationsFromDatabase favorite = new LocationsFromDatabase(adress: 'Street', name: 'Best place', latitude: 58,longitude: 58);

    LoginPage().createState().signIn(email, password);

    postFavorite(favorite);
    getFavorites();

    expect(favoriteList.contains(favorite),true);
  });
}
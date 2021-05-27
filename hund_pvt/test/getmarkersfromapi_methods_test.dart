import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hund_pvt/JSON/parsejsonlocationfirebase.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';
import 'package:hund_pvt/Services/userswithdogs.dart';

import 'package:http/http.dart' as http;

void main() async {
  LocationsFromDatabase favorite = LocationsFromDatabase(
      adress: 'Street',
      name: 'Best place',
      latitude: 58.337201,
      longitude: 58.079945);

  userList.add(LoggedInUser(
      uid: 'cZskpl2UuJMEt4mJ87hHIhtp4DR2',
      dog: Dog(name: 'Peter', race: 'Tax', age: 3)));

  test('Location added to favorites', () async {
    await postOrDeleteFavorite(http.Client(), favorite, 'post');
    await getFavorites(http.Client());

    expect(
        favoriteList.contains(Locations(
          name: favorite.name,
          adress: favorite.adress,
          latitude: favorite.latitude,
          longitude: favorite.longitude,
          type: '',
        )),
        true);
  });
  test('Delete location in favorites', () async {
    await postOrDeleteFavorite(http.Client(), favorite, 'delete');
    await getFavorites(http.Client());

    expect(
        favoriteList.contains(Locations(
          name: favorite.name,
          adress: favorite.adress,
          latitude: favorite.latitude,
          longitude: favorite.longitude,
          type: '',
        )),
        false);
  });

  group('Check in and out of park and check that the database has updated', () {
    LocationPark testPark = LocationPark(name: 'Testpark123456789123456');
    //testPark name must be long because we use substring to only get the
    //id numbers from open data when pushing to our own database.
    Dog testDog = Dog(age: 2, name: 'Test', race: 'Bull');
    Dog testDog2 = Dog(age: 3, name: 'Test2', race: 'pudel');

    test('Check in to park', () async {
      //only adding testDog to check in to database.
      testPark.dogsInPark.add(testDog);
      expect(
          await postOrDeleteCheckInPark(
                  http.Client(),
                  CheckInParkLocation(
                      name: testPark.name, dogsCheckedIn: testPark.dogsInPark))
              .then((value) => value.statusCode),
          200);
    });
    test('Database been updated, and replaces the parks list of dogs',
        () async {
      //adding another dog to the parks list locally to see that
      //after the getCheckInPark has completed, testPark shouldnt contain
      //testdog2 anymore, testParks list should have been replaced with
      //the list from the database which only contains testDog.
      testPark.dogsInPark.add(testDog2);

      await getCheckInPark(http.Client(), testPark);
      expect(testPark.dogsInPark.contains(testDog2), false);
    });

    test('Check out from park', () async {
      testPark.dogsInPark.remove(testDog);
      expect(
          await postOrDeleteCheckInPark(
                  http.Client(),
                  CheckInParkLocation(
                      name: testPark.name, dogsCheckedIn: testPark.dogsInPark))
              .then((value) => value.statusCode),
          200);
    });

    test('Database has updated, list is now empty', () async {
      //adding dog locally to show that the list will be replaced with
      //the list from the database for the park, which should be empty
      //after the earlier checkout
      testPark.dogsInPark.add(testDog2);
      print(
          'testPark contains testDog 2 : ${testPark.dogsInPark.contains(testDog2)}');
      //printing to show that the list actually contains testDog2.

      await getCheckInPark(http.Client(), testPark);
      expect(testPark.dogsInPark.isEmpty, true);
      //Now testParks list is based on the database, which were empty
      // because we already checked out.
    });
  });

  group('Get and add places to FireBase', () {
    //LocationsFromDatabase is the class that creates
    //JSON object to and from the database.
    LocationsFromDatabase testCafeToAdd = LocationsFromDatabase(
        adress: 'TestStreet',
        name: 'TestCafe',
        latitude: 58.337201,
        longitude: 58.079945);
    LocationsFromDatabase testRestaurantToAdd = LocationsFromDatabase(
        adress: 'TestStreet',
        name: 'TestRestaurant',
        latitude: 58.337201,
        longitude: 58.079945);
    LocationsFromDatabase testPetshopToAdd = LocationsFromDatabase(
        adress: 'TestStreet',
        name: 'TestPetshop',
        latitude: 58.337201,
        longitude: 58.079945);

    //Creating test Locations to compare the lists with,
    //LocationsFromDatabase becomes Locations object when they are recieved.
    Locations testCafeLocation = Locations(
        adress: 'TestStreet',
        name: 'TestCafe',
        latitude: 58.337201,
        longitude: 58.079945);

    Locations testRestaurantLocation = Locations(
        adress: 'TestStreet',
        name: 'TestRestaurant',
        latitude: 58.337201,
        longitude: 58.079945);
    Locations testPetshopLocation = Locations(
        adress: 'TestStreet',
        name: 'TestPetshop',
        latitude: 58.337201,
        longitude: 58.079945);

    test('Check that none of these places exists in database', () async {
      await getPlacesFromFireBase(http.Client(), 'cafes', listType.cafe);
      await getPlacesFromFireBase(
          http.Client(), 'restaurants', listType.restaurant);
      await getPlacesFromFireBase(http.Client(), 'petshops', listType.petshop);

      //Check that none of the lists which are based on the database
      // contains the places already
      expect(cafeList.contains(testCafeLocation), false);
      expect(restaurantList.contains(testRestaurantLocation), false);
      expect(petshopList.contains(testPetshopLocation), false);
    });

    test('post cafe', () async {
      http.Response response = await postOrDeletePlaceToFireBase(
          http.Client(), testCafeToAdd, 'cafes', 'post');
      expect(response.statusCode, 200);
    });
    test('post restaurant', () async {
      http.Response response = await postOrDeletePlaceToFireBase(
          http.Client(), testRestaurantToAdd, 'restaurants', 'post');
      expect(response.statusCode, 200);
    });
    test('post petshop', () async {
      http.Response response = await postOrDeletePlaceToFireBase(
          http.Client(), testPetshopToAdd, 'petshops', 'post');
      expect(response.statusCode, 200);
    });

    test(
        'Check that all the places have been added to the database, and local lists now are reflecting that update',
        () async {
      await getPlacesFromFireBase(http.Client(), 'cafes', listType.cafe);
      await getPlacesFromFireBase(
          http.Client(), 'restaurants', listType.restaurant);
      await getPlacesFromFireBase(http.Client(), 'petshops', listType.petshop);

      expect(cafeList.contains(testCafeLocation), true);
      expect(restaurantList.contains(testRestaurantLocation), true);
      expect(petshopList.contains(testPetshopLocation), true);
    });

    test('delete cafe', () async {
      http.Response response = await postOrDeletePlaceToFireBase(
          http.Client(), testCafeToAdd, 'cafes', 'delete');
      expect(response.statusCode, 200);
    });
    test('delete restaurant', () async {
      http.Response response = await postOrDeletePlaceToFireBase(
          http.Client(), testRestaurantToAdd, 'restaurants', 'delete');
      expect(response.statusCode, 200);
    });
    test('delete petshop', () async {
      http.Response response = await postOrDeletePlaceToFireBase(
          http.Client(), testPetshopToAdd, 'petshops', 'delete');
      expect(response.statusCode, 200);
    });

    test('Check that the places have been deleted from database', () async {
      await getPlacesFromFireBase(http.Client(), 'cafes', listType.cafe);
      await getPlacesFromFireBase(
          http.Client(), 'restaurants', listType.restaurant);
      await getPlacesFromFireBase(http.Client(), 'petshops', listType.petshop);

      //Check that none of the lists which are based on the database
      // contains the places already
      expect(cafeList.contains(testCafeLocation), false);
      expect(restaurantList.contains(testRestaurantLocation), false);
      expect(petshopList.contains(testPetshopLocation), false);
    });
  });
}

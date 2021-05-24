List<LoggedInUser> userList = [];

class LoggedInUser {
  String uid;
  Dog dog;

  LoggedInUser({this.uid, this.dog});
}

class Dog {
  String name;
  String race;
  int age;

  Dog({this.name, this.race, this.age});

  String get getName => this.name;

  String get getRace => this.race;

  int get getAge => this.age;




  factory Dog.fromJson(Map<String, dynamic> parsedJson) {
    return Dog(
      name: parsedJson['name'],
      race: parsedJson['race'],
      age: int.parse(parsedJson['age']),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "race": race,
        "age": age.toString(),
      };


  setName(String dogName) {
    this.name=dogName;
  }
  setAge (int dogAge) {
    this.age=dogAge;
  }
  setRace(String dogRace) {
    this.race=dogRace;
  }
}

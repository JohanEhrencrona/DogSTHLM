List<LoggedInUser> userList = [];

class LoggedInUser {
  String uid;
  Dog dog;
  bool checkedIn;

  bool getCheckedIn() {
    return checkedIn;
  }

  setCheckedIn(bool checkedInOrOut) {
    checkedIn = checkedInOrOut;
  }

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

  @override
  bool operator ==(other) {
    return (other is Dog) &&
        other.name == name &&
        other.race == race &&
        other.age == age;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

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
}

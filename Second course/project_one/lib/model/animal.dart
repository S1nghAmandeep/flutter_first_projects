void main() {
  Dog myDog = Dog('Buddy', 'fast');
  myDog.burk();
  Cat cat = Cat('Manu', 'very fast');
  cat.cuccia = Type.small;
  cat.meow(
      'The cat\'s name is ${cat.name} and has ${cat.speed} speed and lives in ${cat.cuccia.name} cuccia');
}

enum Type { big, mid, large, small }

abstract class Animal {
  final String name;
  final String speed;

  Animal(this.name, this.speed);
}

mixin Cuccia {
  late Type cuccia;
}

class Dog extends Animal {
  Dog(super.name, super.speed);

  void burk() {
  //   print(
  //       'The dogs name is $name and the speed is $speed and it says Bau bau and has ');
  }
}

class Cat extends Animal with Cuccia {
  Cat(super.name, super.speed);

  void meow(String words) {
    // print(words);
  }
}

class User {
  final String firstName;
  final String lastName;
  final int? age;
  final int? phoneNumber;
  final String? address;
  final String email;

  User._(UserBuilder builder) : firstName = builder._firstName!, lastName = builder._lastName!,
  email = builder._email!, age = builder._age!, phoneNumber = builder._phoneNumber, address = builder._address;

  String get getFirstName => firstName;
  String get getLastName => lastName;
  String get getemail => email;
  int? get getAge => age;
  int? get getPhoneNumber => phoneNumber;
  String? get getAddress => address;
}

class UserBuilder {
  String? _firstName;
  String? _lastName;
  String? _address;
  String? _email;
  int? _phoneNumber;
  int? _age;

  UserBuilder setFirstName(String firstName) {
    _firstName = firstName;
    return this;
  }

  UserBuilder setLastName(String lastName) {
    _lastName = lastName;
    return this;
  }

  UserBuilder setAddress(String address) {
    _address = address;
    return this;
  }

  UserBuilder setEmail(String email) {
    _email = email;
    return this;
  }

  UserBuilder setPhoneNumber(int phoneNumber) {
    _phoneNumber = phoneNumber;
    return this;
  } 

  UserBuilder setAge(int age) {
    _age = age;
    return this;
  }

  User build() {
    if(_firstName == null || _lastName == null || _email == null) {
      throw Exception('First name, last name and email are required');
    }
    return User._(this);
  }
}

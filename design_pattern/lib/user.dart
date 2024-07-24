class User {
  String name;
  String email;

  User(this.email, this.name);
}

class SaveUser {
  void saveUserToDatabase(User user) {
    //save it now
  }
}

class ShowMessage {
  void showWelcomeMessage(User user) {
    // print('Welcome, ${user.name}!');
  }
}

abstract class Shape {
  double calculateArea();
}

class Circle extends Shape {
  Circle(this.radius);
  double radius;

  @override
  double calculateArea() {
    return 3.14 * radius + radius;
  }
}

class Retangle extends Shape {
  Retangle(this.area);
  double area;

  @override
  double calculateArea() {
    return area + area;
  }
}

class AreaCalculator {
  double calculateArea(Shape shape) {
    return shape.calculateArea();
  }
}

class User1 {
  String name;

  User1(this.name);
}

abstract class Database {
  void saveUser(User1 user1);
}

class MySqlDtabase implements Database {
  @override
  void saveUser(User1 user1) {
    // TODO: implement saveUser
  }
}

class MongoSql implements Database {
  @override
  void saveUser(User1 user1) {
    // TODO: implement saveUser
  }
}

class UserService {
  UserService(this.database);

  Database database;

  void saveUser(User1 user1) {
    database.saveUser(user1);
  }
}

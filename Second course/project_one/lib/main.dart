import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<http.Response> postData(String userId, String title) {
    return http.post(Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{'userId': userId, 'title': title}));
  }

  Future<http.Response> putData(String userId, String title) {
    return http.delete(Uri.parse('https://fakestoreapi.com/products/1'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'userId': userId, 'title': title}));
  }

  Future<http.Response> deleteData() {
    return http.put(Uri.parse('https://fakestoreapi.com/products/1'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},);
  }

  final json = {"key1" : "some1", "key2" : "some2"};
  late String keyValue;
  @override
  void initState() {
    super.initState();
    keyValue = jsonEncode(json);
    print(keyValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () {
            // postData('userOne', 'something').then((value) => print(value.body));
            putData('userPut', 'somethingPut').then((value) => print(value.body));
            deleteData().then((value) => print(value.body));
          },
          child: const Text('Delete data'),
        ),
      ),
    );
  }
}

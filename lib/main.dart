import 'package:company_developer/controller/developer_controller.dart';
import 'package:company_developer/models/developer.dart';
import 'package:company_developer/views/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  final developerData = {
    "company": "Tech Solutions",
    "location": "San Francisco",
    "employees": [
      {
        "name": "Alice",
        "age": 30,
        "position": "Developer",
        "skills": ["Dart", "Flutter", "Firebase"]
      },
      {
        "name": "Bob",
        "age": 25,
        "position": "Designer",
        "skills": ["Photoshop", "Illustrator"]
      }
    ],
    "products": [
      {
        "name": "Product A",
        "price": 29.99,
        "inStock": true,
      },
      {
        "name": "Product B",
        "price": 49.99,
        "inStock": false,
      }
    ]
  };

  final developer = Developer.fromJson(developerData);
  final developerController = DeveloperController(developer);

  runApp(MyApp(developerController: developerController));
}

class MyApp extends StatelessWidget {
  final DeveloperController developerController;

  const MyApp({super.key, required this.developerController});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(controller: developerController),
    );
  }
}

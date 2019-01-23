import 'package:flutter/material.dart';

import 'models/AnimalRepo.dart';
import 'models/ZooRepo.dart';
import 'screens/AnimalListScreen.dart';

void main() {
  runApp(new MyApp());
  getAnimals();
  getZoos();
}

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Show me the Otters!',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: AnimalListScreen(),
    );
  }
}

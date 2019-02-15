import 'package:flutter/material.dart';

import '../components/AnimalIconsMap.dart';
import '../models/Animal.dart';
import '../screens/AnimalScreen.dart';

class AnimalListItem extends StatelessWidget {
  final Animal animal;

  AnimalListItem({@required this.animal});

  @override
  build(context) {
    return Padding(
      key: ValueKey(animal.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          leading: Icon(
            animal.icon != null ? animalIconMap[animal.icon] : Icons.pets,
            color: Colors.blueGrey,
          ),
          title: Text(animal.name),
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimalScreen(animal: animal),
                ),
              ),
        ),
      ),
    );
  }
}

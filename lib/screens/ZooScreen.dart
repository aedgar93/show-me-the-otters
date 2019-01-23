import 'package:flutter/material.dart';

import '../models/Animal.dart';
import '../models/AnimalRepo.dart';
import '../models/Zoo.dart';

class ZooScreen extends StatefulWidget {
  final Zoo zoo;

  ZooScreen({@required this.zoo});

  @override
  createState() => _ZooScreenState(zoo: this.zoo);
}

class _ZooScreenState extends State<ZooScreen> {
  final Zoo zoo;
  List<Animal> animalsForZoo;

  _ZooScreenState({@required this.zoo});

  void _getAnimals() {
    animalsForZoo = new List<Animal>();
    var currentDocId = zoo.reference.documentID;

    getAnimals().then((animals) {
      setState(() {
        animals.forEach((animal) {
          var foundZoo = animal.zoos.firstWhere((animalZoo) {
            return animalZoo.documentID == currentDocId;
          });
          if (foundZoo != null) {
            animalsForZoo.add(animal);
          }
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getAnimals();
  }

  Widget _buildListItem(BuildContext context, Animal animal) {
    return Padding(
      key: ValueKey(animal.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(animal.name),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidget = new Column(
      children: <Widget>[
        new Container(
          height: 230.0,
          child: Text("${zoo.name}"),
        ),
        new Expanded(
          child: ListView(
            padding: const EdgeInsets.only(top: 20.0),
            children: animalsForZoo
                .map((data) => _buildListItem(context, data))
                .toList(),
          ),
        ),
      ],
    );

    return new Scaffold(
      appBar: AppBar(
        title: new Text(
          "${zoo.name}",
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: new Container(
        child: screenWidget,
      ),
    );
  }
}

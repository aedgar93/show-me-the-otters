import 'package:flutter/material.dart';

import '../models/Animal.dart';
import '../models/Zoo.dart';
import '../models/ZooRepo.dart';

class AnimalScreen extends StatefulWidget {
  final Animal animal;

  AnimalScreen({@required this.animal});

  @override
  createState() => _AnimalScreenState(animal: this.animal);
}

class _AnimalScreenState extends State<AnimalScreen> {
  final Animal animal;
  final List<Zoo> zoosForAnimal = new List<Zoo>();

  _AnimalScreenState({@required this.animal});

  void getAnimalsZoos() async {
    var zoos = await getZoos();
    if (zoos.length == 0) return;
    setState(() {
      animal.zoos.forEach((ref) {
        zoosForAnimal.add(zoos.firstWhere((zoo) {
          return zoo.reference.documentID == ref.documentID;
        }));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAnimalsZoos();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidget = new Column(
      children: <Widget>[
        new Container(
          height: 50,
          child: new Text(
            "You can find ${animal.name}s at these zoos:",
            style: new TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        new Expanded(
          child: ListView.builder(
            itemCount: zoosForAnimal.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(zoosForAnimal[index].name));
            },
          ),
        ),
      ],
    );

    return new Scaffold(
      appBar: AppBar(
        title: new Text(
          "${animal.name}",
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

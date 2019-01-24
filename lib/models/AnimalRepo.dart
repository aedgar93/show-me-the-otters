import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'Animal.dart';

List<Animal> animals;

Future<List<Animal>> getAnimals() {
  var completer = new Completer<List<Animal>>();
  if (animals != null) {
    completer.complete(animals);
  } else {
    Firestore.instance.collection('animals').snapshots().listen((data) {
      animals = new List<Animal>();
      data.documents.forEach((doc) {
        animals.add(Animal.fromSnapshot(doc));
      });
      animals.sort((a, b) => a.name.compareTo(b.name));
      if (!completer.isCompleted) completer.complete(animals);
    });
  }
  return completer.future;
}

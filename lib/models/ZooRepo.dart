import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'Zoo.dart';

List<Zoo> zoos;

Future<List<Zoo>> getZoos() {
  var completer = new Completer<List<Zoo>>();
  if (zoos != null) {
    completer.complete(zoos);
  } else {
    Firestore.instance.collection('zoos').snapshots().listen((data) {
      zoos = new List<Zoo>();
      data.documents.forEach((doc) {
        zoos.add(Zoo.fromSnapshot(doc));
      });
      zoos.sort((a, b) => a.name.compareTo(b.name));
      if (!completer.isCompleted) completer.complete(zoos);
    });
  }
  return completer.future;
}

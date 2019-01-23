import 'package:cloud_firestore/cloud_firestore.dart';

class Animal {
  final List<dynamic> zoos;
  final String name;
  final DocumentReference reference;

  Animal({this.zoos, this.name, this.reference});

  factory Animal.fromSnapshot(DocumentSnapshot snapshot) {
    return Animal.fromMap(snapshot.data, snapshot.reference);
  }

  factory Animal.fromMap(Map<String, dynamic> results, DocumentReference ref) {
    return Animal(
      zoos: results['zoos'],
      name: results['name'],
      reference: ref,
    );
  }
}

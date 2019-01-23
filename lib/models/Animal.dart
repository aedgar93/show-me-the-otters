import 'package:cloud_firestore/cloud_firestore.dart';

class Animal {
  final List<DocumentReference> zoos;
  final String name;
  final DocumentReference reference;

  Animal({this.zoos, this.name, this.reference});

  factory Animal.fromSnapshot(DocumentSnapshot snapshot) {
    return Animal.fromMap(snapshot.data, snapshot.reference);
  }

  factory Animal.fromMap(Map<String, dynamic> results, DocumentReference ref) {
    var zoos = new List<DocumentReference>.from(results['zoos']);
    return Animal(
      zoos: zoos,
      name: results['name'],
      reference: ref,
    );
  }
}

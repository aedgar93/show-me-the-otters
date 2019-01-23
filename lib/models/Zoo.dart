import 'package:cloud_firestore/cloud_firestore.dart';

class Zoo {
  final List<dynamic> animals;
  final String name;
  final GeoPoint location;
  final DocumentReference reference;

  Zoo({this.animals, this.name, this.location, this.reference});

  factory Zoo.fromSnapshot(DocumentSnapshot snapshot) {
    return Zoo.fromMap(snapshot.data, snapshot.reference);
  }

  factory Zoo.fromMap(Map<String, dynamic> results, DocumentReference ref) {
    return Zoo(
      animals: results['animals'],
      name: results['name'],
      location: results['location'],
      reference: ref,
    );
  }
}

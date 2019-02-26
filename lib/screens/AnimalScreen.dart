import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  Completer<GoogleMapController> _mapController = Completer();

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
      _updateMarkers();
    });
  }

  @override
  void initState() {
    super.initState();
    getAnimalsZoos();
  }

  void _updateMarkers() async {
    final GoogleMapController mapController = await _mapController.future;
    if (zoosForAnimal == null || zoosForAnimal.length == 0) return;
    zoosForAnimal.forEach((zoo) {
      var latLng = new LatLng(zoo.location.latitude, zoo.location.longitude);
      var marker = new MarkerOptions(position: latLng);
      mapController.addMarker(marker);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidget = new Column(
      children: <Widget>[
        new Container(
          height: 300.0,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(39.82, -98.5),
              zoom: 3,
            ),
            onMapCreated: _onMapCreated,
          ),
        ),
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

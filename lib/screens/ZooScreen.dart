import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../components/AnimalListItem.dart';
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
  GoogleMapController mapController;

  _ZooScreenState({@required this.zoo});

  void _getAnimals() {
    animalsForZoo = new List<Animal>();
    var currentDocId = zoo.reference.documentID;

    getAnimals().then((animals) {
      setState(() {
        animals.forEach((animal) {
          if (animal == null || animal.zoos == null || animal.zoos.length == 0)
            return print(animal);
          var foundZooIndex = animal.zoos.lastIndexWhere((animalZoo) {
            return animalZoo.documentID == currentDocId;
          });
          if (foundZooIndex != -1) {
            animalsForZoo.add(animal);
          }
        });
        animalsForZoo.sort((a, b) => a.name.compareTo(b.name));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getAnimals();
  }

  Widget _buildListItem(BuildContext context, Animal animal) {
    return new AnimalListItem(animal: animal);
  }

  void _updateMarkers() {
    var latLng = new LatLng(zoo.location.latitude, zoo.location.longitude);
    var marker = new MarkerOptions(position: latLng);
    mapController.addMarker(marker);
    mapController.moveCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: latLng,
        zoom: 10.0,
      ),
    ));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      _updateMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidget = new Column(
      children: <Widget>[
        new Container(
          height: 230.0,
          child: GoogleMap(
            options: new GoogleMapOptions(myLocationEnabled: true),
            onMapCreated: _onMapCreated,
          ),
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

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
  GoogleMapController mapController;

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
      if (mapController != null) _updateMarkers();
    });
  }

  @override
  void initState() {
    super.initState();
    getAnimalsZoos();
  }

  void _updateMarkers() {
    var defaultLatLng;
    zoosForAnimal.forEach((zoo) {
      var latlng = new LatLng(zoo.location.latitude, zoo.location.longitude);
      defaultLatLng = latlng;
      var marker = new MarkerOptions(position: latlng);
      mapController.addMarker(marker);
    });
    mapController.moveCamera(CameraUpdate.newLatLng(defaultLatLng));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      if (zoosForAnimal.length > 0) _updateMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidget = new Column(
      children: <Widget>[
        new Container(
          height: 300.0,
          child: GoogleMap(
            options: new GoogleMapOptions(myLocationEnabled: true),
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

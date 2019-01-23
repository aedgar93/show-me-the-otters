import 'package:flutter/material.dart';

import '../screens/AnimalListScreen.dart';
import '../screens/ZooListScreen.dart';

class SideNav extends StatefulWidget {
  final String currentPage;
  SideNav({@required this.currentPage});

  @override
  createState() => _SideNavState(currentPage: this.currentPage);
}

class _SideNavState extends State<SideNav> {
  final String currentPage;

  _SideNavState({@required this.currentPage});

  @override
  build(context) {
    return new Drawer(
        child: new ListView(
      children: <Widget>[
        Container(
          height: 70,
          child: new DrawerHeader(
              child: new Text(
                "Show me the Otters!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              decoration: new BoxDecoration(color: Colors.teal),
              padding: EdgeInsets.all(20.0)),
        ),
        new ListTile(
          title: new Text('Animals'),
          onTap: () {
            Navigator.of(context).pop();
            if (currentPage != 'animals') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AnimalListScreen()));
            }
          },
          trailing: currentPage != 'animals' ? Icon(Icons.navigate_next) : null,
        ),
        new ListTile(
          title: new Text('Zoos'),
          onTap: () {
            Navigator.of(context).pop();
            if (currentPage != 'zoos') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ZooListScreen()));
            }
          },
          trailing: currentPage != 'zoos' ? Icon(Icons.navigate_next) : null,
        ),
      ],
    ));
  }
}

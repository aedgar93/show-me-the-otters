import 'package:flutter/material.dart';

import '../components/SideNav.dart';
import '../models/Zoo.dart';
import '../models/ZooRepo.dart';
import 'ZooScreen.dart';

class ZooListScreen extends StatefulWidget {
  ZooListScreen();

  @override
  createState() => _ZooListScreenState();
}

class _ZooListScreenState extends State {
  List<Zoo> zoos = new List<Zoo>();
  List<Zoo> zoosToDisplay = new List<Zoo>();

  _ZooListScreenState();
  TextEditingController editingController = TextEditingController();

  _getZoos() async {
    var futureZoos = await getZoos();
    setState(() {
      zoos.addAll(futureZoos);
      zoosToDisplay.addAll(futureZoos);
    });
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      query = query.toLowerCase();
      List<Zoo> listData = List<Zoo>();
      zoos.forEach((item) {
        if (item.name.toLowerCase().contains(query)) {
          listData.add(item);
        }
      });
      setState(() {
        zoosToDisplay.clear();
        zoosToDisplay.addAll(listData);
      });
      return;
    } else {
      setState(() {
        zoosToDisplay.clear();
        zoosToDisplay.addAll(zoos);
      });
    }
  }

  initState() {
    super.initState();
    _getZoos();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zoo List"),
      ),
      drawer: new SideNav(
        currentPage: 'zoos',
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: zoosToDisplay.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(zoosToDisplay[index].name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ZooScreen(zoo: zoosToDisplay[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

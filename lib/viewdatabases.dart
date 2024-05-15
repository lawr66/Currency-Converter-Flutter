import 'package:flutter/material.dart';
import 'package:currency_converter/viewcurrencies.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'globals.dart' as globals;

class ViewDatabases extends StatefulWidget {
  final List<String> databases;

  ViewDatabases(this.databases);

  @override
  ViewDatabasesState createState() => ViewDatabasesState();
}

class ViewDatabasesState extends State<ViewDatabases> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text('Databases'),
      ),
      body: ListView.builder(
        itemCount: widget.databases.length,
        itemBuilder: (context, index) {
          final databaseName = widget.databases[index];
          return Card(
            color: Colors.blueGrey,
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewCurrencies(databaseName),
                  ),
                );
              },
              title: Text(
                databaseName,
                style: TextStyle(color: Colors.white),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.play_arrow),
                    color: Colors.white,
                    onPressed: () {
                      _useDatabase(databaseName);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.white,
                    onPressed: () {
                      _deleteDatabase(databaseName);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _useDatabase(String databaseName) async {
    globals.currentBox.close();

    globals.currentBox = await Hive.openBox(databaseName);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Using database "$databaseName"'),
      ),
    );
  }


  Future<void> _deleteDatabase(String databaseName) async {
    try {
      final bool isOpenBox = Hive.isBoxOpen(databaseName);

      if (isOpenBox) {
        await Hive.close();
      }

      final keys = globals.allBoxes.keys.toList();
      int deleteIndex = -1;
      for (final key in keys) {
        final _allBox = globals.allBoxes.get(key);
        if (_allBox!.name == databaseName) {
          deleteIndex = key;
          await globals.allBoxes.delete(key);
          break;
        }
      }


      await Hive.deleteBoxFromDisk(databaseName);

      setState(() {
        widget.databases.remove(databaseName);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Database "$databaseName" deleted'),
        ),
      );

      if (isOpenBox) {
        final int currentBoxIndex = keys[keys.length - 1];
        if (currentBoxIndex == deleteIndex) {
          final previousIndex = keys.length > 1 ? keys[keys.length - 2] : null;
          if (previousIndex != null) {
            final previousDatabaseName = globals.allBoxes
                .get(previousIndex)!
                .name;
            globals.currentBox = await Hive.openBox(previousDatabaseName);
          }
        }
      }
    }
    catch (e) {
      print('Error deleting database: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting database "$databaseName"'),
        ),
      );
    }
  }


}
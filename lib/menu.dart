import 'package:flutter/material.dart';
import 'package:currency_converter/convertbuy.dart';
import 'package:currency_converter/viewdatabases.dart';
import 'about.dart';
import 'allboxes.dart';
import 'convertsell.dart';
import 'globals.dart' as globals;

class Menu extends StatelessWidget {
  const Menu({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[300],
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome to Currency Converter!\nPlease choose an acction from the menu below: ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConvertBuy()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen[300],
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                minimumSize: Size(220,50),
              ),
              child: Text('Convert BUY', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConvertSell()),
                );

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[200],
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                minimumSize: Size(220,50),
              ),
              child: Text('Convert SELL', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                var _allBoxes = globals.allBoxes.values.toList().reversed;
                List<String> _boxes = <String>[];

                for (AllBoxes allBox in _allBoxes)
                  {
                    _boxes.add(allBox.name);
                  }


                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewDatabases(_boxes),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[200],
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                minimumSize: Size(220,50),
              ),
              child: Text('View databases', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => About(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellowAccent[100],
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                minimumSize: Size(220,50),
              ),
              child: Text('About', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

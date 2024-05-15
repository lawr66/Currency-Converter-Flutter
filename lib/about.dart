import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Container(
        color: Colors.indigoAccent[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Text(
          'Currency Converter',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        ),
        SizedBox(height: 20),
            Text(
              'Version 1.5',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to the Currency Converter App! \n This app uses data from a website to convert your desired amount from one currency to another.'
                  '\nYou can see the available currencies in the conversion screens.\nYou can also view the currencies\' values at the different times the app has ran,'
                  'and even choose to use these values or delete them.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 80),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreenAccent[100]),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Back to menu',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
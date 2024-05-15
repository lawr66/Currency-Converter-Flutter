import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'allboxes.dart';
import 'currency.dart';
import 'menu.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'globals.dart' as globals;

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    GetCurrencies();

    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => Menu(
                  title: 'Currency Convereter',
                )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/currencies.png'),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Future<void> GetCurrencies() async {
    await Hive.initFlutter('boxes');
    Hive.registerAdapter(CurrencyAdapter());
    Hive.registerAdapter(AllBoxesAdapter());
    DateTime now = DateTime.now();
    globals.allBoxes = await Hive.openBox<AllBoxes>('AllBoxes');
    var box = await Hive.openBox<Currency>(now.toString());
    int lastBoxId = globals.allBoxes.keys.toList().last + 1;

    try {
      final url = Uri.parse('https://www.luxor-exchange.ro/arad');

      final response = await http.get(url);
      dom.Document html = dom.Document.html(response.body);

      final abbreviations = html
          .querySelectorAll('td.nowrap > strong')
          .map((element) => element.innerHtml.trim())
          .toList();

      var cAbbs = <String>[];

      for (final abbreviation in abbreviations) {
        cAbbs.add(abbreviation);
      }

      final names = html
          .querySelectorAll('td.nowrap > span.is-hidden-mobile')
          .map((element) => element.innerHtml.trim())
          .toList();

      var cNames = <String>[];

      for (final name in names) {
        cNames.add(name.replaceAll('- ', ''));
      }

      final values = html
          .querySelectorAll('td.has-text-right-mobile')
          .map((element) => element.innerHtml.trim())
          .toList();

      var cValues = <String>[];

      for (final value in values) {
        cValues.add(value);
      }

      var cBuyValues = <double>[];
      var cSellValues = <double>[];

      for (int i = 0; i < cValues.length; i++) {
        if (i % 2 == 0)
          cBuyValues.add(double.parse(
              cValues[i].replaceAll("Lei", "").replaceAll(',', '.')));
        else
          cSellValues.add(double.parse(
              cValues[i].replaceAll("Lei", "").replaceAll(',', '.')));
      }

      for (int i = 0; i < cAbbs.length; i++) {
        box.put(
            cAbbs[i],
            Currency(
                abbreviation: abbreviations[i],
                name: cNames[i],
                buyValue: cBuyValues[i],
                sellValue: cSellValues[i]));
      }

      box.put(
          'RON',
          Currency(
              abbreviation: 'RON',
              name: 'Leu Romanesc',
              buyValue: 1,
              sellValue: 1));

      globals.allBoxes.put(lastBoxId, AllBoxes(name: now.toString()));
      globals.currentBox = box;
    } on Exception catch (e) {
      print('Exception: $e');
      globals.allBoxes.delete(lastBoxId);
      box.close();
      box.deleteFromDisk();

      lastBoxId = lastBoxId - 1;
      globals.currentBox =
          await Hive.openBox(globals.allBoxes.get(lastBoxId)!.name);
    } finally {}
  }
}

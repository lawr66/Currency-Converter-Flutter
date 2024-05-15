import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class ConvertBuy extends StatefulWidget {
@override
_ConvertBuyState createState() => _ConvertBuyState();
}

class _ConvertBuyState extends State<ConvertBuy> {
  final List<String> dropdownValues = List<String>.from(globals.currentBox.keys.toList());
  late String selectedValue1;
  late String selectedValue2;
  double inputValue = 0.0;
  String resultText = '';

  @override
  void initState() {
    super.initState();
    selectedValue1 = dropdownValues.isNotEmpty ? dropdownValues.first : '';
    selectedValue2 = dropdownValues.isNotEmpty ? dropdownValues.first : '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightGreen[300],
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Convert buy'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Convert with buy values',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 80.0),
              Container(
                width: 200.0,
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70 ,
                    hintText: 'Enter value to convert',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      inputValue = double.tryParse(value) ?? 0.0;
                    });
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'From',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              Container(
                color: Colors.white54,
                width: 200.0,
                child: DropdownButton<String>(
                  value: selectedValue1,
                  underline: Container(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue1 = value!;
                    });
                  },
                  items: dropdownValues.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'To',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              Container(
                color: Colors.white60,
                width: 200.0,
                child: DropdownButton<String>(
                  value: selectedValue2,
                  underline: Container(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue2 = value!;
                    });
                  },
                  items: dropdownValues.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 50.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 50),
                  backgroundColor: Colors.greenAccent[100],
                ),
                onPressed: () {
                  setState(() {
                    double valueFrom = !globals.currentBox.get(selectedValue1).name.contains('100') ?
                    globals.currentBox.get(selectedValue1).buyValue : globals.currentBox.get(selectedValue1).buyValue / 100;

                    double valueTo = !globals.currentBox.get(selectedValue2).name.contains('100') ?
                    globals.currentBox.get(selectedValue2).buyValue : globals.currentBox.get(selectedValue2).buyValue / 100;

                    resultText = 'Result: ${inputValue *
                    valueFrom / valueTo}';
                  });},
                child: Text('Convert',
                    style: TextStyle(fontSize: 20),),
              ),
              SizedBox(height: 40.0),
              Text(
                resultText,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:currency_converter/currency.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'globals.dart' as globals;

class ViewCurrencies extends StatelessWidget {
  final String databaseName;

  ViewCurrencies(this.databaseName);

  Future<Box<dynamic>> openBox() async {
    if (!Hive.isBoxOpen(databaseName)) {
      return await Hive.openBox(databaseName);
    } else {
      return globals.currentBox;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Flexible(
              child: Text(
                'Details from: $databaseName',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: openBox(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Box<dynamic> box = snapshot.data as Box<dynamic>;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  columns: [
                    DataColumn(
                        label: Text(
                      'Abbreviation',
                      style: TextStyle(color: Colors.blueGrey),
                    )),
                    DataColumn(
                        label: Text(
                      'Full Name',
                      style: TextStyle(color: Colors.blue),
                    )),
                    DataColumn(
                        label: Text(
                      'Buy value',
                      style: TextStyle(color: Colors.green),
                    )),
                    DataColumn(
                        label: Text(
                      'Sell value',
                      style: TextStyle(color: Colors.redAccent),
                    )),
                  ],
                  rows: List<DataRow>.generate(
                    box.length,
                    (index) {
                      Currency record = box.getAt(index);
                      return DataRow(
                        cells: [
                          DataCell(
                            Container(
                              color: Colors.blueGrey.withOpacity(0.1),
                              child: Text(
                                record?.abbreviation ?? '',
                                style: TextStyle(
                                    color: Colors.blueGrey),
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              color: Colors.blue.withOpacity(0.1),
                              child: Text(
                                record?.name ?? '',
                                style:
                                    TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              color: Colors.green.withOpacity(0.1),
                              child: Text(
                                record!.buyValue!.toString() + ' RON' ?? '',
                                style: TextStyle(
                                    color: Colors.green),
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              color: Colors.red.withOpacity(0.1),
                              child: Text(
                                record!.sellValue!.toString() + ' RON' ?? '',
                                style:
                                    TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

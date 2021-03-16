import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.black38,
            primary: Colors.white,
            elevation: 3,
            textStyle: TextStyle(fontSize: 21),
          ),
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Colors.black,
            fontSize: 23,
          ),
        ),
      ),
      home: MyCurrencyTickerApp(),
    ),
  );
}

class MyCurrencyTickerApp extends StatefulWidget {
  @override
  _MyCurrencyTickerAppState createState() => _MyCurrencyTickerAppState();
}

class _MyCurrencyTickerAppState extends State<MyCurrencyTickerApp> {
  String currency1 = 'USD';
  String currency2 = 'USD';
  double exchangeRate = 0;
  var numberFormater = NumberFormat('###,###,###.##');

  List<Text> pickerItems = [];

  final List<String> currencyList = [
    'USD',
    'EUR',
    'GBP',
    'RUB',
    'CAD',
    'BTC',
    'ETH',
    'LTC',
  ];

  Future<void> getExRate() async {
    const apiKey = '671371366ba32939d7dd';
    var returnData;

    Uri url = Uri.https('free.currconv.com', '/api/v7/convert',
        {'apiKey': apiKey, 'q': '${currency1}_$currency2'});

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      returnData = jsonDecode(response.body);
      exchangeRate = returnData['results']['${currency1}_$currency2']['val'];
    }
  }

  @override
  Widget build(BuildContext context) {
    // generating list for cupertinopicker
    pickerItems.clear();
    currencyList.forEach((element) {
      pickerItems.add(Text(element));
    });

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CupertinoPicker(
                        itemExtent: 32,
                        onSelectedItemChanged: (selectedIndex) async {
                          setState(() {
                            currency1 = currencyList[selectedIndex];
                          });
                        },
                        children: pickerItems),
                  ),
                  Text('>'),
                  Expanded(
                    child: CupertinoPicker(
                        itemExtent: 32,
                        onSelectedItemChanged: (selectedIndex) async {
                          setState(() {
                            currency2 = currencyList[selectedIndex];
                          });
                        },
                        children: pickerItems),
                  ),
                ],
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextButton(
                onPressed: () async {
                  if (currency1.length > 0 &&
                      currency2.length > 0 &&
                      currency1 != currency2) {
                    await getExRate();
                  } else {
                    exchangeRate = 0;
                  }
                  setState(() {});
                },
                child: Text('Get Rate'),
              ),
            ),
          ),
          Expanded(
            child: Text(
              numberFormater.format(exchangeRate),
              style: TextStyle(fontSize: 37),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

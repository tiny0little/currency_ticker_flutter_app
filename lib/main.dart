import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const apiKey = '671371366ba32939d7dd';
// https://free.currconv.com/api/v7/convert?q=USD_PHP&compact=ultra&apiKey=671371366ba32939d7dd
// max number of requests per hour: 100

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Colors.black,
            fontSize: 23,
            // fontWeight: FontWeight.bold,
            // fontFamily: 'PoiretOne',
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
  String currency1 = '';
  String currency2 = '';
  double exchangeRate = 0;

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
                        onSelectedItemChanged: (selectedIndex) {
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
                        onSelectedItemChanged: (selectedIndex) {
                          setState(() {
                            currency2 = currencyList[selectedIndex];
                          });
                        },
                        children: pickerItems),
                  ),
                ],
              )),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Text(currency1, textAlign: TextAlign.center),
                ),
                Text('>'),
                Expanded(
                  child: Text(currency2, textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              exchangeRate.toString(),
              style: TextStyle(fontSize: 37),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

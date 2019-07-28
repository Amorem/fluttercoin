import 'package:bitcoin_ticker/services/bitcoin.dart';
import 'package:flutter/material.dart';
import "coin_data.dart";
import 'package:flutter/cupertino.dart';
import "dart:io" show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  BitCoin bitcoin = BitCoin();
  String selectedCurrency = "USD";
  int bitcoinPrice;
  int etheriumPrice;
  int litecoinPrice;

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      dropDownItems.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() => selectedCurrency = value);
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> cupertinoItems = [];
    for (String currency in currenciesList) {
      cupertinoItems.add(Text(currency));
    }
    return (CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
        var res = await bitcoin.getQuote(currenciesList[selectedIndex]);
        setState(() => {
              selectedCurrency = currenciesList[selectedIndex],
              bitcoinPrice = res['last'].toInt()
            });
      },
      children: cupertinoItems,
      backgroundColor: Colors.lightBlue,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitcoinPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iOSPicker() : androidDropdown())
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcointicker/coin_data.dart';
import 'dart:io' show Platform;

import 'package:flutter/services.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];
  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];
    for (String item in currenciesList) {
      pickerItems.add(Text(
        item,
        style: TextStyle(color: Colors.white),
      ));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 40.0,
      onSelectedItemChanged: (index) {
        print(index);
      },
      children: pickerItems,
    );
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownMenu = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownMenu.add(item);
    }

    return DropdownButton<String> (
        value: selectedCurrency,
        items: dropDownMenu,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Ticker'),
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
                  '1 BTC = ? USD',
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
            height: 170.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

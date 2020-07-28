import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcointicker/coin_data.dart';
import 'dart:io' show Platform;


class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  @override
  void initState() {
    super.initState();
    getRate();
  }

  String selectedCurrency = currenciesList[0];
  String rate = '?';
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
        selectedCurrency = currenciesList[index];
        getRate();
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
            getRate();
          });
        });
  }
  Map<String,String> coinValues = {};
  bool isWaiting = false;
  void getRate() async{
    isWaiting = true;
    try{
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch(e) {
      print(e);
    }

  }

  Column makeCard(){
    List<CryptoCard> cryptoCardList = [];
    for(String crypt in cryptoList){
     var output = CryptoCard(crypto: crypt,rate: isWaiting ? '?' : coinValues[crypt],selectedCurrency: selectedCurrency);
     cryptoCardList.add(output);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCardList,
    );
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
          makeCard(),
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

class CryptoCard extends StatelessWidget {

  CryptoCard({this.crypto,this.rate,this.selectedCurrency});

  final String crypto;
  final String rate;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            '1 $crypto = $rate $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}


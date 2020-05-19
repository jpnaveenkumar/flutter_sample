import 'package:flutter/material.dart';
import 'page4.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class pageStateful3 extends StatefulWidget{
  @override
  page3 createState(){
    return page3();
  }
}

class page3 extends State<pageStateful3>{

  String _text = null;
  List newCarList = new List();
  List usedCarList = new List();

  updateString(data){
    setState(() {
      _text = data;
    });
  }

  getData() async{
    final response = await http.get('https://io.ucars.sg/UCars/ui/main/getMostViewCar?_=1587046226578');
    var responseBody = jsonDecode(response.body);
    setState(() {
      newCarList = jsonDecode(response.body)["data"]["mostViewNewCarList"];
      usedCarList = jsonDecode(response.body)["data"]["mostViewUsedCarList"];
    });
  }

  @override
  void initState(){
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext buildContext){
    return Scaffold(
      appBar: AppBar(
        title: Text("Third Screen"),
      ),
      body: OrientationBuilder(
        builder: (context,orientation){
          return Orientation.portrait == orientation ? Container(
            child: pageList(changeText: updateString,carData: newCarList),
          )
              : Row(
            children: <Widget>[
             Expanded(
               child: pageList(changeText: updateString,testData: "naveen",carData: newCarList),
             ),
              Container(
                width: 150,
                child: _text == null ? Text("no Image Found") : Image.network(_text)
              )
            ],
          );
        },
      )
    );
  }
}
import 'package:flutter/material.dart';

typedef returnString = void Function(String data);
class pageList extends StatelessWidget{
  pageList({this.changeText,this.testData,this.carData});

  List carData;
  String testData;
  returnString changeText;
  List<String> names = ["java","kotlin","swift","flutter","java","kotlin","swift","flutter","java","kotlin","swift","flutter"];

  Widget build(BuildContext buildContext){
    return ListView.builder(
      itemCount: carData.length,
      itemBuilder: (context,index){
        return GestureDetector(
          onTap: (){
            changeText(carData[index]["picPath"].substring(0,4)+carData[index]["picPath"].substring(5));
          },
          child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10,0),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(carData[index]["picPath"].substring(0,4)+carData[index]["picPath"].substring(5)),
                            //whatever image you can put here
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: Center(child: Text(carData[index]["productTitle"],softWrap: true,textAlign: TextAlign.center,),)
                      )
                    ],
                  ),
                ),
              )
          ),
        );
      },
    );
  }
}
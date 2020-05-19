import 'package:flutter/material.dart';
import 'page2.dart';
class page2 extends StatelessWidget{

  @override
  Widget build(BuildContext buildContext){
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: Builder(
          builder: (BuildContext context1){
            return FloatingActionButton(
              child: Icon(Icons.add_a_photo),
              onPressed: (){
                Scaffold.of(context1).showSnackBar(
                  new SnackBar(content: Text("Floating button clicked"))
                );
              },
            );
          },
        ),
        appBar: AppBar(
          title: Text("Second Screen"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.memory),
              onPressed: (){

              },
            ),
            IconButton(
              icon: Icon(Icons.account_balance_wallet),
              onPressed: (){

              },
            )
          ],
          bottom: TabBar(
            labelPadding: EdgeInsets.all(15),
            tabs: <Widget>[
              Text(
                  "First Tab",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )
              ),
              Text(
                  "Second Tab",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decorationStyle: TextDecorationStyle.wavy,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1
                    ..color = Colors.white
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(buildContext).size.height,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text("This is second screen"),
                  ]
              ),
            ),
            Container(
              height: MediaQuery.of(buildContext).size.height,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    RaisedButton(
                      child: Text("move to page3"),
                      onPressed: (){
                        Navigator.pushNamed(buildContext,'/page3');
                      },
                    )
                  ]
              ),
            )
          ],
        )
      ),
    ) ;
  }
}


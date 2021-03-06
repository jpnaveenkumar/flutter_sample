import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uni_links/uni_links.dart';
import 'components/page1.dart';
import 'components/page2.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() {
  //HttpOverrides.global = new MyHttpOverrides();
  runApp(Sample());
}
class First extends StatefulWidget{

  @override
  Second createState() {
    return Second();
  }

}
class Second extends State<First>{
  int _number=1;
  void increment(){
    setState(() {
      _number++;
    });
  }
   Widget build(BuildContext context){
     return Container(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           Text("naveen"),
           RaisedButton(
             onPressed: increment,
             child: Text(_number.toString()),
           )
         ],
       ),
     );
   }
}
class page extends StatelessWidget{

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  getInitialLink(BuildContext buildContext) async
  {
    try {
      Uri initialUri = await getInitialUri();
      print(initialUri);
      Fluttertoast.showToast(
          msg: initialUri.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      if(initialUri != null){
        var list = initialUri.queryParametersAll.entries.toList();
        Future.delayed(Duration.zero,(){
          Navigator.pushNamed(buildContext, '/page2');
        });
      }
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context){

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message){
        print(message);
      },
      onResume: (Map<String, dynamic> message){
        print(message);
      },
      onLaunch: (Map<String, dynamic> message) {
        print(message);
      }
    );

    firebaseMessaging.getToken().then((value){
      print("token : "+value);
    });

    //getInitialLink();

    return  Scaffold(
        appBar: AppBar(
          title: Text("NaveenKumar"),
        ),
        body: StreamBuilder(
          stream: getLinksStream(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              var uri = Uri.parse(snapshot.data);
              print(uri);
              var list =uri.queryParametersAll.entries.toList();
              print(list);
              Fluttertoast.showToast(
                  msg: uri.toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              Future.delayed(Duration.zero,(){
                Navigator.pushNamed(context, '/page2');
              });
            }else{
              print(snapshot.error);
              try{
                getInitialLink(context);
              }catch(ex){

              }
            }
            return Builder(
                builder: (BuildContext context1) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GestureDetector(
                onVerticalDragStart: (details){
                    final snackBar = SnackBar(content: Text('swiped right'));
                    Scaffold.of(context1).showSnackBar(snackBar);
                    Navigator.pushNamed(context,'/page2');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      margin: new EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.amber
                      ),
                    ),
                    Container(
                      margin: new EdgeInsets.all(10),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.amber
                      ),
                    ),
                    First()
                  ],
                ),
              ),
            )
            );
          }
        )
    );
  }
}
class Sample extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "demo",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      routes: {
        '/' : (context) => page(),
        '/page2': (context) => page2(),
        '/page3' : (context) => pageStateful3()
      },
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepOrange,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Row(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment : MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.amber
              ),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.amber
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

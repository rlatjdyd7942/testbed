import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:testbed/famous_saying_factory.dart';
import 'package:testbed/my_color.dart';

import 'famous_saying.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
  runApp(FamousSayingApp());
}

class FamousSayingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: primaryBlack,
        scaffoldBackgroundColor: Color(0xffd7e89f)
      ),
      home: FamousSayingPage(),
      debugShowCheckedModeBanner: false
    );
  }
}

class FamousSayingPage extends StatefulWidget {
  @override
  _FamousSayingPageState createState() => _FamousSayingPageState();
}

class _FamousSayingPageState extends State<FamousSayingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: FamousSayingFactory.instance.create(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                FamousSaying fs = snapshot.data;
                print(fs.phrase);
                return Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text("오늘의 명언",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 50),
                  fs,
                  SizedBox(height: 50),
                  OutlineButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      borderSide: BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.share, color: Colors.black),
                        Text("공유하기",
                            style: TextStyle(fontSize: 16, color: Colors.black))
                      ]),
                      onPressed: () {
                        Share.share(fs.getShareString());
                      }),
                  SizedBox(height: 50)
                ]));
              } else {
                return Container();
              }
            }));
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
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

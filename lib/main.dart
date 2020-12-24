import 'package:flutter/material.dart';
import 'package:share/share.dart';

void main() {
  runApp(FamousSayingApp());
}

class FamousSayingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFF3366FF),
                  const Color(0xFF00CCFF),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
              Column(mainAxisSize: MainAxisSize.min, children: [
                Text('유명해지려면 똥을 싸라',
                    style: TextStyle(fontSize: 32, color: Colors.white)),
                Text('by 개소리',
                    style: TextStyle(fontSize: 20, color: Colors.white))
              ]),
              SizedBox(height: 50),
              OutlineButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  borderSide: BorderSide(
                      color: Colors.white, style: BorderStyle.solid, width: 1),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.share, color: Colors.white),
                    Text("공유하기", style: TextStyle(fontSize: 20, color: Colors.white))
                  ]),
                  onPressed: () {
                    Share.share("유명해지려면 똥을 싸라 by 개소리");
                  })
            ])))
        /*child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Text('유명해지려면 똥을 싸라',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontSize: 32, color: Colors.white)),
              Text('by 개소리',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontSize: 20, color: Colors.white))
            ]),
            Container(
                child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Expanded(
                  child: Text('by 개소리',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 10, color: Colors.white)))
            ]))
          ],
        ))*/
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

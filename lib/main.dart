import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:testbed/famous_saying_factory.dart';
import 'package:testbed/my_color.dart';
import 'package:admob_flutter/admob_flutter.dart';

import 'famous_saying.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  runApp(FamousSayingApp());
}

class FamousSayingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: primaryBlack,
            scaffoldBackgroundColor: Color(0xffd7e89f)),
        home: FamousSayingPage(),
        debugShowCheckedModeBanner: false);
  }
}

class FamousSayingPage extends StatefulWidget {
  @override
  _FamousSayingPageState createState() => _FamousSayingPageState();
}

class _FamousSayingPageState extends State<FamousSayingPage> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  AdmobBannerSize bannerSize;

  @override
  void initState() {
    super.initState();
    bannerSize = AdmobBannerSize.BANNER;
  }

  void showSnackBar(String content) {
    scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        showSnackBar('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        showSnackBar('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        showSnackBar('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        showSnackBar('Admob $adType failed to load. :(');
        break;
      case AdmobAdEvent.rewarded:
        showDialog(
          context: scaffoldState.currentContext,
          builder: (BuildContext context) {
            return WillPopScope(
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Reward callback fired. Thanks Andrew!'),
                    Text('Type: ${args['type']}'),
                    Text('Amount: ${args['amount']}'),
                  ],
                ),
              ),
              onWillPop: () async {
                scaffoldState.currentState.hideCurrentSnackBar();
                return true;
              },
            );
          },
        );
        break;
      default:
    }
  }


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
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
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
                  Expanded(child: SizedBox()),
                  AdmobBanner(
                    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
                    adSize: bannerSize,
                    listener: (AdmobAdEvent event,
                        Map<String, dynamic> args) {
                      handleEvent(event, args, 'Banner');
                    },
                    onBannerCreated:
                        (AdmobBannerController controller) {
                      // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
                      // Normally you don't need to worry about disposing this yourself, it's handled.
                      // If you need direct access to dispose, this is your guy!
                      // controller.dispose();
                    },
                  ),
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

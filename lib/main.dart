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
            primarySwatch: primaryWhite, scaffoldBackgroundColor: Colors.white),
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
        body: Center(
            child: Container(
              decoration:  BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.yellow[50], Colors.brown[300]])
              ),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          
        ]
      ),
      Expanded(
          child: FutureBuilder(
              future: FamousSayingFactory.instance.create(context),
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return CircularProgressIndicator();
                }
                FamousSaying fs = snapshot.data;
                return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("오늘의 명언",
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold, color: Colors.brown[900])),
                      SizedBox(height: 50),
                      fs,
                      SizedBox(height: 50),
                      ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[300])),
                          onPressed: () {
                            Share.share(fs.getShareString());
                          },
                          child: Text(" 공유하기",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black))),
                    ]);
              })),
      AdmobBanner(
        adUnitId: 'ca-app-pub-3940256099942544/6300978111',
        adSize: bannerSize,
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          handleEvent(event, args, 'Banner');
        },
        onBannerCreated: (AdmobBannerController controller) {
          // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
          // Normally you don't need to worry about disposing this yourself, it's handled.
          // If you need direct access to dispose, this is your guy!
          // controller.dispose();
        },
      ),
    ]))));
  }
}

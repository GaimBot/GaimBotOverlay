import 'package:flutter/material.dart';
import 'package:gamebot_flutter/gaimbotwebview.dart';

import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  Widget build(BuildContext context) {
    getInitialLink().then((String data) {
      // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(data)));
       Navigator.of(context).push(
          MaterialPageRoute( 
            builder: (BuildContext context) {
                  
            return GaimBotWebview(
              selectedUrl: data, // for testing
              title: "GaimBot Overlay",
            );
          }
        )
      );
    });
    return Container();
    /*return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Hehe Text"),
      ),
      body: Center(
        child: FlatButton(
          child: Text("Open Webpage "),
          onPressed: () {
            final snackBar = SnackBar(content: Text("Opening browser"));
            // _scaffoldKey.currentState.showSnackBar(snackBar); // no weorkey
            
            
           
          }
        ),
      ),
    );*/
  }

  

}

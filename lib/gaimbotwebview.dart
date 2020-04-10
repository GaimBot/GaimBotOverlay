import "dart:async";
import "dart:convert";
import "package:flutter/material.dart";
import "package:webview_flutter/webview_flutter.dart";
import 'package:share/share.dart';
import 'package:html_unescape/html_unescape.dart';

class GaimBotWebview extends StatelessWidget {
  final String title;
  final String selectedUrl;

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  GaimBotWebview({
    @required this.title,
    @required this.selectedUrl,
  });

  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(title),
      ),
      body:Center(
        
        child: WebView(
        initialUrl: selectedUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        javascriptChannels: <JavascriptChannel>[
          JavascriptChannel(
            name: "getStateUIUrl", 
            onMessageReceived: (JavascriptMessage message) {
              String jsonString =  message.message;
              var data = json.decode(jsonString);
              String urlRedirect = HtmlUnescape().convert(data['stateUIUrl']); // since html characters in the json :( should probably do this one line above

              _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text(urlRedirect))
              );

              Share.share(urlRedirect); // make this go to JUST DISCORD later for testing
            }
            )
        ].toSet(),
        onPageFinished: (String url) {

            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text(url))
              );
          if (url.startsWith("http://<yougamebotrurl>/tictactoe/getStateUIUrl")) { // replace with regex for any game
            
            _controller.future.then((WebViewController controller) {
              controller.evaluateJavascript("getStateUIUrl.postMessage(document.querySelector('pre').innerHTML)");
            });
          }
        },
      )
      
      
      ,) 
    );
  }
}
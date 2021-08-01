import 'package:deferred_components_test/main.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SecondWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SecondState();
}

class SecondState extends State<SecondWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Column(
        children: [
          Container(
              height: 400,
              child: WebView(
                initialUrl: 'https://www.google.com/',
              )),
          ElevatedButton(
            child: Text('push new stack'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            title: '',
                          )),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'dart:typed_data';

import 'package:deferred_components_test/second_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'deferred_components/books.dart' deferred as books;
import 'deferred_components/en_covers.dart' deferred as en_covers;
import 'deferred_components/id_covers.dart' deferred as id_covers;

void main() {
  runApp(MyApp());
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
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final methodChannel = MethodChannel('test');
  String text = '';
  Uint8List? _imageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(text),
            ElevatedButton(
              child: Text('install book component '),
              onPressed: () async {
                await books.loadLibrary();
                print("Loaded");
                setState(() {
                  text = "Loaded";
                });
              },
            ),
            ElevatedButton(
              child: Text('install cover component '),
              onPressed: () async {
                await en_covers.loadLibrary();
                print("Loaded");
                setState(() {
                  text = "Loaded";
                });
              },
            ),
            ElevatedButton(
              child: Text('naviate to other screen'),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondWidget()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Load book deferred asset'),
              onPressed: () async {
                setState(() {
                  _imageData = null;
                });
                final data = (await rootBundle
                    .load("deferred_assets/books/vancouver.jpg"));

                setState(() {
                  _imageData = data.buffer
                      .asUint8List(data.offsetInBytes, data.lengthInBytes);
                });
              },
            ),
            ElevatedButton(
              child: Text('Load cover deferred asset'),
              onPressed: () async {
                setState(() {
                  _imageData = null;
                });
                final data =
                    (await rootBundle.load("deferred_assets/enCovers/x.jpg"));

                setState(() {
                  _imageData = data.buffer
                      .asUint8List(data.offsetInBytes, data.lengthInBytes);
                });
              },
            ),
            _imageData != null
                ? Container(
                    width: 200,
                    height: 200,
                    child: Image.memory(
                      _imageData!,
                      fit: BoxFit.contain,
                    ))
                : Container()
          ],
        ),
      ),
    );
  }
}

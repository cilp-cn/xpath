import 'package:flutter/material.dart';
import 'package:xpath/xpath.dart';

import 'html.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            TextButton(
              onPressed: () async {
                var html = await Xpath.parse(content);
                print(html);
              },
              child: Text('Parse'),
            ),
            TextButton(
              onPressed: () async {
                var html =
                    await Xpath.parseString("//div[@class='info']/h2/text()");
                print(html);
              },
              child: Text('ParseString'),
            ),
            TextButton(
              onPressed: () async {
                var html = await Xpath.parseList(
                    "//div[@class='listmain']/dl/dd/a/text()");
                print(html);
              },
              child: Text('ParseList'),
            ),
            TextButton(
              onPressed: () async {
                var html = await Xpath.parseList(
                    "//div[@class='listmain']/dl/dd/a/@href");
                print(html);
              },
              child: Text('ParseList href'),
            ),
            TextButton(
              onPressed: () async {
                var html = await Xpath.parseListTitleAndHref(
                    "//div[@class='listmain']/dl/dd/a");
                print(html);
              },
              child: Text('ParseList title href'),
            ),
          ],
        ),
      ),
    );
  }
}

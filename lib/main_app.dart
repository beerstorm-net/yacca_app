import 'package:flutter/material.dart';

import 'pages/main_page.dart';

class MainApp extends StatefulWidget {
  MainApp({Key key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yet Another Cryptocurrency App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(title: 'Yet Another Cryptocurrency App'),
    );
  }
  // TODO: introduce Auth and AuthBloc, implement MainApp and related pages
}

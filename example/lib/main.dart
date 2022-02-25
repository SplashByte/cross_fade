import 'dart:async';

import 'package:cross_fade/cross_fade.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List _objects = const [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  final List<Widget> _icons = const [
    Icon(
      Icons.cancel,
      size: 150.0,
    ),
    Icon(
      Icons.check_circle,
      size: 150.0,
    ),
    Icon(
      Icons.camera_rounded,
      size: 150.0,
    ),
  ];
  final List<Widget> _widgets = [
    Container(
      color: Colors.blue,
      width: 150.0,
      height: 150.0,
      child: const Center(child: Text('Any widget')),
    ),
    Container(
      color: Colors.red,
      height: 100.0,
      width: 200,
      child: const Center(child: Text('Any other widget')),
    ),
    Container(
      color: Colors.green,
      height: 50.0,
      width: 300.0,
      child: const Center(child: Text('Any other other widget')),
    ),
  ];
  int _index = 0;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
        const Duration(milliseconds: 1500), (t) => setState(() => _index++));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.red,
              child: CrossFade(
                value: _objects[_index % _objects.length],
                builder: (context, i) => Text(
                  '$i',
                  style: theme.textTheme.headline1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Center(
            child: CrossFade(
              value: _objects[_index % _objects.length],
              builder: (context, i) => Text(
                '$i',
                style: theme.textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Center(
            child: DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(border: Border.all(width: 3.0)),
              child: CrossFade<int>(
                value: _index,
                builder: (context, i) => _widgets[i % _widgets.length],
              ),
            ),
          ),
          Center(
            child: CrossFade<int>(
              value: _index,
              builder: (context, i) => _icons[i % _icons.length],
            ),
          ),
          Center(
            child: CrossFade(
              value: _objects[_index % _objects.length],
              builder: (context, i) => Text(
                '$i',
                style: theme.textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              highlightTransition: (o1, o2) => true,
            ),
          ),
        ],
      ),
    );
  }
}
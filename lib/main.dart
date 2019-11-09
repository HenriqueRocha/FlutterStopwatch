import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Stopwatch'),
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
  final Stopwatch stopwatch = Stopwatch();

  IconData icon = Icons.play_arrow;
  Timer timer;

  void startPausePressed() {
    if (stopwatch.isRunning) {
      pause();
    } else {
      start();
    }
  }

  void start() {
    stopwatch.start();
    timer = Timer.periodic(Duration(seconds: 1), tick);

    setState(() {
      icon = Icons.pause;
    });
  }

  void pause() {
    stopwatch.stop();
    timer.cancel();

    setState(() {
      icon = Icons.play_arrow;
    });
  }

  void tick(Timer timer) {
    setState(() {});
  }

  String format(int seconds) {
    int minutes = seconds ~/ 60;
    seconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}" +
        ":${seconds.toString().padLeft(2, '0')}";
  }

  void resetPressed() {
    if (stopwatch.isRunning) {
      pause();
    }
    stopwatch.reset();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  '${format(stopwatch.elapsed.inSeconds)}',
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(onPressed: resetPressed, child: Text("Reset")),
                  FloatingActionButton(
                    onPressed: startPausePressed,
                    tooltip: 'Start',
                    child: Icon(icon),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

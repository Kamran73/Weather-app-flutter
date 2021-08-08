import 'package:flutter/material.dart';
import 'services/loading_location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'userInterface/HomeScreen.dart';

var weatherInfo;

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Weather',
      routes: {
        '/': (context) => Home(),
        '/homeScreen': (context) => HomeScreen(data: weatherInfo),
      },
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    data();
  }

  void data() async {
    weatherInfo = await GetLocation().getLocation();
    Navigator.pushNamed(
      context,
      '/homeScreen',
    );
  }

  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      body: Center(
        child:
            //Text('We are in splash screen'),
            SpinKitFadingCircle(
          color: Colors.white60,
          size: 100.0,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:weather_app/services/loading_location.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({this.data});

  final data;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int temperature;
  String cityName;
  String iconData;
  String message;

  void getMessage() {
    if (temperature > 25) {
      message = 'It\'s 🍦 time';
    } else if (temperature > 20) {
      message = 'Time for shorts and 👕';
    } else if (temperature < 10) {
      message = 'You\'ll need 🧣 and 🧤';
    } else {
      message = 'Bring a 🧥 just in case';
    }
    print(message);
  }

  void updateUI(dynamic data) {
    print(data);
    if (data == null) {
      temperature = null;
      cityName = null;
      iconData = null;
      return ;
    }
    double temp = (data)['main']['temp'];
    temperature = temp.toInt();
    cityName = (data)['name'];
    String icon = (data)["weather"][0]["icon"];
    icon = icon + '@2x.png';
    print(icon);
    iconData = "https://openweathermap.org/img/wn/" + "$icon";
    getMessage();
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.data);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/location_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop)),
        ),
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 15, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      '$cityName',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.refresh_outlined,
                        size: 50,
                      ),
                      onPressed: () async{
                        var weatherInfo = await GetLocation().getLocation();
                        setState(() {
                          updateUI(weatherInfo);
                        });
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Text(
                    '$temperature°',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 80,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.only(left: 7.0),
                    child: Image(
                      image: NetworkImage(iconData),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:15.0, right:10),
              child: Text(
                '$message',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 75,
                ),
                textAlign: TextAlign.end,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}

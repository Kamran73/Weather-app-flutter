import 'package:geolocator/geolocator.dart';
import 'loading_weather.dart';

class GetLocation {
  double latitude;
  double longitude;

  Future<dynamic> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      GetWeatherData data = GetWeatherData(
          url:
              'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=bcf55f56460d10dd7f2d2a11b3fa83c5&units=metric');
      return data.weatherData();
    } catch (e) {
      print(e);
    }
  }
}

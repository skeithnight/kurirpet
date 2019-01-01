import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_controller.dart';
import 'package:kurirpet/model/courier_model.dart';
import 'package:kurirpet/data.dart' as data1;

class LocationController {
  Dio dio = new Dio();

  void checkPermission() async {
    Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
    GeolocationStatus geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();
    print(geolocationStatus);
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
  }

  void streamLocation() {
    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 5);

    StreamSubscription<Position> positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position _position) {
      if (_position != null) {
        saveLocation(_position);
      }
    });
  }

  saveLocation(Position position) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Courier car =
          new Courier.fromSnapshot(json.decode(prefs.getString('data')));
      car.latitude = position.latitude;
      car.longitude = position.longitude;
      // print(car.roles);
      dio.options.headers = {
        "Authorization": "Bearer " + prefs.getString('token') ?? ''
      };
      var response =
          await dio.post(data1.urlCourier + "/update", data: car.toJsonData());
      print(response.statusCode);
      LoginController(null).checkSession();
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      print(e.message);
    }
  }

  saveTestLocation() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      Courier car =
          new Courier.fromSnapshot(json.decode(prefs.getString('data')));
      car.latitude = -6.929181;
      car.longitude = 107.611448;
      dio.options.headers = {
        "Authorization": "Bearer " + prefs.getString('token') ?? ''
      };
      var response =
          await dio.post(data1.urlCourier + "/update", data: car.toJsonData());
      print(response.statusCode);
      LoginController(null).checkSession();
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      print(e.message);
    }
  }
}

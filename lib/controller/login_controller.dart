import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kurirpet/data.dart' as data1;
import 'package:kurirpet/model/courier_model.dart';
import 'package:kurirpet/screens/widget/dialog_widget.dart';
import 'package:kurirpet/screens/main_screen.dart';
import 'package:kurirpet/screens/authentication/login_page.dart';

class LoginController {
  BuildContext context;
  LoginController(this.context);
  Dio dio = new Dio();
  void sendData(Courier courier) async {
    if (checkData(courier)) {
      var response =
          await dio.post(data1.urlLogin, data: courier.toJsonLogin());
      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setString('token', response.data['token']);
        _prefs.commit();
        DialogWidget(context: context, dismiss: true)
            .tampilDialog("Success", "Success login..", MainScreen());
      } else {
        // If that response was not OK, throw an error.
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => LoginPage())));
        // throw Exception('Failed to load post');
      }
    } else {
      DialogWidget(context: context)
          .tampilDialog("Failed", "The Data cannot empty!", () {});
    }
  }

  bool checkData(Courier courier) {
    if (courier.username == null || courier.password == null) {
      return false;
    }
    return true;
  }

  void logout() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.clear();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => LoginPage())));
    } catch (e) {
      throw (e);
    }
  }

  Future<String> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    checkSession();
    if (prefs.getString('token') == null ||
        prefs.getString('idCourier') == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => LoginPage())));
    } else {}
    return prefs.getString('token');
  }

  Future<Courier> checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dio.options.headers = {
      "Authorization": "Bearer " + prefs.getString('token') ?? ''
    };
    Response response;
    try {
      response = await dio.get(data1.urlCheckSession);
    } on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      print(e.message);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => LoginPage())));
  }
    Courier courier = Courier.fromSnapshot(response.data);
    prefs.setString("idCourier", courier.id);
    prefs.commit();
    return courier;
  }
}

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kurirpet/data.dart' as data1;
import 'package:kurirpet/model/courier_model.dart';
import 'package:kurirpet/screens/widget/dialog_widget.dart';
import 'package:kurirpet/screens/main_screen.dart';

class CourierController {
  SharedPreferences prefs;
  BuildContext context;
  CourierController(this.context);
  Dio dio = new Dio();
  Future<String> getToken() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  void randomLokasi(Courier courier, String token) async {
    // print(courier);
    // prefs = await SharedPreferences.getInstance();
    // courier.idPetshop = prefs.getString("idPetshop");
    // // print(json.encode(courier.idPetshop));
    // dio.options.headers = {"Authorization": "Bearer " + token};
    // dio.options.data = courier.toJsonInsert();
    // dio.options.baseUrl = data1.urlCourier;

    // var response = await dio.post(data1.pathCourierRegister);

    // if (response.statusCode == 200) {
    //   // If server returns an OK response, parse the JSON
    //   DialogWidget(context: context, dismiss: true)
    //       .tampilDialog("Success", "Success login..", MainScreen());
    // } else {
    //   // If that response was not OK, throw an error.
    //   DialogWidget(context: context, dismiss: true)
    //       .tampilDialog("Failed", "Error on saving data", () {});
    // }
  }

}

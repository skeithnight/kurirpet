import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderController {
  SharedPreferences prefs;

  BuildContext context;
  OrderController(this.context);

  Dio dio = new Dio();
  // Get Data
  // Future<List<Order>> getListData() async {
  //   prefs = await SharedPreferences.getInstance();
  //   dio.options.headers = {
  //     "Authorization": "Bearer " + prefs.getString('token') ?? ''
  //   };
  //   dio.options.baseUrl = data1.urlCourier;

  //   var response = await dio.get(data1.pathCourierPetshop+'/5c10af71535a234d990b109f');
  //   List<dynamic> map = response.data;
  //   List<Courier> listCourier = new List();
  //   for (var i = 0; i < map.length; i++) {
  //     listCourier.add(Courier.fromSnapshot(map[i]));
  //   }
  //   return listCourier;
  // }
}
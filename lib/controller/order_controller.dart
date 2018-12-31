import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kurirpet/model/order_model.dart';
import 'package:kurirpet/model/courier_model.dart';
import 'package:kurirpet/data.dart' as data1;
import 'package:kurirpet/screens/widget/dialog_widget.dart';
import 'package:kurirpet/main.dart';


class OrderController {
  SharedPreferences prefs;

  BuildContext context;
  OrderController(this.context);

  Dio dio = new Dio();
  // Get Data
  Future<List<Order>> getListData() async {
    // print("aa");
    prefs = await SharedPreferences.getInstance();
    List<Order> listOrder = new List();
    dio.options.headers = {
      "Authorization": "Bearer " + prefs.getString('token') ?? ''
    };
    dio.options.baseUrl = data1.urlOrder;
    try {
      var response = await dio.get('/petshop/${prefs.getString('idPetshop')}');
      List<dynamic> map = response.data;
      // print(response.data);
      for (var i = 0; i < map.length; i++) {
        // print(map[i]["courier"]);
        listOrder.add(Order.fromSnapshot(map[i]));
      }
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      DialogWidget(context: context, dismiss: false)
          .tampilDialog("Failed", e.message, () {});
    }
    return listOrder;
  }

  String getStatus(String status){
    String result = "";
    if(status.toLowerCase() == "waiting"){
      result = "jemput";
    }else if(status.toLowerCase() == "jemput"){
      result = "sampai-petshop";
    }else if(status.toLowerCase() == "selesai-petshop"){
      result = "antar";
    }else if(status.toLowerCase() == "antar"){
      result = "selesai";
    }
    return result;
  }

  void changeStatus(Order order) async {
    if (order != null) {
      try {
        prefs = await SharedPreferences.getInstance();
        if (order.status.toLowerCase() == "antar"){
          order.to = new DateTime.now().millisecondsSinceEpoch;
        }
        // print(order.toJsonChangeStatus(prefs.getString('idCourier'), getStatus(order.status)));
        dio.options.headers = {
          "Authorization": "Bearer " + prefs.getString('token') ?? ''
        };
        var response = await dio.post(data1.urlOrder,
            data: order.toJsonChangeStatus(
                prefs.getString('idCourier'), getStatus(order.status)));
        // If server returns an OK response, parse the JSON
        DialogWidget(context: context, dismiss: true)
            .tampilDialog("Success", "Sukses merubah status", MyApp());
      } on DioError catch (e) {
        // The request was made and the server responded with a status code
        // that falls out of the range of 2xx and is also not 304.
        print(e.message);
        DialogWidget(context: context, dismiss: false)
            .tampilDialog("Failed", e.message, () {});
      }
    } else {
      DialogWidget(context: context, dismiss: false)
          .tampilDialog("Failed", "The Data cannot empty!", () {});
    }
  }
}

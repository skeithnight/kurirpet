import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kurirpet/screens/widget/appbar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

import 'package:kurirpet/controller/order_controller.dart';
import 'package:kurirpet/controller/login_controller.dart';
import 'package:kurirpet/model/order_model.dart';
import 'package:kurirpet/model/courier_model.dart';
import 'detail_order_page.dart';
import 'package:kurirpet/controller/location_controller.dart';

class MainScreen extends StatefulWidget {
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String token;
  SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoginController(context).checkToken();
    LocationController().streamLocation();
  }

  Widget content() {
    return new FutureBuilder<List<Order>>(
      future: OrderController(context).getListData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // print(snapshot.data);
          // return Container();
          return listData(snapshot.data);
        } else if (snapshot.hasError) {
          return new Center(child: Text("${snapshot.error}"));
        }

        return new Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget listData(List<Order> listData) {
    return ListView.builder(
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) => Card(
              elevation: 5.0,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailOrderPage('detail', listData[index])));
                },
                title: Text(listData[index].customer.name),
                subtitle: Text(listData[index].address),
                trailing: listData[index].status == "waiting"
                    ? Icon(Icons.hourglass_empty)
                    : listData[index].status == "jemput" ||
                            listData[index].status == "antar"
                        ? Icon(Icons.directions_car)
                        : listData[index].status == "selesai-petshop"
                            ? Icon(Icons.done)
                            : listData[index].status == "selesai"
                                ? Icon(Icons.done_all)
                                : null,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context).appBar("Daftar Pesanan"),
      // body: content(),
      body: new FutureBuilder<Courier>(
        future: LoginController(context).checkSession(),
        builder: ((context, snapshot) {
          // print(snapshot.data);
          if (snapshot.hasData) {
            // return Container();
            return content();
          } else if (snapshot.hasError) {
            // throw(snapshot.error);
            return new Center(
                child: Container(
              height: 500.0,
              child: Text("${snapshot.error}"),
            ));
          }

          return new Center(child: CircularProgressIndicator());
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () {LocationController().saveTestLocation();},
        tooltip: 'test location',
        child: Icon(Icons.place),
      ),
    );
  }
}

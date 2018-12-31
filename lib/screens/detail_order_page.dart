import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:kurirpet/data.dart' as data1;
import 'package:kurirpet/model/order_model.dart';
import 'package:kurirpet/controller/order_controller.dart';
import 'package:kurirpet/screens/widget/maps_widget.dart';

class DetailOrderPage extends StatefulWidget {
  String level = "detail";
  Order _order = new Order();
  DetailOrderPage(this.level, this._order);
  _DetailOrderPageState createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  final WebSocketChannel channel = IOWebSocketChannel.connect(
      "ws://35.231.59.91:8080/get-ws-Order/5c10af71535a234d990b109f");

  Order order = new Order();
  bool aa = true;
  bool isloading = false;

  var nameEditingController = new TextEditingController();
  var usernameEditingController = new TextEditingController();

  void initState() {
    super.initState();
    setState(() {
      order = widget._order;
      nameEditingController.text = widget._order.customer.name;
    });
  }

  Widget orderContent() => Container(
        padding: EdgeInsets.all(10.0),
        width: double.infinity,
        child: Card(
          elevation: 2.0,
          child: Column(
            children: <Widget>[
              ListTile(
                  title: Text(
                order.customer.name,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              )),
              ListTile(
                title: Text("Alamat"),
                subtitle: Text(order.address),
              ),
              ListTile(
                title: Text("Note"),
                subtitle: Text(order.note),
              ),
              ListTile(
                title: Text("Kurir"),
                subtitle: order.courier == null
                    ? Text("Belum di jemput")
                    : Text(order.courier.name),
              ),
              ListTile(
                title: Text("Pesanan"),
                subtitle: Card(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Grooming Biasa"),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget mapswidget() => new Container(
        padding: EdgeInsets.all(10.0),
        height: 300.0,
        width: double.infinity,
        child: Card(
          elevation: 2.0,
          child: MapsWidget(
            lat: order.latitude != null ? order.latitude : -6.934837,
            lon: order.longitude != null ? order.longitude : 107.620810,
            listMarker: [
              new Marker(
                width: 80.0,
                height: 80.0,
                point: new LatLng(
                    order.latitude != null ? order.latitude : -6.934837,
                    order.longitude != null ? order.longitude : 107.620810),
                builder: (ctx) => new Container(
                      child: Icon(Icons.place),
                    ),
              )
            ],
          ),
        ),
      );
  Widget textButon() {
    if (order.status.toLowerCase() == "waiting") {
      return Text(
        "Jemput",
        style: TextStyle(color: Colors.white),
      );
    } else if (order.status.toLowerCase() == "jemput") {
      return Text(
        "Sampai Petshop",
        style: TextStyle(color: Colors.white),
      );
    }else if (order.status.toLowerCase() == "selesai-petshop") {
      return Text(
        "Antar",
        style: TextStyle(color: Colors.white),
      );
    }else if (order.status.toLowerCase() == "antar") {
      return Text(
        "Selesai",
        style: TextStyle(color: Colors.white),
      );
    }
  }

  Widget content() => new Center(
          child: Column(
        children: <Widget>[
          Expanded(
            flex: 12,
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    mapswidget(),
                    orderContent(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(10.0),
                width: double.infinity,
                height: 100.0,
                child: order.status == "jemput" ||
                        order.status == "waiting" ||
                        order.status == "selesai-petshop" ||
                        order.status == "antar"
                    ? RaisedButton(
                        onPressed: () =>
                            OrderController(context).changeStatus(order),
                        color: Colors.green,
                        child: textButon(),
                      )
                    : null,
              ),
            ),
          )
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Detail Order"),
          backgroundColor: Colors.lightGreen,
        ),
        body: content(),
        // bottomNavigationBar: widget.level == "add" ? saveButton() : Container(),
      ),
    );
  }
}

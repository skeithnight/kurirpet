import 'package:flutter/material.dart';
import 'package:kurirpet/screens/widget/appbar_widget.dart';

import 'package:kurirpet/controller/order_controller.dart';
import 'package:kurirpet/model/hotel_model.dart';
// import 'detail_hotel_page.dart';

class MainScreen extends StatefulWidget {
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget content() => new FutureBuilder<List<Hotel>>(
        // future: ProductController(context).getMain(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return listData(snapshot.data);
          } else if (snapshot.hasError) {
            return new Center(child: Text("${snapshot.error}"));
          }

          return new Center(child: CircularProgressIndicator());
        },
      );

  Widget listData(List<Hotel> listData) {
    return ListView.builder(
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) => Card(
              elevation: 5.0,
              child: ListTile(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) =>
                  //         DetailHotelPage('detail', listData[index])));
                },
                title: Text(listData[index].name),
                subtitle: Text(listData[index].price.toString()),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context).appBar("Daftar Pesanan"),
      // body: content(),
      body: Column(
        children: <Widget>[
          Card(
            child: ListTile(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) =>
                //         DetailHotelPage('detail', listData[index])));
              },
              title: Text("nama pemesan"),
              subtitle: Column(
                children: <Widget>[Text("alamat", textAlign: TextAlign.left,), Text('Jenis layanan')],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => DetailHotelPage("add", null)));
        },
        tooltip: 'test location',
        child: Icon(Icons.place),
      ),
    );
  }
}

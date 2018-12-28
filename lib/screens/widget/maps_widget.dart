import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapsWidget extends StatelessWidget {
  @required
  double lat;
  @required
  double lon;
  List<Marker> listMarker = new List();
  String tokenMaps =
      "pk.eyJ1Ijoic2tlaXRobmlnaHQiLCJhIjoiY2pvYWw5aGYwMGxnazNybGMxZ3B0ZWc3aiJ9.g5ybUMKi4nGoYGFQdly1-A";

  MapsWidget({this.lat, this.lon, this.listMarker});
  @override
  Widget build(BuildContext context) {
    return new FlutterMap(
      options: new MapOptions(
        center: new LatLng(lat, lon),
        zoom: 13.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken': tokenMaps,
            'id': 'mapbox.streets',
          },
        ),
        new MarkerLayerOptions(
            markers: listMarker == null
                ? [
                    new Marker(
                      width: 80.0,
                      height: 80.0,
                      point: new LatLng(0.0, 0.0),
                      builder: (ctx) => new Container(
                            child: Icon(Icons.place),
                          ),
                    )
                  ]
                : listMarker)
      ],
    );
  }
}

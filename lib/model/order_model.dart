import 'service_model.dart';
import 'petshop_model.dart';
import 'courier_model.dart';
import 'customer_model.dart';
import 'detail_transaksi_model.dart';

class Order {
  String id;
  Customer customer;
  Petshop petshop;
  Courier courier;
  String address;
  double latitude;
  double longitude;
  List<DetailTransaksi> groomings;
  List<DetailTransaksi> clinics;
  List<DetailTransaksi> hotels;
  int from;
  int to;
  String note;
  String status;

  Order();

  Order.fromSnapshot(
      Map<dynamic, dynamic> snapshot,
      List<DetailTransaksi> groomings,
      List<DetailTransaksi> clinics,
      List<DetailTransaksi> hotels)
      : id = snapshot["id"],
        customer = snapshot["customer"] == null
            ? null
            : Customer.fromSnapshot(snapshot["customer"]),
        petshop = snapshot["petshop"] == null
            ? null
            : Petshop.fromSnapshot(snapshot["petshop"]),
        courier = snapshot["courier"] == null
            ? null
            : Courier.fromSnapshot(snapshot["courier"]),
        address = snapshot["address"],
        latitude = snapshot["latitude"],
        longitude = snapshot["longitude"],
        this.groomings = groomings,
        this.clinics = clinics,
        this.hotels = hotels,
        from = snapshot["from"],
        to = snapshot["to"],
        note = snapshot["note"],
        status = snapshot["status"];
  Map<String, dynamic> toJsonChangeStatus(
          String idCourier, String statusEdit) =>
      {
        "id": id,
        "customer": {"id": customer.id},
        "petshop": {"id": petshop.id},
        "courier": {"id": courier.id},
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "from": from,
        "to": to,
        "note": note,
        "status": statusEdit,
      };
}

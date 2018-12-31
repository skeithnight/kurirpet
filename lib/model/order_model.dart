import 'service_model.dart';
import 'petshop_model.dart';
import 'courier_model.dart';
import 'customer_model.dart';

class Order {
  String id;
  Customer customer;
  Petshop petshop;
  Courier courier;
  String address;
  double latitude;
  double longitude;
  List<Service> services;
  int from;
  int to;
  String note;
  String status;

  Order();

  Order.fromSnapshot(Map<dynamic, dynamic> snapshot)
      : id = snapshot["id"],
        customer = snapshot["customer"] == null ? null:Customer.fromSnapshot(snapshot["customer"]),
        petshop = snapshot["petshop"] == null ? null:Petshop.fromSnapshot(snapshot["petshop"]),
        courier = snapshot["courier"] == null ? null:Courier.fromSnapshot(snapshot["courier"]),
        address = snapshot["address"],
        latitude = snapshot["latitude"],
        longitude = snapshot["longitude"],
        // services = ,
        from = snapshot["from"],
        to = snapshot["to"],
        note = snapshot["note"],
        status = snapshot["status"];
  Map<String, dynamic> toJsonChangeStatus(String idCourier, String statusEdit) => {
        "id": id,
        "customer": {"id": customer.id},
        "petshop": {"id": petshop.id},
        "courier": {"id": idCourier},
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "from": from,
        "to": to,
        "note": note,
        "status": statusEdit,
      };
}

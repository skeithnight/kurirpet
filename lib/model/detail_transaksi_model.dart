import 'service_model.dart';
import 'petshop_model.dart';
import 'courier_model.dart';
import 'customer_model.dart';

class DetailTransaksi {
  Service service;
  int jumlah;
  DetailTransaksi();

  DetailTransaksi.fromSnapshot(Map<dynamic, dynamic> snapshot)
      : service = snapshot["service"] == null
            ? null
            : Service.fromSnapshot(snapshot["service"]),
        jumlah = snapshot["jumlah"];
}

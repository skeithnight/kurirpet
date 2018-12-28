import 'package:kurirpet/model/petshop_model.dart';
import 'package:kurirpet/model/courier_model.dart';
import 'clinic_model.dart';
class Order {
  String id;
  // Customer customer;
  Petshop petshop;
  Courier courier;
  String address;
  double latitude;
  double longitude;
  List<Clinic> services;
  DateTime from;
  DateTime to;
  String note;
  String status;
}

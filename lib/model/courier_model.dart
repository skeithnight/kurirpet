import 'petshop_model.dart';

class Courier {
  String idPetshop;
  String id;
  String username;
  String password;
  String name;
  Petshop petshop;
  double latitude;
  double longitude;
  bool enabled;
  List<dynamic> roles;

  Courier();

  Courier.fromSnapshot(Map<dynamic, dynamic> snapshot)
      : id = snapshot["id"],
        username = snapshot["username"],
        name = snapshot["name"],
        petshop = Petshop.fromSnapshot(snapshot["petshop"]),
        latitude = snapshot["latitude"],
        longitude = snapshot["longitude"],
        roles = snapshot["roles"],
        enabled = snapshot["enabled"];

  Map<String, dynamic> toJsonInsert() => {
        "username": username,
        "password": password,
        "petshop": {
          "id": idPetshop,
        },
        "name": name,
        // "enabled": enabled,
      };
  Map<String, dynamic> toJsonLogin() => {
        "username": username,
        "password": password,
      };
  Map<String, dynamic> toJsonData() => {
        "id": id,
        "username": username,
        "petshop": {
          "id": petshop.id,
        },
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "enabled": enabled,
        "roles": roles,
      };
}

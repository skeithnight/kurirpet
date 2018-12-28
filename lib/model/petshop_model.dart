class Petshop {
  String id;
  String username;
  String password;
  String name;
  String address;
  double latitude;
  double longitude;
  bool enabled;

  Petshop();

  Petshop.fromSnapshot(Map<dynamic, dynamic> snapshot)
      : id = snapshot["id"],
        username = snapshot["username"],
        name = snapshot["name"],
        address = snapshot["address"],
        latitude = snapshot["latitude"],
        longitude = snapshot["longitude"],
        enabled = snapshot["enabled"];

  Map<String, dynamic> toJsonRegister() => {
        "username": username,
        "password": password,
        "name": name,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "enabled": true,
      };
  Map<String, dynamic> toJsonLogin() => {
        "username": username,
        "password": password,
      };
}

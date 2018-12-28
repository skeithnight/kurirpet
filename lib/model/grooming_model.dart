import 'petshop_model.dart';

class Grooming {
  String idPetshop;
  String id;
  Petshop petshop;
  String name;
  String descrition;
  List<String> pictures;
  double price;

  Grooming();

  Grooming.fromSnapshot(Map<dynamic, dynamic> snapshot)
      : id = snapshot["id"],
        petshop = Petshop.fromSnapshot(snapshot["petshop"]),
        name = snapshot["name"],
        descrition = snapshot["descrition"],
        pictures = snapshot["pictures"],
        price = snapshot["price"];

  Map<String, dynamic> toJsonInsert() => {
        "petshop": {
          "id": idPetshop,
        },
        "name": name,
        "descrition": descrition,
        // "pictures": address,
        "price": price,
      };
}

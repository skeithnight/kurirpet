import 'service_model.dart';
import 'petshop_model.dart';

class Grooming extends Service {
  Grooming();

  Grooming.fromSnapshot(Map<dynamic, dynamic> snapshot) {
    id = snapshot["id"];
    petshop = Petshop.fromSnapshot(snapshot["petshop"]);
    name = snapshot["name"];
    descrition = snapshot["descrition"];
    pictures = snapshot["pictures"];
    price = snapshot["price"];
  }
}

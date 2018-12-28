import 'package:flutter/material.dart';

class DialogWidget {
  BuildContext context;
  bool dismiss = false;
  DialogWidget({this.context, this.dismiss});
  void tampilDialog(String tittle, String message, dynamic route) {
    showDialog(
      barrierDismissible: dismiss,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(tittle),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                if (tittle == "Failed") {
                  Navigator.of(context).pop();
                } else if (tittle == "Success") {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: ((context) => route)));
                }
              },
            ),
          ],
        );
      },
    );
  }
}

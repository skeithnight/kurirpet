import 'package:flutter/material.dart';
import 'package:kurirpet/controller/login_controller.dart';

class AppBarWidget {
  BuildContext context;
  AppBarWidget(this.context);
  Widget appBar(title) => new AppBar(
        title: Text(title),
        backgroundColor: Colors.lightGreen,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              LoginController(context).logout();
            },
          )
        ],
      );
}

import 'package:flutter/material.dart';
import 'package:shape_of_view/shape_of_view.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Customer Solution Management"),
        ),
        body: Container(
          child: Center(
            child: ElevatedButton(
                child: Text("Back"),
                onPressed: () {
                  loginPage(context);
                }),
          ),
        ),
      ),
    );
  }
}

loginPage(BuildContext context) {
  Navigator.pop(context);
}

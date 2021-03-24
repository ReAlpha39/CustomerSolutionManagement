import 'dart:io';

import 'package:customer/controller/home_controller.dart';
import 'package:customer/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shape_of_view/shape_of_view.dart';
import '../widgets/icon_app.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.black87,
          brightness: Brightness.dark,
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Shapeground(),
        )),
      ),
    );
  }

  Future<bool> _onWillPop() {
    return Get.defaultDialog(
            radius: 17,
            title: 'Exit App',
            middleText: 'Apakah anda ingin keluar dari aplikasi?',
            textConfirm: 'OK',
            buttonColor: Color(0xffffcd29),
            cancelTextColor: Colors.black87,
            textCancel: 'Batal',
            confirmTextColor: Colors.black87,
            onConfirm: () => exit(0),
            onCancel: () => Get.back()) ??
        false;
  }
}

class Shapeground extends StatelessWidget {
  final LoginController _loginController = LoginController.to;
  final HomeController _homeController = HomeController.to;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
        ),
        Column(
          children: [
            ShapeOfView(
              shape: ArcShape(
                direction: ArcDirection.Outside,
                height: 34,
                position: ArcPosition.Bottom,
              ),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  color: Colors.black87,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: IconApp(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          '${_loginController.usr.value.username}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 23, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: TextButton(
                          onPressed: () {
                            Get.offAndToNamed('/login_page');
                          },
                          child: Text(
                            "Logout",
                            style: TextStyle(color: Color(0xffffcd29)),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Obx(() => _homeController.userType()),
            ),
          ],
        ),
      ],
    );
  }
}

loginPage(BuildContext context) {
  Navigator.pop(context);
}

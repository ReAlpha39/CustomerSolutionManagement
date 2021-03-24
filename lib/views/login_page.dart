import 'dart:io';

import 'package:customer/widgets/login_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shape_of_view/shape_of_view.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          brightness: Brightness.light,
          shadowColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: Get.height, minWidth: Get.width),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShapeOfView(
                      clipBehavior: Clip.antiAlias,
                      elevation: 0,
                      shape: ArcShape(
                        direction: ArcDirection.Outside,
                        height: 11,
                        position: ArcPosition.Bottom,
                      ),
                      child: Container(
                        height: 90,
                        color: Color(0xffffcd29),
                      ),
                    ),
                    ShapeOfView(
                      clipBehavior: Clip.antiAlias,
                      elevation: 0,
                      shape: ArcShape(
                        direction: ArcDirection.Outside,
                        height: 11,
                        position: ArcPosition.Top,
                      ),
                      child: Container(
                        height: 120,
                        color: Color(0xffffcd29),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: LoginCard()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    return Get.defaultDialog(
            radius: 17,
            title: 'Exit App',
            middleText: 'Apakah anda ingin keluar dari aplikasi?',
            textConfirm: 'OK',
            textCancel: 'Batal',
            buttonColor: Color(0xffffcd29),
            cancelTextColor: Colors.black87,
            confirmTextColor: Colors.black87,
            onConfirm: () => exit(0),
            onCancel: () => Get.back()) ??
        false;
  }
}

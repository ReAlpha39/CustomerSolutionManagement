import 'package:customer/controller/pica_controller.dart';
import 'package:customer/widgets/pica_chart.dart';
import 'package:customer/widgets/pica_analysis/pica_observation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class PicaAnalysisPage extends StatelessWidget {
  final PicaController _controller = Get.find();
  static List<Widget> _widgetOption = <Widget>[
    PicaChart(),
    PicaObservation(),
    Center(
      child: Text(
        'Profile',
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Pica Analysis'),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
            ],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24))),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Obx(
              () => GNav(
                rippleColor: Color(0xffffe694),
                hoverColor: Color(0xffffe17f),
                gap: 8,
                activeColor: Color(0xff806715),
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 500),
                tabBackgroundColor: Color(0xffffcd29),
                tabs: [
                  GButton(
                    icon: LineIcons.barChart,
                    iconColor: Color(0xffffcd29),
                    text: 'Score',
                  ),
                  GButton(
                    icon: LineIcons.tags,
                    iconColor: Color(0xffffcd29),
                    text: 'Observasi',
                  ),
                  GButton(
                    icon: LineIcons.thumbtack,
                    iconColor: Color(0xffffcd29),
                    text: 'Matrix',
                  ),
                ],
                selectedIndex: _controller.navBarIndex.value,
                onTabChange: (index) {
                  _controller.navBarIndex.value = index;
                },
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: Get.height, minWidth: Get.width),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: context.height * 0.3,
                    width: Get.width,
                    color: Color(0xffffcd29),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Obx(
                () => _widgetOption.elementAt(_controller.navBarIndex.value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

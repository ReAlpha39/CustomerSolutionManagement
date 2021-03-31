import 'package:customer/controller/mspp_controller.dart';
import 'package:customer/widgets/Mspp/mspp_result.dart';
import 'package:customer/widgets/Mspp/mspp_text_field.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MsppCardMeet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: ExpandableNotifier(
            child: ScrollOnExpand(
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: false,
                  hasIcon: true,
                ),
                header: Container(
                  child: Text(
                    'Meet',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                collapsed: Container(),
                expanded: ExpandedMeetData(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExpandedMeetData extends StatelessWidget {
  final MsppController controller = Get.find();

  Future<bool> resultRadio({int index}) {
    return Get.defaultDialog(
        barrierDismissible: false,
        radius: 17,
        title: 'Pilih salah satu',
        content: (MsppResult(
          data: ['Yes', 'No', 'N/A'],
          index: index,
          id: 'meet',
        )),
        textConfirm: 'OK',
        buttonColor: Color(0xffffcd29),
        confirmTextColor: Colors.black87,
        onConfirm: () => Get.back(closeOverlays: false));
  }

  Future<bool> resultTextField({int index}) {
    return Get.defaultDialog(
        barrierDismissible: false,
        radius: 17,
        title: 'Remark',
        content: MsppTextField(),
        textConfirm: 'OK',
        buttonColor: Color(0xffffcd29),
        confirmTextColor: Colors.black87,
        onConfirm: () {
          controller.textFieldPI('meet')[index] =
              controller.textEditingControllerALL.text;
          controller.textEditingControllerALL.clear();
          Get.back(closeOverlays: false);
        });
  }

  TextButton buildTextButtonRemark(int id) {
    return TextButton(
      onPressed: () {
        resultTextField(index: id);
      },
      child: Obx(() => Text(controller.textFieldMeet[id] == ""
          ? 'Klik disini'
          : "${controller.textFieldMeet[id]}")),
    );
  }

  TextButton buildTextButtonAssessment(int id) {
    return TextButton(
      onPressed: () {
        resultRadio(index: id);
      },
      child: Obx(() => Text(controller.radioIndexMeet[id] == -1
          ? 'Pilih disini'
          : '${controller.radioData[controller.radioIndexMeet[id]]}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            dataRowHeight: 100,
            columns: [
              DataColumn(label: Text('Assessment Result 1')),
              DataColumn(label: Text('Remark')),
              DataColumn(label: Text('No. Klausul')),
              DataColumn(label: Text('Deskripsi')),
              DataColumn(label: Text('PIC')),
              DataColumn(label: Text('Guidance')),
              DataColumn(label: Text('Objective Evidence')),
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(buildTextButtonAssessment(0)),
                  DataCell(buildTextButtonRemark(0)),
                  DataCell(Text('1.1.2.1')),
                  DataCell(
                    Container(
                      width: 160,
                      child: Text(
                          'Cek apakah  briefing di awal shift dilakukan sebelum melakukan inspeksi ?'),
                    ),
                  ),
                  DataCell(Text('SPV/GL')),
                  DataCell(
                    SingleChildScrollView(
                      child: Container(
                        width: 160,
                        child: Column(
                          children: [
                            Text(
                                '- Memastikan Agenda PI briefing sudah dibuat di meeting record sesuai dengan agenda'),
                            Text(''),
                            Text(
                                '- Melihat daftar absensi di meeting record apakah diisi dan di tanda tangani oleh peserta yang hadir'),
                            Text(''),
                            Text(
                                '- Memastikan apakah dokumen PI diserahkan kepada mekanik setelah briefing awal shift')
                          ],
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 110,
                      child: Column(
                        children: [
                          Text('- Meeting Record'),
                          Text(''),
                          Text('- Dokumen PI      ')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(buildTextButtonAssessment(1)),
                  DataCell(buildTextButtonRemark(1)),
                  DataCell(Text('1.1.2.2')),
                  DataCell(
                    Container(
                      width: 160,
                      child: Text(
                          'Check apakah setiap unit yang di inspeksi di konfirmasi ke radio room untuk dicatatkan down unitnya dan kebutuhan alat suppornya ?'),
                    ),
                  ),
                  DataCell(Text('Team PI')),
                  DataCell(
                    SingleChildScrollView(
                      child: Container(
                        width: 160,
                        child: Column(
                          children: [
                            Text(
                                '- Melihat apakah ada Log Book khusus radioman'),
                            Text(''),
                            Text(
                                '- Melihat apakah setiap unit yang dilakukan PI dilakukan konfirmasi ke radioman untuk dicatat kebutuhan alat support dan waktu downnya di Log Book'),
                            Text(''),
                            Text(
                                '- Interview mekanik dan radioman terkait konfirmasi unit yang akan PI dan pencatatannya di Log Book')
                          ],
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Text('Log Book Radioman'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

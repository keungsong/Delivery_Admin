import 'package:admin_panel/services/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class DeliveryBoy extends StatelessWidget {
  static const String id = 'delivery-boy';
  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('ລາຍຊື່ຂົນສົ່ງ'),
      ),
      sideBar: _sideBar.siderBarMenus(context, DeliveryBoy.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Text(
            'ຂົນສົ່ງ',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:admin_panel/screens/delivery_boy.dart';
import 'package:admin_panel/screens/home_screen.dart';
import 'package:admin_panel/screens/notification.dart';
import 'package:admin_panel/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class SideBarWidget {
  siderBarMenus(context, selectedRoute) {
    return SideBar(
      activeBackgroundColor: Colors.deepOrangeAccent,
      activeIconColor: Colors.white,
      activeTextStyle: TextStyle(color: Colors.white),
      items: const [
        MenuItem(
          title: 'ໜ້າຫຼັກ',
          route: HomeScreen.id,
          icon: Icons.home,
        ),
        MenuItem(
          title: 'ລາຍຊື່ຂົນສົ່ງ',
          route: DeliveryBoy.id,
          icon: Icons.people_alt_outlined,
        ),
        MenuItem(
          title: 'ແຈ້ງເຕືອນ',
          route: NotificationScreen.id,
          icon: Icons.notifications,
        ),
        MenuItem(
          title: 'ການຕັ້ງຄ່າ',
          route: SettingScreen.id,
          icon: Icons.settings,
        ),
      ],
      selectedRoute: selectedRoute,
      onSelected: (item) {
        if (item.route != null) {
          Navigator.of(context).pushNamed(item.route);
        }
      },
      header: Container(
        height: 50,
        width: double.infinity,
        color: Color(0xff444444),
        child: Center(
          child: Text(
            'ເມນູ',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      footer: Container(
        height: 50,
        width: double.infinity,
        color: Color(0xFFFCF6F6),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/logo.png", fit: BoxFit.cover),
              Text(
                'ໝູ່ນ້ອຍແລ່ນໄວ',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

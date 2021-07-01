import 'package:admin_panel/screens/delivery_boy.dart';
import 'package:admin_panel/screens/login_screen.dart';
import 'package:admin_panel/screens/home_screen.dart';
import 'package:admin_panel/screens/notification.dart';
import 'package:admin_panel/screens/setting_screen.dart';
import 'package:admin_panel/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ລະບົບຈັດການຂົນສົ່ງ',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        DeliveryBoy.id: (context) => DeliveryBoy(),
        NotificationScreen.id: (context) => NotificationScreen(),
        SettingScreen.id: (context) => SettingScreen()
      },
    );
  }
}

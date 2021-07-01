import 'package:admin_panel/screens/home_screen.dart';
import 'package:admin_panel/services/firebase_services.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  FirebaseServices _services = FirebaseServices();
  var _usernameTextController = TextEditingController();
  var _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ArsProgressDialog progressDialog = ArsProgressDialog(context,
        blur: 2,
        backgroundColor: Colors.deepOrangeAccent.withOpacity(.8),
        animationDuration: Duration(milliseconds: 500));

    _login({username, password}) async {
      progressDialog.show();
      _services.getAdminCredentials(username).then((value) async {
        if (value.exists) {
          if (value.data()['username'] == username) {
            if (value.data()['password'] == password) {
              // if both correct , will navigator to home screen
              try {
                UserCredential userCredential =
                    await FirebaseAuth.instance.signInAnonymously();
                if (userCredential != null) {
                  // if signin success
                  progressDialog.dismiss();
                  Navigator.pushReplacementNamed(context, HomeScreen.id);
                }
              } catch (e) {
                // if signin failed
                progressDialog.dismiss();
                _showMyDialog(
                  title: 'ເຂົ້າລະບົບ',
                  message: '${e.toString()}',
                );
              }
              return;
            }
            _showMyDialog(
                title: 'ແຈ້ງເຕຶອນ', message: 'ລະຫັດຜິດພາດ ກະລຸນາລອງໃໝ່');
          }
        }
        progressDialog.dismiss();
        _showMyDialog(
            title: 'ແຈ້ງເຕຶອນ',
            message: 'ຊື່ເຂົ້າລະບົບແມ່ນບໍ່ພົບ ກະລຸນາລອງໃໝ່');
      });
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('ລະບົບຈັດການລະບົບຂົນສົ່ງ'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          // Initialize FlutterFire:
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return Center(
                child: Text('ການເຊື່ອມຕໍ່ລົ້ມແຫຼວ'),
              );
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Container(
                  width: 300,
                  height: 400,
                  child: Card(
                    elevation: 6,
                    // shape: Border.all(color: Colors.grey, width: 2),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: 100,
                                        height: 60,
                                        child: Image.asset("images/logo.png",
                                            fit: BoxFit.cover)),
                                    Text(
                                      'ໝູນ້ອຍແລ່ນໄວ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: _usernameTextController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'ກະລຸນາ ໃສ່ຊື່ຜູ້ໃຊ້';
                                        }

                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.person),
                                          hintText: 'ຊື່ຜູ້ໃຊ້',
                                          focusColor: Colors.deepOrangeAccent,
                                          contentPadding: EdgeInsets.only(
                                              left: 20, right: 20),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 2)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Colors.grey,
                                          ))),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: _passwordTextController,
                                      obscureText: true,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'ກະລຸນາ ໃສ່ລະຫັດຜ່ານ';
                                        }
                                        if (value.length < 6) {
                                          return 'ລະຫັດຕ່ຳສຸດ 6 ຕົວອັກສອນ';
                                        }

                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          prefixIcon:
                                              Icon(Icons.vpn_key_rounded),
                                          hintText: 'ລະຫັດຜ່ານ',
                                          focusColor: Colors.deepOrangeAccent,
                                          contentPadding: EdgeInsets.only(
                                              left: 20, right: 20),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 2)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Colors.grey,
                                          ))),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: FlatButton(
                                        height: 50,
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _login(
                                              username:
                                                  _usernameTextController.text,
                                              password:
                                                  _passwordTextController.text,
                                            );
                                          }
                                        },
                                        color: Colors.deepOrangeAccent,
                                        child: Text(
                                          'ເຂົ້າລະບົບ',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                ),
              );
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Future<void> _showMyDialog({title, message}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ຕົກລົງ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

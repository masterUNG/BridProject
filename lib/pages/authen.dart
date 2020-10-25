import 'dart:convert';

import 'package:birdqrcode/models/user_model.dart';
import 'package:birdqrcode/pages/my_service.dart';
import 'package:birdqrcode/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String user, password;

  @override
  void initState() {
    // TODO: implement initState

    checkPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
        ),
        child: Stack(
          children: [
            buildCenter(),
            buildVersionText(),
          ],
        ),
      ),
    );
  }

  Column buildVersionText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'VIROTE APP 2020.08 Beta',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Center buildCenter() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildLogo(),
            SizedBox(
              height: 40,
            ),
            buildUserForm(),
            SizedBox(
              height: 18,
            ),
            buildPasswordForm(),
            SizedBox(
              height: 18,
            ),
            buildLogin(),
          ],
        ),
      ),
    );
  }

  Widget buildLogin() => Container(
        width: 150,
        height: 45,
        child: RaisedButton(
          color: Color(0xffffc907),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            if (user == null ||
                user.isEmpty ||
                password == null ||
                password.isEmpty) {
              normalDialog(context, 'FILL USERNAME OR PASSWORD');
            } else {
              checkAuthen();
            }

            print('user = $user , password = $password');
          },
          child: Text('LOGIN'),
        ),
      );

  Widget buildUserForm() => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        height: 45,
        width: 250,
        child: TextField(
          onChanged: (value) => user = value.trim(),
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15),
            hintText: 'USERNAME',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
      );

  Widget buildPasswordForm() => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        height: 45,
        width: 250,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15),
            hintText: 'PASSWORD',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
      );

  Widget buildLogo() => Container(
        width: 75,
        child: Image.asset('images/logo.png'),
      );

  Future<Null> checkAuthen() async {
    String urlAPI =
        'http://scitrader.co.th/VR/app/getUserwhereUser.php?isAdd=true&u_username=$user';
    Response response = await Dio().get(urlAPI);
    print('response = $response');
    if (response.toString() == 'null') {
      normalDialog(context, 'NO $user IN DATABASE');
    } else {
      var result = json.decode(response.data);
      print('result = $result');

      for (var map in result) {
        UserModel model = UserModel.fromJson(map);
        if (password == model.uPassword) {
          savePreferance();
        } else {
          normalDialog(context, 'WRONG PASSWORD');
        }
      }
    }
  }

  Future<Null> savePreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('u_username', user);

    routeToMyService();
  }

  void routeToMyService() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MyService(),
        ),
        (route) => false);
  }

  Future<Null> checkPreference() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String userLogin = preferences.getString('u_username');
      if (userLogin.isNotEmpty) {
        routeToMyService();
      }
    } catch (e) {
    }
  }
}

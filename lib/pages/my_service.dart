import 'package:birdqrcode/pages/authen.dart';
import 'package:birdqrcode/pages/list_product.dart';
import 'package:birdqrcode/pages/search.dart';
import 'package:birdqrcode/pages/setting.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  List<Widget> widgets = [
    Search(),
    ListProduct(),
    Setting(),
  ];

  int index = 0;

  BottomNavigationBarItem searchBottomBar() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.search),
      title: Text('PRODUCT'),
    );
  }

  BottomNavigationBarItem listProductBottomBar() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.list),
      title: Text('LACK ITEM'),
    );
  }

  BottomNavigationBarItem settingBottomBar() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      title: Text('SETTING'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PRODUCTS PAGE'),
        actions: [
          
        ],
      ),
      drawer: Drawer(
        child: buildSignOut(),
      ),
      body: widgets[index],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() => BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          searchBottomBar(),
          listProductBottomBar(),
          settingBottomBar(),
        ],
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      );

  Widget buildSignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.red.shade400),
          child: ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            title: Text(
              'Sign Out',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.clear();

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Authen(),
                  ),
                  (route) => false);
            },
          ),
        ),
      ],
    );
  }
}

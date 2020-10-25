import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:birdqrcode/pages/authen.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Map<int, Color> colorBlack = {
    50: Color.fromRGBO(48, 48, 48, 0.1),
    100: Color.fromRGBO(48, 48, 48, 0.2),
    200: Color.fromRGBO(48, 48, 48, 0.3),
    300: Color.fromRGBO(48, 48, 48, 0.4),
    400: Color.fromRGBO(48, 48, 48, 0.5),
    500: Color.fromRGBO(48, 48, 48, 0.6),
    600: Color.fromRGBO(48, 48, 48, 0.7),
    700: Color.fromRGBO(48, 48, 48, 0.8),
    800: Color.fromRGBO(48, 48, 48, 0.9),
    900: Color.fromRGBO(48, 48, 48, 1),
  };

  @override
  Widget build(BuildContext context) {
    MaterialColor materialColorBlack = MaterialColor(0xff303030, colorBlack);

    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Authen(),
      title: 'VIROTE APP 2020.08 Beta',
      theme: ThemeData(primarySwatch: materialColorBlack),
    );
  }
}

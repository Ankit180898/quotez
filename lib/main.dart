import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'Views/home_page.dart';

Future main() async{
  await dotenv.dotenv.load(fileName:".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  HomePage(),
    );
  }
}


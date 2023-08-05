import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:get/get.dart';
import 'Controllers/internet_controller.dart';
import 'Controllers/theme_controller.dart';
import 'Services/api_service.dart';
import 'Views/onbaording_screen.dart';
import 'home'
Future main() async{
  await dotenv.dotenv.load(fileName:".env");
  runApp( MyApp());
}

// Called when Doing Background Work initiated from Widget
Future<void> backgroundCallback(Uri uri) async {
  if (uri.host == 'updatecounter') {
    int _counter;
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0).then((value) {
      _counter = value;
      _counter++;
    });
    await HomeWidget.saveWidgetData<int>('_counter', _counter);
    await HomeWidget.updateWidget(name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
  }
}

class MyApp extends StatelessWidget {
   MyApp({super.key});


  final ThemeController themeController = Get.put(ThemeController());


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.green,
      // Add more customizations as per your requirement for the light theme
    );

    ThemeData darkTheme = ThemeData(

      useMaterial3: true,
      primaryColor: Colors.indigo, // Replace with your preferred primary color for dark theme
      brightness: Brightness.dark,
      // Add more customizations as per your requirement for the dark theme
    );


    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      initialBinding: BindingsBuilder(() {
        Get.put(InternetController(), permanent: true);
        Get.put(ApiService(), permanent: true);
      }),
      home:  const OnBoardingScreen(),
    );
  }
}


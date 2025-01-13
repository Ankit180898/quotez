import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';
import 'Controllers/internet_controller.dart';
import 'Controllers/theme_controller.dart';
import 'Services/api_service.dart';
import 'Views/onbaording_screen.dart';

Future main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.dotenv.load(fileName: ".env");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Define the method channel
  static const platform = MethodChannel('com.example.quotez/widget');

  final ThemeController themeController = Get.put(ThemeController());


  // Method to update the widget
Future<void> updateWidgetQuote() async {
  try {
    // Invoke the method channel and pass the API key
    await platform.invokeMethod('updateWidget', {
      'apiKey': dotenv.dotenv.env['API_KEY']
    });
  } on PlatformException catch (e) {
    print("Failed to update widget: '${e.message}'.");
  } catch (e) {
    print("Error updating widget: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    // Update the widget when the app is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateWidgetQuote();
    });

    ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.green,
    );

    ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      primaryColor: Colors.indigo,
      brightness: Brightness.dark,
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quotez',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeController.isDarkMode.value 
          ? ThemeMode.dark 
          : ThemeMode.light,
      initialBinding: BindingsBuilder(() {
        Get.put(InternetController(), permanent: true);
        Get.put(ApiService(), permanent: true);
      }),
      home: const OnBoardingScreen(),
    );
  }
}
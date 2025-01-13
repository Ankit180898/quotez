// // quote_widget.dart
// import 'package:home_widget/home_widget.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:quotez/Models/random_quote_model.dart';
// import 'package:quotez/Services/api_service.dart';

// class QuoteWidget {
//   static const platform = MethodChannel('quotez/widget');
//   Future<void> updateWidget(String quote) async {
//     try {
//       await MyApp.platform.invokeMethod('updateWidget', {'quote': quote});
//     } on PlatformException catch (e) {
//       print("Failed to update widget: ${e.message}");
//     }
//   }
// }

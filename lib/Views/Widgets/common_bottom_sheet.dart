import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotez/Controllers/theme_controller.dart';

class BottomSheetExample extends StatelessWidget {
  final themeController=Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient:
          LinearGradient(
              colors: [Color(0xFF4051A9), Color(0xFF9354B9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.1, 0.9]),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Search',
            style: GoogleFonts.inter(
              fontSize: 30.0,
              color: themeController.isDarkMode.isFalse
                  ? Colors.white
                  : Colors.white,
              // Adjust the font size as needed
              fontWeight: FontWeight
                  .bold, // Adjust the font weight as needed
            ),
          ),
          SizedBox(height: 10,),
          TextField(
             decoration: InputDecoration(
               filled: true,
               fillColor: Colors.white,
               suffixIcon: Icon(Icons.search_rounded),
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(20)
               ),
               hintText: "Search in the categories"
             ),
            autofocus: false,
            onChanged: (newText) {},
          ),
          SizedBox(height: 10,),
          RawMaterialButton(
            elevation: 0.0,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: Text(
              'Close',
              style: GoogleFonts.inter(
                fontSize: 20.0,
                color: themeController.isDarkMode.isFalse
                    ? Colors.white
                    : Colors.white,
              ),
            ),
            fillColor: const Color(0xFF9365C6),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
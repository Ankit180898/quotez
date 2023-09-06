import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotez/Controllers/home_page_controller.dart';
import 'package:quotez/Controllers/theme_controller.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});
  final themeController=Get.find<ThemeController>();
  // var controller=Get.find<HomePageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search",
          style: GoogleFonts.inter(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: themeController.isDarkMode.isFalse
                  ? Color(0xFF4051A9)
                  : Colors.black12),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient:themeController.isDarkMode.isFalse? LinearGradient(
              colors: [Color(0xFF4051A9), Color(0xFF9354B9)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.1, 0.9]):null,
          color: themeController.isDarkMode.isTrue?Colors.black12:null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF9354B9)),
                borderRadius: BorderRadius.circular(20.0),
              ),
              hintText: 'Search...',
              // Add a clear button to the search bar
              suffixIcon: IconButton(
                icon: Icon(Icons.clear), onPressed: () {  },

              ),
              // Add a search icon or button to the search bar
              prefixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Perform the search here
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

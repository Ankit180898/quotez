import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

import '../Controllers/home_page_controller.dart';
import '../Controllers/theme_controller.dart';
class QuoteDisplayScreen extends StatelessWidget {
   QuoteDisplayScreen({super.key});
  var controller=Get.find<HomePageController>();
  var themeController=Get.find<ThemeController>();
   var data = Get.arguments;
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quotez",style: GoogleFonts.openSans(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white,),),
        elevation: 0,
        flexibleSpace:Container(
          decoration:  BoxDecoration(
              color: themeController.isDarkMode.isFalse?Color(0xFF4051A9):Colors.black12
          ),
        ),
        actions: [
          IconButton(icon: themeController.isDarkMode.isTrue?Icon(Icons.light_mode):Icon(Icons.dark_mode),onPressed: (){
            themeController.toggleTheme();
          },)
        ],
      ),
      body: Column(
        children: [
          Text("Quotes",style:
          GoogleFonts.openSans(fontSize: 20,fontWeight: FontWeight.bold,color: themeController.isDarkMode.isFalse?Colors.black:Colors.black),

          ),
          Text(
            "${data[2]}",
            textAlign: TextAlign.center,
            style:GoogleFonts.poppins(
              fontSize: 25.0,
              color:themeController.isDarkMode.isFalse?Colors.black:Colors.black,
              // Adjust the font size as needed
              fontWeight: FontWeight.bold, // Adjust the font weight as needed
            ),
          ),
          Row(
            children: [
              IconButton(onPressed: () {
                Share.share("${data[2]}");
              }, icon: const Icon(Icons.share),color: Colors.red,


              ),
              IconButton(onPressed: () async{
                await Clipboard.setData( ClipboardData(text: data[2])).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied to your clipboard !')));
                });

              }, icon: const Icon(Icons.copy),color: Colors.red,


              ),

            ],
          )
        ],

      ),
    );
  }
}

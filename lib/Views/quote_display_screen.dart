import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

import '../Controllers/home_page_controller.dart';
import '../Controllers/theme_controller.dart';

class QuoteDisplayScreen extends StatefulWidget {
  QuoteDisplayScreen({super.key});

  @override
  State<QuoteDisplayScreen> createState() => _QuoteDisplayScreenState();
}

class _QuoteDisplayScreenState extends State<QuoteDisplayScreen> {
  var controller = Get.find<HomePageController>();

  var themeController = Get.find<ThemeController>();

  var data = Get.arguments;
  var quote, author, category;
  var playing =false.obs;
  FlutterTts ftts = FlutterTts();

  @override
  void initState() {
    // TODO: implement initState
    // print("data: ${data[1]['second']}");
    author = "${data[0]['first']}";
    quote = "${data[1]['second']}";
    category = "${data[2]['third']}";
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
    playing.value=false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category,
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
        decoration: BoxDecoration(
          gradient: themeController.isDarkMode.isFalse
              ? LinearGradient(
                  colors: [Color(0xFF4051A9), Color(0xFF9354B9)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.1, 0.9])
              : null,
          color: themeController.isDarkMode.isTrue ? Colors.black12 : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: themeController.isDarkMode.isFalse
                            ? Colors.black
                            : Colors.white)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        quote.toString(),
                        textAlign: TextAlign.start,
                        style: GoogleFonts.spaceMono(
                          fontSize: 20.0,
                          color: themeController.isDarkMode.isFalse
                              ? Colors.white
                              : Colors.white,
                          // Adjust the font size as needed
                          fontWeight: FontWeight
                              .bold, // Adjust the font weight as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Share.share("$quote}");
                    },
                    icon: const Icon(Icons.share),
                    color: Colors.red,
                  ),
                  IconButton(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: quote))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Copied to your clipboard!')));
                      });
                    },
                    icon: const Icon(Icons.copy),
                    color: Colors.red,
                  ),
                  Obx(()=>
                     IconButton(
                      onPressed: () async {


                        //play text to sp

                        if(playing.value==false){
                          await ftts.speak(quote);
                          playing.value=true;
                        }
                        else{
                          await ftts.stop();
                          playing.value=false;
                        }
                      },
                      icon:const Icon(Icons.volume_up_rounded),
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

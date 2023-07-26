import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotez/Controllers/home_page_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotez/Models/random_quote_model.dart';
import 'package:quotez/Views/Widgets/loader_widget.dart';
import 'package:share/share.dart';
import 'package:card_swiper/card_swiper.dart';
import 'dart:math' as math;
import '../Controllers/theme_controller.dart';
import 'Widgets/categories_widget.dart'; // import this

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  var controller=Get.put(HomePageController());
  var themeController=Get.find<ThemeController>();


  int current = 0;



  @override
  Widget build(BuildContext context) {
    final currentTheme = themeController.currentTheme;

    return SafeArea(
      child: Obx(()=>
         Scaffold(
          appBar: AppBar(
            title: Text("Quotez",style: GoogleFonts.openSans(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white,),),
            elevation: 0,
            flexibleSpace:Container(
              decoration:  BoxDecoration(
                color: themeController.isDarkMode.isFalse?Color(0xFF4051A9):Colors.black12
          ),
            ),
            actions: [
              IconButton(icon: Icon(Icons.light_mode),onPressed: (){
                themeController.toggleTheme();
              },)
            ],
          ),
          body: Obx(()=>
            Container(
              decoration: BoxDecoration(
                  gradient:themeController.isDarkMode.isFalse? LinearGradient(
                      colors: [Color(0xFF4051A9), Color(0xFF9354B9)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.1, 0.9]):null,
                color: themeController.isDarkMode.isTrue?Colors.black12:null,
              ),


              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child:
                  Column(
                    children: [

                      CategoryListWidget(categories: controller.tabsData),

                      Stack(
                        children: [
                          Container(
                            child: Swiper(

                              itemWidth: 600,
                             itemHeight: 500,
                              autoplay: false,
                              loop: false,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.randomQuoteList.length,

                                            layout: SwiperLayout.TINDER,
                                            itemBuilder: (context, index) {
                                              final item = controller.randomQuoteList[index];
                                              return InkWell(
                                                onTap: (){
                                                  // Save the selected item to the database
                                                  controller.saveItemToDatabase(item);
                                                  // Show a message or trigger any other action after saving
                                                  Get.snackbar('Success', 'Item saved to database.');
                                                },
                                                child: Container(
                                                  height: 300,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(30),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.5),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                        offset: Offset(0, 3), // changes position of shadow
                                                      ),
                                                    ],
                                                    color: Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(15.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                          Text("Quotes",style:
                                                            GoogleFonts.openSans(fontSize: 20,fontWeight: FontWeight.bold,color: currentTheme.colorScheme.onPrimary),

                                                          ),
                                                          IconButton(onPressed: () {
                                                            Share.share("${controller.randomQuoteList[index].text}");
                                                          }, icon: const Icon(Icons.share),color: Colors.red,


                                                          )
                                                          ],
                                                        ),
                                                        Spacer(),
                                                        Wrap(
                                                          crossAxisAlignment: WrapCrossAlignment.center,
                                                          children: [
                                                            Transform(
                                                              alignment:Alignment.center,
                                                              transform: Matrix4.rotationY(math.pi),
                                                              child: Icon(
                                                                Icons.format_quote,
                                                                color: Colors.amber,
                                                                size: 30,
                                                              ),
                                                            ),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              "${controller.randomQuoteList[index].text}",
                                                              textAlign: TextAlign.center,
                                                              style:GoogleFonts.poppins(
                                                                fontSize: 25.0,
                                                                color:themeController.isDarkMode.isFalse?Colors.black:Colors.black,
                                                                // Adjust the font size as needed
                                                                fontWeight: FontWeight.bold, // Adjust the font weight as needed
                                                              ),
                                                              maxLines: 5,
                                                            ),
                                                            SizedBox(width: 5),
                                                            Align(
                                                              alignment:Alignment.bottomRight,
                                                              child: Icon(
                                                                Icons.format_quote,
                                                                color: Colors.amber,
                                                                size: 30,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // Text(
                                                        //   "${controller.randomQuoteList[index].text}",
                                                        //   textAlign: TextAlign.center,
                                                        //   style:GoogleFonts.poppins(
                                                        //     fontSize: 25.0,
                                                        //     // Adjust the font size as needed
                                                        //     fontWeight: FontWeight.bold, // Adjust the font weight as needed
                                                        //   ),
                                                        //   maxLines: 5,
                                                        //   ),
                                                        //   style: TextStyle(
                                                        //     fontSize: 40.0,
                                                        //     // Adjust the font size as needed
                                                        //     fontWeight: FontWeight.bold, // Adjust the font weight as needed
                                                        //   ),
                                                        //   maxLines: 5,
                                                        // ),
                                                        Spacer(),
                                                        Spacer(),

                                                        Divider(color: Colors.grey,thickness: 5, indent: 100,
                                                          endIndent: 100,),
                                                        Spacer(),

                                                        Center(
                                                          child: Text("${controller.randomQuoteList[index].author}",style:

                                                              GoogleFonts.openSans(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.blueGrey)
                                                          ),
                                                        ),
                                                        Spacer(),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },

                            ),
                          ),

                        ],
                      ),
                      Align(alignment:Alignment.center,child: controller.isLoading.value==true?CircularProgressIndicator(
                        color: themeController.isDarkMode.isTrue?Colors.amber:Colors.blueGrey,
                      ):SizedBox()),

                    ],
                  ),
                ),
                ),
            ),
          ),
      ),

    );
  }
}

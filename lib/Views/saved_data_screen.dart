import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotez/Views/quote_display_screen.dart';
import '../Controllers/home_page_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../Controllers/theme_controller.dart';

class SavedDataScreen extends StatefulWidget {
  const SavedDataScreen({super.key});

  @override
  State<SavedDataScreen> createState() => _SavedDataScreenState();
}

class _SavedDataScreenState extends State<SavedDataScreen> {

  var controller = Get.find<HomePageController>();
  var themeController=Get.find<ThemeController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("saved:${controller.savedItemsList}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Liked",style: GoogleFonts.inter(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white,),),
          elevation: 0,
          flexibleSpace:Container(
            decoration:  BoxDecoration(
                color: themeController.isDarkMode.isFalse?Color(0xFF4051A9):Colors.black12
            ),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient:themeController.isDarkMode.isFalse? LinearGradient(
                  colors: [Color(0xFF4051A9), Color(0xFF9354B9)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.1, 0.9]):null,
              color: themeController.isDarkMode.isTrue?Colors.black12:null,
            ),

            child: Obx(() {
              if (controller.savedItemsList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network("https://cdni.iconscout.com/illustration/premium/thumb/sorry-item-not-found-3328225-2809510.png"),
                      SizedBox(height: 30,),
                      Text("No items to show",style:GoogleFonts.poppins(fontSize: 20,color: Colors.white),)
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 15.0),
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    itemCount: controller.savedItemsList.length,
                    itemBuilder: (context, index) {
                      final item = controller.savedItemsList[index];
                      return Stack(
                        children: [
                          InkWell(
                            onTap: (){
                              Get.to(QuoteDisplayScreen(),arguments: [{"first": item.author.toString()},
                                {"second": item.text.toString()},
                                {"third": item.category.toString()}
                              ]
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(17.0),
                                child: Center(child: Text("${item.text}",style: GoogleFonts.openSans(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.black),)),
                              ),
                            ),
                          ),
                          Positioned(
                            top:2,
                            right:2,
                            child: GestureDetector(
                              onTap: (){
                                controller.removeItemFromDatabase(item.author.toString());
                              },
                              child: Icon(
                                Icons.close,
                              ),
                            ),
                          ),

                        ],
                      );
                    },
                  ),
                );
                // return ListView.builder(
                //     itemCount: controller.savedItemsList.length,
                //     itemBuilder: (context, index) {
                //       final item = controller.savedItemsList[index];
                //       return ListTile(
                //         title: Text(item.author!),);
                //     });
              }
            }
            )
        )
    );
  }
}

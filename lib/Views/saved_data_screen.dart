import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controllers/home_page_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SavedDataScreen extends StatefulWidget {
  const SavedDataScreen({super.key});

  @override
  State<SavedDataScreen> createState() => _SavedDataScreenState();
}

class _SavedDataScreenState extends State<SavedDataScreen> {

  var controller = Get.find<HomePageController>();

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
          title: Text("Liked",style: GoogleFonts.openSans(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white,),),
          elevation: 0,
          flexibleSpace:Container(
            decoration: const BoxDecoration(
                color: Color(0xFF4051A9)
            ),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF4051A9), Color(0xFF9354B9)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.1, 0.9])),
            child: Obx(() {
              if (controller.savedItemsList.isEmpty) {
                return Center(
                  child: Text('No items in the database.'),
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
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.all(
                                Radius.circular(15))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(child: Text("${item.text}",style: GoogleFonts.openSans(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.black),)),
                        ),
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

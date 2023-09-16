import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotez/Controllers/home_page_controller.dart';
import 'package:quotez/Controllers/theme_controller.dart';
class CategoryListWidget extends StatefulWidget {
  final List<String> categories;

  CategoryListWidget({required this.categories});

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  var controller=Get.find<HomePageController>();
  var themeController=Get.find<ThemeController>();
  int? _selectedIndex;
  String? selectedFruit;
  RxList selectedCategory=[].obs;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(()=>
        //old code with horizontal list
        //  ListView.builder(
        //   scrollDirection: Axis.horizontal,
        //   shrinkWrap: true,
        //   itemCount: widget.categories.length,
        //   itemBuilder: (context, index) {
        //     final category = widget.categories[index];
        //     return Padding(
        //       padding: const EdgeInsets.only(right: 10.0),
        //       child: ChoiceChip(
        //               selected:selectedCategory.contains(category),
        //               selectedColor: Colors.amber,
        //               label: Text(category),
        //               labelStyle: GoogleFonts.inter(fontSize: 15),
        //               onSelected: (bool selected) {
        //
        //                   toggleCategories(category);
        //                 }
        //                 //   controller.selectedFalse[index]=true;
        //                 //   setState(() {
        //                 //     _selectedIndex = index;
        //                 //   });
        //                 //   controller.getQuoteFromCategory(category);
        //                 // }
        //                 // controller.selectedFalse[index]=false;
        //
        //
        //
        //           ),
        //     );
        //   },
        // ),

        Padding(
          padding: const EdgeInsets.only(right: 10.0,top: 10.0),
          child: Scrollbar(
            // thumbVisibility: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(

                  children: [
                    Text("Categories",
                      style:GoogleFonts.inter(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: themeController.isDarkMode.isFalse?Colors.black:Colors.white,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      child: Wrap(
                        direction: Axis.horizontal,
                        runSpacing: 10.0,
                        spacing: 10.0,
                        alignment: WrapAlignment.start,
                        children: controller.tabsData.map((e) {
                          return ChoiceChip(
                              selected:selectedCategory.contains(e),
                              selectedColor: Colors.amber,
                              label: Text(e),
                              labelStyle: GoogleFonts.inter(fontSize: 15),
                              onSelected: (bool selected) {

                                toggleCategories(e);
                              }
                            //   controller.selectedFalse[index]=true;
                            //   setState(() {
                            //     _selectedIndex = index;
                            //   });
                            //   controller.getQuoteFromCategory(category);
                            // }
                            // controller.selectedFalse[index]=false;



                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )

      ),
    );
  }

  //function to toggle chips
  void toggleCategories(String cat){

      if(selectedCategory.contains(cat)){
        selectedCategory.remove(cat);
        controller.getQuoteFromCategory("all");
        print("selectedcat: ${selectedCategory.length}");
      }
      else{
        selectedCategory.clear();
        selectedCategory.add(cat);
        controller.getQuoteFromCategory(cat);
      }
  }
}

/**
 * Padding(
    padding: const EdgeInsets.only(right: 10.0),
    child: ChoiceChip(
    selected:selectedCategory.contains(category),
    selectedColor: Colors.amber,
    label: Text(category),
    labelStyle: GoogleFonts.inter(fontSize: 15),
    onSelected: (bool selected) {

    toggleCategories(category);
    }
    //   controller.selectedFalse[index]=true;
    //   setState(() {
    //     _selectedIndex = index;
    //   });
    //   controller.getQuoteFromCategory(category);
    // }
    // controller.selectedFalse[index]=false;



    ),
    );
 */

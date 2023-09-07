import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotez/Controllers/home_page_controller.dart';
class CategoryListWidget extends StatefulWidget {
  final List<String> categories;

  CategoryListWidget({required this.categories});

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  var controller=Get.find<HomePageController>();
  int? _selectedIndex;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Obx(()=>
        //  ListView.builder(
        //   scrollDirection: Axis.horizontal,
        //   shrinkWrap: true,
        //   itemCount: categories.length,
        //   itemBuilder: (context, index) {
        //     final category = categories[index];
        //     return InkWell(
        //       onTap: () {
        //         controller.getQuoteFromCategory(category);
        //       },
        //       child: Container(
        //         height: 100,
        //         width: 100,
        //         padding: EdgeInsets.all(10),
        //         margin: EdgeInsets.symmetric(horizontal: 5),
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.all(Radius.circular(30)),
        //           border: Border.all(
        //             width: 5,
        //             color: controller.selectedCategory.value == category
        //                 ? Colors.blue // Highlight the selected category
        //                 : Colors.black,
        //           ),
        //         ),
        //         child: Center(child: Text(category)),
        //       ),
        //     );
        //   },
        // ),
        ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget.categories.length,
          itemBuilder: (context, index) {
            final category = widget.categories[index];
            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ChoiceChip(
                      selected: _selectedIndex==index,
                      selectedColor: Colors.amber,
                      label: Text(category),
                      labelStyle: GoogleFonts.inter(fontSize: 15),
                      onSelected: (bool selected) {
                        if(selected){
                          controller.selectedFalse[index]=true;
                          setState(() {
                            _selectedIndex = index;
                          });
                          controller.getQuoteFromCategory(category);
                        }
                        controller.selectedFalse[index]=false;


                      }
                  ),
            );
          },
        ),

      ),
    );
  }
}

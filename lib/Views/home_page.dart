import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:get/get.dart';
import 'package:quotez/Controllers/home_page_controller.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller=Get.put(HomePageController());

   void handleSwipeAction(int index) {
     final item = controller.randomQuoteList[index];
     // You can perform any action based on the swipe direction or item data here
     print('Swiped ${item.author} ${index == 0 ? "right" : "left"}');
   }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    InkWell(onTap: (){
                      controller.getCategories();
                    },child: Icon(Icons.category,size: 20,))
                  ],
                ),
                const SizedBox(height: 20,),
                // Container(
                //   height: 300,
                //   child: Obx(()=>
                //       Swiper(
                //         itemCount: controller.randomQuoteList.length,
                //         itemBuilder: (context, index) {
                //           var i=controller.randomQuoteList[index];
                //           return Card(
                //
                //             // Build your card UI with item data
                //             child: Column(
                //               children: [
                //                  Text("${i.author}"),
                //                Text("${i.text}"),
                //               ],
                //
                //
                //             ),
                //           );
                //         },
                //         loop: false,
                //         onIndexChanged: (index) {
                //           handleSwipeAction(index);
                //           // Handle swipe left or right action here
                //         },
                //       ),
                //   )
                //   ),
                Obx(()=>
                   ListView.builder(
                  itemCount: controller.randomQuoteList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var i=controller.randomQuoteList[index];
                    return  Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        height: 200,
                        child: Card(
                          // Define the shape of the card
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 20,

                          // Define how the card's content should be clipped
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          // Define the child widget of the card
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Add padding around the row widget
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Add an image widget to display an image
                                    Image.network(
                                     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3fvR2JwcxPaBzR6CA0__Xlwom2o03z-8uqgezbdsrRA&s",
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    // Add some spacing between the image and the text
                                    // Add an expanded widget to take up the remaining horizontal space
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          // Add some spacing between the top of the card and the title
                                          Container(height: 5),
                                          // Add a title widget
                                          Text(
                                            "${i.text}",
                                          ),
                                          // Add some spacing between the title and the subtitle
                                          Container(height: 5),
                                          // Add a subtitle widget
                                          Text(
                                            "${i.author}",
                                          ),
                                          // Add some spacing between the subtitle and the text
                                          // Add a text widget to display some text
                                          Text(
                                            "adsdsa",
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],),
                        ),
                      ),
                    );}
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

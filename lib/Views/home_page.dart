import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotez/Controllers/home_page_controller.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  var controller=Get.put(HomePageController());

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
                ListView.builder(
                itemCount: 20,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
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
                                  Container(width: 20),
                                  // Add an expanded widget to take up the remaining horizontal space
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Add some spacing between the top of the card and the title
                                        Container(height: 5),
                                        // Add a title widget
                                        Text(
                                          "Cards Title 1",
                                        ),
                                        // Add some spacing between the title and the subtitle
                                        Container(height: 5),
                                        // Add a subtitle widget
                                        Text(
                                          "Sub title",
                                        ),
                                        // Add some spacing between the subtitle and the text
                                        Container(height: 10),
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


              ],
            ),
          ),
        ),
      ),
    );
  }
}

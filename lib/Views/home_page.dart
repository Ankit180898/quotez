import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotez/Controllers/home_page_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:card_swiper/card_swiper.dart';

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

  int current = 0;



  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Quotez",style: GoogleFonts.openSans(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white,),),
          elevation: 0,
          flexibleSpace:Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF4051A9), Color(0xFF9354B9)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.1, 0.9]),
            ),
          ),
        ),
        backgroundColor: Color(0xff191922),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF4051A9), Color(0xFF9354B9)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.1, 0.9])),

          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Obx(()=>
              Stack(
                children: [

                  Container(
                    child: Swiper(

                      itemWidth: 600,
                     itemHeight: 500,
                      itemCount: controller.randomQuoteList.length,
                                    layout: SwiperLayout.TINDER,
                                    itemBuilder: (context, index) {
                                      return Container(
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
                                                  GoogleFonts.openSans(fontSize: 20,fontWeight: FontWeight.bold),

                                                ),
                                                IconButton(onPressed: () {
                                                  Share.share("${controller.randomQuoteList[index].text}");
                                                }, icon: const Icon(Icons.share),color: Colors.red,


                                                )
                                                ],
                                              ),
                                              Spacer(),
                                              Text(
                                                "${controller.randomQuoteList[index].text}",
                                                textAlign: TextAlign.center,
                                                style:GoogleFonts.poppins(
                                                  fontSize: 25.0,
                                                  // Adjust the font size as needed
                                                  fontWeight: FontWeight.bold, // Adjust the font weight as needed
                                                ),
                                                maxLines: 5,
                                                ),
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
                                      );
                                    },

                    ),
                  ),

                  Center(child: controller.isLoading.value==true?CircularProgressIndicator():SizedBox())
                ],
              ),
            ),
            ),
        ),

        ),

    );
  }
}

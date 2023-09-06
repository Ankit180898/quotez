import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Widgets/bottom_nav.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  final List<Color> colorList=[
    Color(0xffFFC3A6),
    Color(0xFFFFFF),
    Color(0xffFFC3A6),

  ];

  final List<String> imageList = [
    "https://cdn.dribbble.com/users/115278/screenshots/16812737/media/93914b7224e59946c61b9dbde7542628.gif",
    "https://cdn.dribbble.com/users/115278/screenshots/16812737/media/93914b7224e59946c61b9dbde7542628.gif",
    "https://cdn.dribbble.com/users/115278/screenshots/16812737/media/93914b7224e59946c61b9dbde7542628.gif",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFC3A6),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Spacer(),
            CarouselSlider(


              options: CarouselOptions(
                enlargeCenterPage: false,
                enableInfiniteScroll: false,
                autoPlay: true,
              ),
              items: imageList
                  .map((e) => FadeInRight(duration: Duration(milliseconds: 1500),child: Image.network(e,fit: BoxFit.cover,)),
              )
                  .toList(),
            ),
            Spacer(),
            FadeInUp(
              duration: Duration(milliseconds: 1000),
              delay: Duration(milliseconds: 500),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(60),topLeft:Radius.circular(60) )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      delay: Duration(milliseconds: 1000),
                      child: Text("📖 Discover Wisdom:",
                      style: GoogleFonts.poppins(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      delay: Duration(milliseconds: 1000),
                      child: Text("Let these words of wisdom motivate \nand empower you on your journey.",
                        style: GoogleFonts.openSans(color: Colors.grey.shade600,fontSize: 14,),
                      ),
                    ),
                    Spacer(),
                    FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      delay: Duration(milliseconds: 1000),
                      child: Align(alignment: Alignment.bottomRight,child: TextButton(onPressed: (){
                        Get.offAll(BottomNav());
                      }, child: Text("EXPLORE NOW",style:GoogleFonts.poppins(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold),))),
                    ),
                    Spacer(),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

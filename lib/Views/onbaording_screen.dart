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
    const Color(0xffFFC3A6),
    const Color(0x00ffffff),
    const Color(0xffFFC3A6),

  ];

  final List<String> imageList = [
    "https://cdn.dribbble.com/users/2096933/screenshots/4340168/media/4cedd56ba8f429e9869ea024d7989c32.gif",
    "https://cdn.dribbble.com/users/2096933/screenshots/4340168/media/4cedd56ba8f429e9869ea024d7989c32.gif",
    "https://cdn.dribbble.com/users/2096933/screenshots/4340168/media/4cedd56ba8f429e9869ea024d7989c32.gif",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd7f2f2),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(),
            CarouselSlider(


              options: CarouselOptions(
                enlargeCenterPage: false,
                enableInfiniteScroll: false,
                autoPlay: true,
              ),
              items: imageList
                  .map((e) => FadeInRight(duration: const Duration(milliseconds: 1500),child: Image.network(e,fit: BoxFit.cover,)),
              )
                  .toList(),
            ),
            const Spacer(),
            FadeInUp(
              duration: const Duration(milliseconds: 1000),
              delay: const Duration(milliseconds: 500),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.30,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(60),topLeft:Radius.circular(60) )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      delay: const Duration(milliseconds: 1000),
                      child: Text("📖 Discover Wisdom:",
                      style: GoogleFonts.poppins(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),
                      ),
                    ),

                    FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      delay: const Duration(milliseconds: 1000),
                      child: Text("Let these words of wisdom motivate \nand empower you on your journey.",
                        style: GoogleFonts.openSans(color: Colors.grey.shade600,fontSize: 14,),
                      ),
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      delay: const Duration(milliseconds: 1000),
                      child: Align(alignment: Alignment.bottomRight,child: TextButton(onPressed: (){
                        Get.offAll(const BottomNav());
                        // Get.offAll(KhushiScreen());
                      }, child: Text("EXPLORE NOW",style:GoogleFonts.poppins(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold),))),
                    ),
                    const Spacer(),

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

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quotez/Controllers/home_page_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotez/Views/quote_display_screen.dart';
import 'package:share/share.dart';
import 'package:card_swiper/card_swiper.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;
import '../Controllers/theme_controller.dart';
import 'Widgets/categories_widget.dart'; // import this
import 'package:path_provider/path_provider.dart';

import 'Widgets/common_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var controller = Get.put(HomePageController());
  var themeController = Get.find<ThemeController>();
  GlobalKey previewContainer = GlobalKey();

  int current = 0;

  var textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentTheme = themeController.currentTheme;

    return SafeArea(
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            title: Text(
              "Quotez",
              style: GoogleFonts.inter(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  color: themeController.isDarkMode.isFalse
                      ? Color(0xFF4051A9)
                      : Colors.black12),
            ),
            actions: [
              IconButton(
                icon: themeController.isDarkMode.isTrue
                    ? Icon(Icons.light_mode)
                    : Icon(Icons.dark_mode),
                onPressed: () {
                  themeController.toggleTheme();
                },
              )
            ],
          ),

          body: Obx(
            () => SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: themeController.isDarkMode.isFalse
                      ? LinearGradient(
                          colors: [Color(0xFF4051A9), Color(0xFF9354B9)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.1, 0.9])
                      : null,
                  color:
                      themeController.isDarkMode.isTrue ? Colors.black12 : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(onPressed: (){
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return CategoryListWidget(categories: controller.tabsData);
                              },
                            );
                          }, icon: Icon(Icons.filter_list_rounded,
                            color: themeController.isDarkMode.isFalse
                                ? Colors.white
                                : Colors.white,
                            size: 25,
                          )),
                          IconButton(onPressed: (){
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: BottomSheetExample(),
                                ),
                              ),
                            );
                          }, icon: Icon(
                            Icons.search_rounded,
                            color: themeController.isDarkMode.isFalse
                                ? Colors.white
                                : Colors.white,
                            size: 25,
                          ),),
                          // Obx(()=>
                          //     FloatingActionButton(
                          //       autofocus: false,
                          //       backgroundColor: themeController.isDarkMode.isFalse
                          //           ? const Color(0xFF9365C6).withOpacity(0.9)
                          //           : Colors.blueGrey,
                          //       elevation: 6,
                          //       onPressed: () {
                          //         showModalBottomSheet(
                          //           context: context,
                          //           isScrollControlled: true,
                          //           builder: (context) => SingleChildScrollView(
                          //             child: Container(
                          //               padding: EdgeInsets.only(
                          //                   bottom: MediaQuery.of(context)
                          //                       .viewInsets
                          //                       .bottom),
                          //               child: BottomSheetExample(),
                          //             ),
                          //           ),
                          //         );
                          //       },
                          //       child: Icon(
                          //         Icons.search_rounded,
                          //         color: themeController.isDarkMode.isFalse
                          //             ? Colors.white
                          //             : Colors.white,
                          //         size: 25,
                          //       ),
                          //     ),
                          // ),
                        ],
                      ),
                      // CategoryListWidget(categories: controller.tabsData),
                      Stack(
                        children: [
                          RepaintBoundary(
                            key: previewContainer,
                            child: Container(
                              child: Swiper(
                                itemWidth:
                                    MediaQuery.of(context).size.height * 0.80,
                                itemHeight:
                                    MediaQuery.of(context).size.height * 0.60,
                                autoplay: false,
                                loop: false,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.randomQuoteList.length,
                                layout: SwiperLayout.TINDER,
                                itemBuilder: (context, index) {
                                  final item =
                                      controller.randomQuoteList[index];

                                  return InkWell(
                                    onTap: () {
                                      print("item: ${item.text}");
                                      Get.to(QuoteDisplayScreen(), arguments: [
                                        {"first": item.author.toString()},
                                        {"second": item.text.toString()},
                                        {"third": item.category.toString()}
                                      ]);
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Quotes",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: themeController
                                                              .isDarkMode
                                                              .isFalse
                                                          ? Colors.black
                                                          : Colors.black),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    _captureSocialPng(
                                                        item.author.toString());
                                                    // Share.share("${controller.randomQuoteList[index].text}");
                                                  },
                                                  icon: const Icon(Icons.share),
                                                  color: Colors.red,
                                                )
                                              ],
                                            ),
                                            Spacer(),
                                            Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                Transform(
                                                  alignment: Alignment.center,
                                                  transform: Matrix4.rotationY(
                                                      math.pi),
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
                                                  style: GoogleFonts.spaceMono(
                                                    fontSize: 25.0,
                                                    color: themeController
                                                            .isDarkMode.isFalse
                                                        ? Colors.black
                                                        : Colors.black,
                                                    // Adjust the font size as needed
                                                    fontWeight: FontWeight
                                                        .bold, // Adjust the font weight as needed
                                                  ),
                                                  maxLines: 5,
                                                ),
                                                SizedBox(width: 5),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
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
                                            Divider(
                                              color: Colors.grey,
                                              thickness: 5,
                                              indent: 100,
                                              endIndent: 100,
                                            ),
                                            Spacer(),

                                            Center(
                                              child: Text(
                                                  "${controller.randomQuoteList[index].author}",
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blueGrey)),
                                            ),
                                            Spacer(),
                                            IconButton(
                                              onPressed: () {
                                                // Save the selected item to the database
                                                controller
                                                    .saveItemToDatabase(item);
                                                // Show a message or trigger any other action after saving
                                                Get.snackbar('Success',
                                                    'Item saved to database.');
                                              },
                                              icon: Icon(Icons.bookmark),
                                              iconSize: 40,
                                              color: themeController
                                                      .isDarkMode.isFalse
                                                  ? Colors.black
                                                  : Colors.black,
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
                          ),
                        ],
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: controller.isLoading.value == true
                              ? CircularProgressIndicator(
                                  color: themeController.isDarkMode.isTrue
                                      ? Colors.amber
                                      : Colors.blueGrey,
                                )
                              : SizedBox()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _captureSocialPng(String name) {
    List<String> imagePaths = [];
    final RenderBox box = context.findRenderObject() as RenderBox;
    return Future.delayed(const Duration(milliseconds: 20), () async {
      RenderRepaintBoundary? boundary = previewContainer.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage(pixelRatio: 3.0);
      final directory = (await getApplicationDocumentsDirectory());
      final String path = directory.path;
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      File imgFile = File('$path/$name.png');
      imagePaths.add(imgFile.path);
      imgFile.writeAsBytes(pngBytes).then((value) async {
        await Share.shareFiles(imagePaths,
            subject: 'Share',
            text: 'Check this Out!',
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      }).catchError((onError) {
        print(onError);
      });
    });
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:get/get.dart';
// import 'package:quotez/Controllers/theme_controller.dart';
// import 'package:quotez/Views/home_page.dart';
// import 'package:quotez/Views/saved_data_screen.dart';
// import 'package:quotez/Views/search_screen.dart';

// var  HideBottomAppBarController=ScrollController();

// class BottomNav extends StatefulWidget {
//   const BottomNav({super.key});

//   @override
//   State<BottomNav> createState() => _BottomNavState();
// }

// class _BottomNavState extends State<BottomNav>
//     with SingleTickerProviderStateMixin {

//   var _isVisible;
//   final int _selectedIndex = 0;
//   int index_x = 0;
//   var controller = Get.find<ThemeController>();


//   var _visible;
//   var initialIndex = 0;

//   TabController? _tabController;

//   @override
//   initState() {
//     super.initState();
//     _tabController =
//         TabController(length: 2, vsync: this, initialIndex: initialIndex);
//     _isVisible = true;
//     HideBottomAppBarController = ScrollController();
//     HideBottomAppBarController.addListener(() {
//       if (HideBottomAppBarController.position.userScrollDirection ==
//           ScrollDirection.reverse) {
//         setState(() {
//           _isVisible = false;
//         });
//       }
//       if (HideBottomAppBarController.position.userScrollDirection ==
//           ScrollDirection.forward) {
//         setState(() {
//           _isVisible = true;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _tabController?.dispose();
//   }

//   final screens = [
//     const HomePage(),
//     SearchScreen(),
//     const SavedDataScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       index_x = index;
//     });
//   }
//   //previous bottom nav bar
//   // @override
//   // Widget build(BuildContext context) {
//   //   Size size = MediaQuery.of(context).size;
//   //   return SafeArea(
//   //     child: Obx(()=>
//   //       Scaffold(
//   //         body: screens[index_x],
//   //         bottomNavigationBar: Container(
//   //           color:controller.isDarkMode.isFalse?Color(0xFF9354B9):Colors.black12,
//   //           child: Padding(
//   //             padding: const EdgeInsets.all(20.0),
//   //             child: Container(
//   //               height: 70,
//   //               child: ClipRRect(
//   //                 borderRadius: BorderRadius.circular(30),
//   //                 child: BottomNavigationBar(
//   //
//   //                   elevation: 10.0,
//   //                   backgroundColor: controller.isDarkMode.isFalse?Color(0xFF4051A9):Colors.amber,
//   //                   items: <BottomNavigationBarItem>[
//   //                     BottomNavigationBarItem(
//   //                       icon: Icon(Icons.home_rounded),
//   //                       label: 'Home',
//   //                     ),
//   //                     BottomNavigationBarItem(
//   //                       icon: Icon(Icons.bookmark),
//   //                       label: 'Saved',
//   //                     ),
//   //                   ],
//   //                   type: BottomNavigationBarType.fixed,
//   //                   currentIndex: index_x,
//   //                   selectedItemColor: Colors.white,
//   //                   unselectedItemColor: Colors.black.withOpacity(0.5),
//   //                   selectedLabelStyle: const TextStyle(
//   //                     color: Colors.black,
//   //                     fontFamily: 'Roboto',
//   //                     fontWeight: FontWeight.w200,
//   //                     fontSize: 14,
//   //                   ),
//   //                   unselectedLabelStyle: TextStyle(
//   //                     color: Colors.amber,
//   //                     fontSize: 12,
//   //                   ),
//   //                   iconSize: 30,
//   //                   onTap: _onItemTapped,
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }

//   //floating bottom nav bar
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//           body: TabBarView(
//             clipBehavior: Clip.none,
//             physics: const NeverScrollableScrollPhysics(),
//             controller: _tabController,
//             children: const <Widget>[
//               HomePage(),
//               // SearchScreen(),
//               SavedDataScreen(),
//             ],
//           ),
//           floatingActionButtonLocation:
//               FloatingActionButtonLocation.centerFloat,
//           floatingActionButton: Padding(
//             padding: const EdgeInsets.all(30.0),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 70),
//               height: _isVisible ? 70.0 : 0.0,
//                 child: _isVisible==true?Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     Obx(()=>
//                        Container(
//                          width: MediaQuery.of(context).size.width * 0.50,
//                         decoration: BoxDecoration(
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(80.0)),
//                             color: controller.isDarkMode.isFalse
//                                 ? const Color(0xFF9365C6)
//                                 : Colors.blueGrey,
//                             border: Border.all(
//                                 color: controller.isDarkMode.isFalse
//                                     ? Colors.transparent
//                                     : Colors.white,
//                                 width: 2)),
//                         child: Stack(
//                           clipBehavior: Clip.none,
//                           alignment: Alignment.center,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: TabBar(
//                                 dividerColor: Colors.transparent,
//                                 indicatorColor: Colors.transparent,
//                                 labelColor: controller.isDarkMode.isFalse
//                                     ? Colors.black54
//                                     : Colors.amber,
//                                 unselectedLabelColor: Colors.white,
//                                 labelStyle: const TextStyle(fontSize: 10.0),
//                                 tabs: const <Widget>[
//                                   Tab(
//                                     icon: Icon(
//                                       Icons.home_rounded,
//                                       size: 30,
//                                     ),
//                                   ),
//                                   // Tab(
//                                   //   icon: Icon(
//                                   //     Icons.search_rounded,
//                                   //     size: 30,
//                                   //   ),
//                                   // ),
//                                   Tab(
//                                     icon: Icon(
//                                       Icons.bookmark,
//                                       size: 30,
//                                     ),
//                                   ),
//                                 ],
//                                 controller: _tabController,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     // Positioned(
//                     //     left: 0,
//                     //     right: 0,
//                     //     bottom: 35,
//                     //     child: Padding(
//                     //       padding:
//                     //           const EdgeInsets.only(left: 135.0, right: 135),
//                     //       child: Obx(()=>
//                     //         FloatingActionButton(
//                     //           autofocus: false,
//                     //           shape: CircleBorder(
//                     //             side: BorderSide(
//                     //               color: controller.isDarkMode.isFalse?Colors.white12:Colors.white,
//                     //               width: 2
//                     //             )
//                     //           ),
//                     //           backgroundColor: controller.isDarkMode.isFalse
//                     //               ? const Color(0xFF9365C6).withOpacity(0.9)
//                     //               : Colors.blueGrey,
//                     //           elevation: 6,
//                     //           onPressed: () {
//                     //             showModalBottomSheet(
//                     //               context: context,
//                     //               isScrollControlled: true,
//                     //               builder: (context) => SingleChildScrollView(
//                     //                 child: Container(
//                     //                   padding: EdgeInsets.only(
//                     //                       bottom: MediaQuery.of(context)
//                     //                           .viewInsets
//                     //                           .bottom),
//                     //                   child: BottomSheetExample(),
//                     //                 ),
//                     //               ),
//                     //             );
//                     //           },
//                     //           child: Icon(
//                     //             Icons.search_rounded,
//                     //             color: controller.isDarkMode.isFalse
//                     //                 ? Colors.white
//                     //                 : Colors.white,
//                     //             size: 25,
//                     //           ),
//                     //         ),
//                     //       ),
//                     //     ))
//                   ],
//                 ):const Text(""),
//               ),
//           )),
//     );
//   }
// }

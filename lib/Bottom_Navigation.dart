import 'package:flavour_verse/Category/Category.dart';
import 'package:flavour_verse/Intro%20Screens/Intro_Screen1.dart';
import 'package:flavour_verse/Search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Auth/userProfile.dart';
import 'Explore.dart';


class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;

  void pageShifter(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> myScreens = [
    const Explore(),
    const Category(),
    const Search(),
    const userProfile(),
    // IntroScreen2(),
  ];

  List<Widget> logScreens = [
    const Explore(),
    const userProfile(),
    const Search(),
    const IntroScreen1(),
    // IntroScreen2(),
  ];

  IconData _getIconData(int index) {
    switch (index) {
      case 0:
        return Icons.home_outlined;
      case 1:
        return Icons.dashboard_rounded;
      case 2:
        return Icons.search_outlined;
      case 3:
        return  Icons.person_outlined;
      default:
        return Icons.home_outlined;
    }
  }

  String _getTextLabel(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Category';
      case 2:
        return 'Search';
      case 3:
        return 'Profile';
      default:
        return '';
    }
  }


  Future login_user() async {
    SharedPreferences userLoginDetails = await SharedPreferences.getInstance();
    return userLoginDetails.getString("UserLoggedIn");
  }

  List<bool> _isSelected = [true, false, false, false];

  String? check;

  @override
  void initState() {
    // TODO: implement initState
    login_user().then((value) {
      setState(() {
        check = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: Stack(
        fit: StackFit.expand,
        children: [
          check!=null?myScreens[selectedIndex]:logScreens[selectedIndex],


          /// Bottom Navigation bar items
          Positioned(
              bottom: 18,
              left: 0,
              right: 0,
              height: 56,
              child:Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20,left: 40),
                    width: 304,
                    height: 15,
                    color: Theme.of(context).colorScheme.primary,
                  ),

                Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [

                  for (int i = 0; i < myScreens.length; i++)
                    GestureDetector(
                      onTap:(){
                        pageShifter(i);
                        setState(() {
                          _isSelected = [false, false, false, false];
                          _isSelected[i] = true;
                          selectedIndex = i;
                        });

                      },
                      child: Container(
                        width: _isSelected[i] ? 125 : 55,
                        margin: _isSelected[i] ? const EdgeInsets.only(left: 20) : const EdgeInsets.only(left: 20) ,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          // shape: _isSelected ? BoxShape.rectangle : BoxShape.circle,
                          // border:
                          // Border.all(width: 2, color: theme.scaffoldBackgroundColor),
                          borderRadius: _isSelected[i] ? BorderRadius.circular(20) : BorderRadius.circular(100) ,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Container(
                          width: _isSelected[i] ? 125 : 45,
                          // height: 50,
                          padding:_isSelected[i] ? const EdgeInsets.all(2):const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: _isSelected[i] ?Theme.of(context).colorScheme.primary: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: _isSelected[i] ? BorderRadius.circular(20) : BorderRadius.circular(100) ,
                            // shape: BoxShape.circle
                          ),
                          child: Row(
                            children: [
                              Icon(_getIconData(i),color: selectedIndex == i ? theme.primaryColor : theme.colorScheme.background,),
                              _isSelected[i]  ? const SizedBox(width: 5,):const SizedBox(width: 0,),
                              // _isSelected[i]  ? Text(_getTextLabel(i)): Text(""),
                              Center(
                                child: Text(_isSelected[i]  ?_getTextLabel(i): "",style:
                                GoogleFonts.poppins(
                                    color: const Color(0xffffffff),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                ),),
                              )
                            ],
                          ),

                        ),
                      ),
                    ),




                ],
              ),
        ],
              ),

    )],
      ),


    );
  }
}

















// import 'dart:ui';
// import 'package:flavour_verse/Intro%20Screens/Intro_Screen1.dart';
// import 'package:flavour_verse/Intro%20Screens/Intro_Screen2.dart';
// import 'package:flavour_verse/Search.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:zoom_tap_animation/zoom_tap_animation.dart';
//
// import 'Auth/userProfile.dart';
// import 'Explore.dart';
//
//
// class BottomNavigation extends StatefulWidget {
//   const BottomNavigation({super.key});
//
//   @override
//   State<BottomNavigation> createState() => _BottomNavigationState();
// }
//
// class _BottomNavigationState extends State<BottomNavigation> {
//   int selectedIndex = 0;
//
//   void pageShifter(index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }
//
//   List<Widget> myScreens = [
//     Explore(),
//     userProfile(),
//     Search(),
//     IntroScreen1(),
//     IntroScreen2(),
//   ];
//
//   List<Widget> logScreens = [
//     Explore(),
//     userProfile(),
//     Search(),
//     IntroScreen1(),
//     IntroScreen2(),
//   ];
//
//   Future login_user() async {
//     SharedPreferences userLoginDetails = await SharedPreferences.getInstance();
//     return userLoginDetails.getString("UserLoggedIn");
//   }
//
//   String? check;
//
//   void initState() {
//     // TODO: implement initState
//     login_user().then((value) {
//       setState(() {
//         check = value;
//       });
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ThemeData theme = Theme.of(context);
//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           check != null ? myScreens[selectedIndex] : logScreens[selectedIndex],
//
//           /// Custom Bottom Navigation Bar
//           // Positioned(
//           //   bottom: 18,
//           //   left: 18,
//           //   right: 18,
//           //   height: 56,
//           //   child: Container(
//           //     decoration: BoxDecoration(
//           //       // border:
//           //       // Border.all(width: 2, color: theme.scaffoldBackgroundColor),
//           //       borderRadius: const BorderRadius.only(
//           //           topRight: Radius.circular(150),
//           //           topLeft: Radius.circular(150),
//           //           bottomLeft: Radius.circular(150),
//           //           bottomRight: Radius.circular(150)),
//           //       color: theme.scaffoldBackgroundColor.withOpacity(0.9),
//           //     ),
//           //     // child: ClipRRect(
//           //     //   borderRadius: const BorderRadius.only(
//           //     //       topRight: Radius.circular(24),
//           //     //       topLeft: Radius.circular(24),
//           //     //       bottomLeft: Radius.circular(52),
//           //     //       bottomRight: Radius.circular(52)),
//           //     //   child: ClipPath(
//           //     //
//           //     //     child: BackdropFilter(
//           //     //       filter: ImageFilter.blur(sigmaY: 2, sigmaX: 5),
//           //     //       child: Container(),
//           //     //     ),
//           //     //   ),
//           //     // ),
//           //   ),
//           // ),
//
//           /// Bottom Navigation bar items
//           Positioned(
//             bottom: 18,
//             left: 0,
//             right: 0,
//             height: 56,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 for (int i = 0; i < myScreens.length; i++)
//                   GestureDetector(
//                     onTap: () {
//                       pageShifter(i);
//                     },
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Stack(
//                           children: [
//
//                             Container(
//                               height: 50,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: theme.colorScheme.primary,
//                               ),
//                               child: Stack(
//                                 children: [
//                                   Icon(
//                                     _getIconData(i),
//                                     color: selectedIndex == i ? theme.primaryColor : theme.colorScheme.secondary,
//                                   ),
//                                   Visibility(
//                                     visible: selectedIndex == i,
//                                     child: Positioned.fill(
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         padding: EdgeInsets.symmetric(horizontal: 4),
//                                         color: theme.colorScheme.primary,
//                                         child: Text(
//                                           _getTextLabel(i),
//                                           style: TextStyle(
//                                             color: theme.primaryColor,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//
//
//
//                             //       Container(
//                       //   margin: EdgeInsets.only(top: 20),
//                       //   width: 24,
//                       //   height: 15,
//                       //   color: Theme.of(context).colorScheme.primary,
//                       // ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   IconData _getIconData(int index) {
//     switch (index) {
//       case 0:
//         return Icons.home_outlined;
//       case 1:
//         return Icons.person_outlined;
//       case 2:
//         return Icons.search_outlined;
//       case 3:
//         return Icons.info_outlined;
//       case 4:
//         return Icons.info_outlined;
//       default:
//         return Icons.home_outlined;
//     }
//   }
//
//   String _getTextLabel(int index) {
//     switch (index) {
//       case 0:
//         return 'Home';
//       case 1:
//         return 'Profile';
//       case 2:
//         return 'Search';
//       case 3:
//         return 'Intro1';
//       case 4:
//         return 'Intro2';
//       default:
//         return '';
//     }
//   }
// }














//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// // import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:google_nav_bar/google_nav_bar.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // import 'Auth/userProfile.dart';
// // import 'Explore.dart';
// //
// // class bottomNavigation extends StatefulWidget {
// //   const bottomNavigation({super.key});
// //
// //   @override
// //   State<bottomNavigation> createState() => _bottomNavigationState();
// // }
// //
// // class _bottomNavigationState extends State<bottomNavigation> {
// //
// //   int selectedIndex=0;
// //   void pageShifter(index){
// //     setState(() {
// //       selectedIndex=index;
// //     });
// //   }
// //
// //   List<Widget> myScreens=[
// //     Explore(),
// //     userProfile()
// //   ];
// //
// //   List<Widget> logScreens=[
// //     Explore(),
// //     userProfile()
// //     // HomePage(),
// //     // AddtoCart(),
// //     // favourite(),
// //     // profile(),
// //   ];
// //   Future login_user()async{
// //     SharedPreferences userLoginDetails = await SharedPreferences.getInstance();
// //     return userLoginDetails.getString("UserLoggedIn");
// //   }
// //
// //   String? check;
// //   void initState() {
// //     // TODO: implement initState
// //     login_user().then((value){
// //       setState((){
// //         check = value;
// //       });
// //     });
// //     super.initState();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       // backgroundColor: Theme.of(context).colorScheme.background,
// //       body:check!=null?myScreens[selectedIndex]:logScreens[selectedIndex],
// //
// //
// //
// //       bottomNavigationBar:check!=null? Padding(
// //         padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
// //         child: GNav(
// //           gap: 8,
// //           activeColor: Theme.of(context).primaryColor,
// //           tabBackgroundColor: Theme.of(context).colorScheme.background,
// //           padding: EdgeInsets.all(16),
// //           onTabChange: (index){
// //            index== selectedIndex;
// //           },
// //           tabs:const [
// //             GButton(
// //               icon: Icons.bolt_sharp,
// //               text: "Explore",
// //             ),
// //
// //             GButton(icon: Icons.person_2_outlined,text: "Profile",)
// //           ]
// //             ),
// //       ):
// //       Container(
// //         decoration: BoxDecoration(
// //           // color: Theme.of(context).colorScheme.primary,
// //           borderRadius: BorderRadius.circular(100),
// //         ),
// //         child: Padding(
// //           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
// //           child: Container(
// //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(150),),
// //             child: GNav(
// //                 gap: 8,
// //                 activeColor: Theme.of(context).primaryColor,
// //                 tabBackgroundColor: Theme.of(context).colorScheme.background,
// //                 padding: EdgeInsets.all(16),
// //                 onTabChange: (index){
// //                   index== selectedIndex;
// //                 },
// //                 tabs:[
// //                   GButton(icon: Icons.bolt_sharp,text: "Explore",),
// //                   GButton(icon: Icons.person_2_outlined,text: "Profile",)
// //                 ]
// //
// //             ),
// //           ),
// //         ),
// //       )
// //
// //
// //     );
// //   }
// // }
// //
//
//
//
//
//
//
//
//
//
//
// // import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:meal_db/Auth/userProfile.dart';
// // import 'package:meal_db/Explore.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // class bottomNavigation extends StatefulWidget {
// //   const bottomNavigation({super.key});
// //
// //   @override
// //   State<bottomNavigation> createState() => _bottomNavigationState();
// // }
// //
// // class _bottomNavigationState extends State<bottomNavigation> {
// //
// //   int selectedIndex=0;
// //   void pageShifter(index){
// //     setState(() {
// //       selectedIndex=index;
// //     });
// //   }
// //
// //   List<Widget> myScreens=[
// //     Explore(),
// //     userProfile()
// //   ];
// //
// //   List<Widget> logScreens=[
// //     Explore(),
// //     userProfile()
// //     // HomePage(),
// //     // AddtoCart(),
// //     // favourite(),
// //     // profile(),
// //   ];
// //   Future login_user()async{
// //     SharedPreferences userLoginDetails = await SharedPreferences.getInstance();
// //     return userLoginDetails.getString("UserLoggedIn");
// //   }
// //
// //   String? check;
// //   void initState() {
// //     // TODO: implement initState
// //     login_user().then((value){
// //       setState((){
// //         check = value;
// //       });
// //     });
// //     super.initState();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Theme.of(context).colorScheme.background,
// //       body:check!=null?myScreens[selectedIndex]:logScreens[selectedIndex],
// //
// //
// //
// //       bottomNavigationBar:check!=null? CurvedNavigationBar(
// //           index: selectedIndex,
// //           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
// //           color: Theme.of(context).colorScheme.background,
// //           onTap: pageShifter,
// //           items: [
// //             Icon(Icons.bolt_sharp, color: selectedIndex!=0? Color(0xffffffff):
// //             Theme.of(context).primaryColor,),
// //             // Icon(Icons.card_travel,color:  selectedIndex!=1? Color(0xffffffff):
// //             // Color(0xffff4914),),
// //             // Icon(CupertinoIcons.heart,color: selectedIndex!=2? Color(0xffffffff):
// //             // Color(0xffff4914),),
// //             Icon(Icons.person_2_outlined,color:  selectedIndex!=1? Color(0xffffffff):
// //             Theme.of(context).primaryColor,)
// //           ]):
// //       CurvedNavigationBar(
// //           index: selectedIndex,
// //           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
// //           color: Theme.of(context).colorScheme.background,
// //           onTap: pageShifter,
// //           items: [
// //             Icon(Icons.bolt_sharp, color: selectedIndex!=0? Color(0xffffffff):
// //             Theme.of(context).primaryColor,),
// //             // Icon(Icons.card_travel,color:  selectedIndex!=1? Color(0xffffffff):
// //             // Color(0xffff4914),),
// //             // Icon(CupertinoIcons.heart,color: selectedIndex!=2? Color(0xffffffff):
// //             // Color(0xffff4914),),
// //             Icon(Icons.person_2_outlined,color:  selectedIndex!=1? Color(0xffffffff):
// //             Theme.of(context).primaryColor,)
// //           ]),
// //
// //
// //     );
// //   }
// // }
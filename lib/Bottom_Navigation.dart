import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Auth/userProfile.dart';
import 'Explore.dart';

class bottomNavigation extends StatefulWidget {
  const bottomNavigation({super.key});

  @override
  State<bottomNavigation> createState() => _bottomNavigationState();
}

class _bottomNavigationState extends State<bottomNavigation> {

  int selectedIndex=0;
  void pageShifter(index){
    setState(() {
      selectedIndex=index;
    });
  }

  List<Widget> myScreens=[
    Explore(),
    userProfile()
  ];

  List<Widget> logScreens=[
    Explore(),
    userProfile()
    // HomePage(),
    // AddtoCart(),
    // favourite(),
    // profile(),
  ];
  Future login_user()async{
    SharedPreferences userLoginDetails = await SharedPreferences.getInstance();
    return userLoginDetails.getString("UserLoggedIn");
  }

  String? check;
  void initState() {
    // TODO: implement initState
    login_user().then((value){
      setState((){
        check = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.background,
      body:check!=null?myScreens[selectedIndex]:logScreens[selectedIndex],



      bottomNavigationBar:check!=null? Padding(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        child: GNav(
          gap: 8,
          activeColor: Theme.of(context).primaryColor,
          tabBackgroundColor: Theme.of(context).colorScheme.background,
          padding: EdgeInsets.all(16),
          onTabChange: (index){
           index== selectedIndex;
          },
          tabs:const [
            GButton(
              icon: Icons.bolt_sharp,
              text: "Explore",
            ),

            GButton(icon: Icons.person_2_outlined,text: "Profile",)
          ]
            ),
      ):
      Container(
        decoration: BoxDecoration(
          // color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(150),),
            child: GNav(
                gap: 8,
                activeColor: Theme.of(context).primaryColor,
                tabBackgroundColor: Theme.of(context).colorScheme.background,
                padding: EdgeInsets.all(16),
                onTabChange: (index){
                  index== selectedIndex;
                },
                tabs:[
                  GButton(icon: Icons.bolt_sharp,text: "Explore",),
                  GButton(icon: Icons.person_2_outlined,text: "Profile",)
                ]

            ),
          ),
        ),
      )


    );
  }
}











// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:meal_db/Auth/userProfile.dart';
// import 'package:meal_db/Explore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class bottomNavigation extends StatefulWidget {
//   const bottomNavigation({super.key});
//
//   @override
//   State<bottomNavigation> createState() => _bottomNavigationState();
// }
//
// class _bottomNavigationState extends State<bottomNavigation> {
//
//   int selectedIndex=0;
//   void pageShifter(index){
//     setState(() {
//       selectedIndex=index;
//     });
//   }
//
//   List<Widget> myScreens=[
//     Explore(),
//     userProfile()
//   ];
//
//   List<Widget> logScreens=[
//     Explore(),
//     userProfile()
//     // HomePage(),
//     // AddtoCart(),
//     // favourite(),
//     // profile(),
//   ];
//   Future login_user()async{
//     SharedPreferences userLoginDetails = await SharedPreferences.getInstance();
//     return userLoginDetails.getString("UserLoggedIn");
//   }
//
//   String? check;
//   void initState() {
//     // TODO: implement initState
//     login_user().then((value){
//       setState((){
//         check = value;
//       });
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       body:check!=null?myScreens[selectedIndex]:logScreens[selectedIndex],
//
//
//
//       bottomNavigationBar:check!=null? CurvedNavigationBar(
//           index: selectedIndex,
//           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//           color: Theme.of(context).colorScheme.background,
//           onTap: pageShifter,
//           items: [
//             Icon(Icons.bolt_sharp, color: selectedIndex!=0? Color(0xffffffff):
//             Theme.of(context).primaryColor,),
//             // Icon(Icons.card_travel,color:  selectedIndex!=1? Color(0xffffffff):
//             // Color(0xffff4914),),
//             // Icon(CupertinoIcons.heart,color: selectedIndex!=2? Color(0xffffffff):
//             // Color(0xffff4914),),
//             Icon(Icons.person_2_outlined,color:  selectedIndex!=1? Color(0xffffffff):
//             Theme.of(context).primaryColor,)
//           ]):
//       CurvedNavigationBar(
//           index: selectedIndex,
//           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//           color: Theme.of(context).colorScheme.background,
//           onTap: pageShifter,
//           items: [
//             Icon(Icons.bolt_sharp, color: selectedIndex!=0? Color(0xffffffff):
//             Theme.of(context).primaryColor,),
//             // Icon(Icons.card_travel,color:  selectedIndex!=1? Color(0xffffffff):
//             // Color(0xffff4914),),
//             // Icon(CupertinoIcons.heart,color: selectedIndex!=2? Color(0xffffffff):
//             // Color(0xffff4914),),
//             Icon(Icons.person_2_outlined,color:  selectedIndex!=1? Color(0xffffffff):
//             Theme.of(context).primaryColor,)
//           ]),
//
//
//     );
//   }
// }
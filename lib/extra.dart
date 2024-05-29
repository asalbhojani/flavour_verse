import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String firstApiUrl = 'https://www.themealdb.com/api/json/v1/1/filter.php?i=';
  final String descriptionApiUrl = 'https://www.themealdb.com/api/json/v1/1/lookup.php?i=';
  final String catName = 'Chicken '; // Example category name
  List<Meal> filteredMeals = [];

  @override
  void initState() {
    super.initState();
    fetchMeals();
  }

  Future<void> fetchMeals() async {
    try {
      final response = await http.get(Uri.parse(firstApiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final meals = data['meals']; // Check if 'meals' is not null
        if (meals != null && meals is List) {
          for (final meal in meals) {
            final mealId = meal['idMeal'];
            if (mealId != null) {
              await fetchMealDetails(mealId);
            }
          }
        }
      } else {
        throw Exception('Failed to load meals');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchMealDetails(String mealId) async {
    try {
      final response = await http.get(Uri.parse('$descriptionApiUrl$mealId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final meals = data['meals']; // Check if 'meals' is not null
        if (meals != null && meals is List && meals.isNotEmpty) {
          final mealCategory = meals[0]['strCategory'];
          if (mealCategory == catName) {
            final mealName = meals[0]['strMeal'];
            setState(() {
              filteredMeals.add(Meal(id: mealId, name: mealName));
            });
          }
        }
      } else {
        throw Exception('Failed to load meal details');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtered Meals'),
      ),
      body: ListView.builder(
        itemCount: filteredMeals.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(filteredMeals[index].name),
          );
        },
      ),
    );
  }
}

class Meal {
  final String id;
  final String name;

  Meal({required this.id, required this.name});
}




















//BOTTOM NAVIGATION

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
//   bool _isSelected = false;
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
//           check!=null?myScreens[selectedIndex]:logScreens[selectedIndex],
//
//
//           /// Bottom Navigation bar items
//           Positioned(
//               bottom: 18,
//               left: 0,
//               right: 0,
//               height: 56,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 // crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Stack(
//                     children: [
//                       GestureDetector(
//                         onTap:(){
//                           pageShifter(0);
//                           _isSelected = !_isSelected;
//
//                         },
//                         child: Container(
//                           width: _isSelected ? 100 : 55,
//                           margin: _isSelected ? EdgeInsets.only(left: 20) : EdgeInsets.only(left: 60) ,
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             // shape: _isSelected ? BoxShape.rectangle : BoxShape.circle,
//                             // border:
//                             // Border.all(width: 2, color: theme.scaffoldBackgroundColor),
//                             borderRadius: _isSelected ? BorderRadius.circular(20) : BorderRadius.circular(100) ,
//                             color: Theme.of(context).colorScheme.primary,
//                           ),
//                           child: Container(
//                             width: _isSelected ? 80 : 45,
//                             // height: 50,
//                             padding: EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).scaffoldBackgroundColor,
//                               borderRadius: _isSelected ? BorderRadius.circular(20) : BorderRadius.circular(100) ,
//                               // shape: BoxShape.circle
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(Icons.home_outlined, color: selectedIndex!=0? Theme.of(context).colorScheme.secondary:
//                                 Theme.of(context).primaryColor,),
//                                 _isSelected  ? Text("Home"): Text(""),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 110,top: 20),
//                         width: 24,
//                         height: 15,
//                         color: Theme.of(context).colorScheme.primary,
//                       ),
//
//                       GestureDetector(
//                         onTap:(){
//                           pageShifter(1);
//                           _isSelected = !_isSelected;
//
//                         },
//                         child: Container(
//                           width: _isSelected ? 100 : 55,
//                           margin: _isSelected ? EdgeInsets.only(left: 80) : EdgeInsets.only(left: 133) ,
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             // shape: _isSelected ? BoxShape.rectangle : BoxShape.circle,
//                             // border:
//                             // Border.all(width: 2, color: theme.scaffoldBackgroundColor),
//                             borderRadius: _isSelected ? BorderRadius.circular(20) : BorderRadius.circular(100) ,
//                             color: Theme.of(context).colorScheme.primary,
//                           ),
//                           child: Container(
//                             width: _isSelected ? 80 : 45,
//                             // height: 50,
//                             padding: EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).scaffoldBackgroundColor,
//                               borderRadius: _isSelected ? BorderRadius.circular(20) : BorderRadius.circular(100) ,
//                               // shape: BoxShape.circle
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(Icons.home_outlined, color: selectedIndex!=1? Theme.of(context).colorScheme.secondary:
//                                 Theme.of(context).primaryColor,),
//                                 _isSelected  ? Text("Profile"): Text(""),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 185,top: 20),
//                         width: 24,
//                         height: 15,
//                         color: Theme.of(context).colorScheme.primary,
//                       ),
//
//                       GestureDetector(
//                         onTap:(){
//                           pageShifter(2);
//                           _isSelected=false;
//                           _isSelected = !_isSelected;
//
//                         },
//                         child: Container(
//                           width: _isSelected ? 100 : 55,
//                           margin: _isSelected ? EdgeInsets.only(left: 260) : EdgeInsets.only(left: 203) ,
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             // shape: _isSelected ? BoxShape.rectangle : BoxShape.circle,
//                             // border:
//                             // Border.all(width: 2, color: theme.scaffoldBackgroundColor),
//                             borderRadius: _isSelected ? BorderRadius.circular(20) : BorderRadius.circular(100) ,
//                             color: Theme.of(context).colorScheme.primary,
//                           ),
//                           child: Container(
//                             width: _isSelected ? 80 : 45,
//                             // height: 50,
//                             padding: EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).scaffoldBackgroundColor,
//                               borderRadius: _isSelected ? BorderRadius.circular(20) : BorderRadius.circular(100) ,
//                               // shape: BoxShape.circle
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(Icons.home_outlined, color: selectedIndex!=2? Theme.of(context).colorScheme.secondary:
//                                 Theme.of(context).primaryColor,),
//                                 _isSelected  ? Text("Home"): Text(""),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 262,top: 20),
//                         width: 24,
//                         height: 15,
//                         color: Theme.of(context).colorScheme.primary,
//                       ),
//
//
//                       GestureDetector(
//                         onTap:(){
//                           pageShifter(3);
//                           _isSelected=false;
//                           _isSelected = !_isSelected;
//
//                         },
//                         child: Container(
//                           width: _isSelected ? 100 : 55,
//                           margin: _isSelected ? EdgeInsets.only(left: 300) : EdgeInsets.only(left: 273) ,
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             // shape: _isSelected ? BoxShape.rectangle : BoxShape.circle,
//                             // border:
//                             // Border.all(width: 2, color: theme.scaffoldBackgroundColor),
//                             borderRadius: _isSelected ? BorderRadius.circular(20) : BorderRadius.circular(100) ,
//                             color: Theme.of(context).colorScheme.primary,
//                           ),
//                           child: Container(
//                             width: _isSelected ? 80 : 45,
//                             // height: 50,
//                             padding: EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).scaffoldBackgroundColor,
//                               borderRadius: _isSelected ? BorderRadius.circular(20) : BorderRadius.circular(100) ,
//                               // shape: BoxShape.circle
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(Icons.home_outlined, color: selectedIndex!=3? Theme.of(context).colorScheme.secondary:
//                                 Theme.of(context).primaryColor,),
//                                 _isSelected  ? Text("Home"): Text(""),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//
//
//
//                     ],
//                   )
//
//                 ],
//               ))
//         ],
//       ),
//
//
//     );
//   }
// }
















// import 'package:flutter/material.dart';
//
//
//
// class MyIconText extends StatefulWidget {
//   @override
//   _MyIconTextState createState() => _MyIconTextState();
// }
//
// class _MyIconTextState extends State<MyIconText> {
//   bool _isSelected = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           _isSelected = !_isSelected;
//         });
//       },
//       child: Container(
//         width: _isSelected ? 150 : 50,
//         padding: EdgeInsets.symmetric(vertical: 12),
//         decoration: BoxDecoration(
//           color: Colors.blue,
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.home,
//               color: Colors.white,
//             ),
//             SizedBox(width: _isSelected ? 10 : 0),
//             Text(
//               _isSelected ? 'Home' : '',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//










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
// class FinalView extends StatefulWidget {
//   const FinalView({super.key});
//
//   @override
//   State<FinalView> createState() => _FinalViewState();
// }
//
// class _FinalViewState extends State<FinalView> {
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
//     userProfile()
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
//           check!=null?myScreens[selectedIndex]:logScreens[selectedIndex],
//
//           /// Custom Bottom Navigation Bar
//           Positioned(
//             bottom: 18,
//             left: 18,
//             right: 18,
//             height: 56,
//             child: Container(
//               decoration: BoxDecoration(
//                 // border:
//                 // Border.all(width: 2, color: theme.scaffoldBackgroundColor),
//                 borderRadius: const BorderRadius.only(
//                     topRight: Radius.circular(150),
//                     topLeft: Radius.circular(150),
//                     bottomLeft: Radius.circular(150),
//                     bottomRight: Radius.circular(150)),
//                 color: theme.scaffoldBackgroundColor.withOpacity(0.8),
//               ),
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                     topRight: Radius.circular(24),
//                     topLeft: Radius.circular(24),
//                     bottomLeft: Radius.circular(52),
//                     bottomRight: Radius.circular(52)),
//                 child: ClipPath(
//
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
//                     child: Container(),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           /// Bottom Navigation bar items
//           Positioned(
//               bottom: 18,
//               left: 0,
//               right: 0,
//               height: 56,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   GestureDetector(
//                     onTap:(){
//                       pageShifter(0);
//                     },
//                     child: Icon(Icons.home_outlined, color: selectedIndex!=0? Color(0xffffffff):
//                                 Theme.of(context).primaryColor,),
//                   ),
//                   GestureDetector(
//                     onTap:(){
//                       pageShifter(1);
//                     },
//                     child: Icon(Icons.apps, color: selectedIndex!=1? Color(0xffffffff):
//                     Theme.of(context).primaryColor,),
//                   ),
//                   GestureDetector(
//                     onTap:(){
//                       pageShifter(2);
//                     },
//                     child: Icon(Icons.apps, color: selectedIndex!=2? Color(0xffffffff):
//                     Theme.of(context).primaryColor,),
//                   ),
//                   GestureDetector(
//                     onTap:(){
//                       pageShifter(3);
//                     },
//                     child: Icon(Icons.apps, color: selectedIndex!=3? Color(0xffffffff):
//                     Theme.of(context).primaryColor,),
//                   ),
//                   GestureDetector(
//                     onTap:(){
//                       pageShifter(4);
//                     },
//                     child: Icon(Icons.apps, color: selectedIndex!=4? Color(0xffffffff):
//                     Theme.of(context).primaryColor,),
//                   ),
//                   // Icon(Icons.notifications_outlined, color: selectedIndex!=0? Color(0xffffffff):
//                   // Theme.of(context).primaryColor,),
//                   // Icon(Icons.settings_outlined,),
//                 ],
//               ))
//         ],
//       ),
//
//
//     );
//   }
// }







































// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My App',
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _selectedIndex = 0;
//
//   final List<Widget> _pages = [
//     Page1(),
//     Page2(),
//     Page3(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _pages[_selectedIndex],
//       ),
//       bottomNavigationBar: Container(
//         height: 60,
//         color: Colors.black,
//         child: Stack(
//           children: [
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 height: 1,
//                 color: Colors.grey,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     color: Colors.grey,
//                   ),
//                   child: IconButton(
//                     icon: Icon(
//                       Icons.home,
//                       size: 24,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       _onItemTapped(0);
//                     },
//                   ),
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.rectangle,
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.grey,
//                   ),
//                   child: IconButton(
//                     icon: Icon(
//                       Icons.business,
//                       size: 24,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       _onItemTapped(1);
//                     },
//                   ),
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.rectangle,
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.grey,
//                   ),
//                   child: IconButton(
//                     icon: Icon(
//                       Icons.school,
//                       size: 24,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       _onItemTapped(2);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class Page1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text('Page 1'),
//     );
//   }
// }
//
// class Page2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text('Page 2'),
//     );
//   }
// }
//
// class Page3 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text('Page 3'),
//     );
//   }
// }
//
//
//
//
//
// // import 'package:flutter/material.dart';
// //
// // class Test extends StatefulWidget {
// //   const Test({super.key});
// //
// //   @override
// //   State<Test> createState() => _TestState();
// // }
// //
// // class _TestState extends State<Test> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Column(
// //         children: [
// //
// //           Container(
// //             margin: EdgeInsets.symmetric(horizontal: 50,vertical: 30),
// //             width: 300,
// //             height: 250,
// //             color: Colors.brown,
// //             child: Stack(
// //               children: [
// //
// //                 Container(
// //                   margin: EdgeInsets.only(top: 90),
// //                   width: 300,
// //                   height: 200,
// //                   decoration: BoxDecoration(
// //                     color: Colors.blue,
// //                     borderRadius: BorderRadius.circular(10),
// //
// //                   ),
// //                 ),
// //
// //                 Container(
// //                   margin: EdgeInsets.only(left: 80),
// //                   width: 150,
// //                   height: 150,
// //                   decoration: BoxDecoration(
// //                     color: Colors.amber,
// //                     borderRadius: BorderRadius.circular(100),
// //
// //                   ),
// //                 ),
// //               ],),
// //           )
// //
// //         ],),
// //     );
// //   }
// // }

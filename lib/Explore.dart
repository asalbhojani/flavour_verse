import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavour_verse/Auth/Login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Tabs/Popular.dart';
import 'Tabs/Recommended.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {

  Future<String?> getUser() async {
    SharedPreferences userLoginDetails = await SharedPreferences.getInstance();
    return userLoginDetails.getString("UserLoggedIn");
  }

  String? uEmail;

  @override
  void initState() {
    super.initState();
    getUser().then((value) {
      setState(() {
        uEmail = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: uEmail == null
              ? Center(child: CircularProgressIndicator())
              : StreamBuilder(
            stream: FirebaseFirestore.instance.collection("userData").where('User-Email', isEqualTo: uEmail).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                var dataLength = snapshot.data!.docs.length;
        
                return dataLength == 0
                    ? Login()
                    : Column(
                  children: [
                    Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20, top: 30),
                                child: Text(
                                  snapshot.data!.docs[0]['User-Name'],
                                  style: GoogleFonts.poppins(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "What would you like",
                                  style: GoogleFonts.poppins(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "to cook today?",
                                  style: GoogleFonts.poppins(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 30, left: 50),
                            child: const CircleAvatar(
                              radius: 30.0,
                              backgroundImage: AssetImage('assets/profile.jpg'),
                            ),
                          ),
                        ]),
                    const TabBar(
                      tabs: [
                        Tab(child: Text('Popular')),
                        Tab(child: Text('Recommended')),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Popular(),
                          Recommended(),
                        ],
                      ),
                    ),
                  ],
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Icon(Icons.error_outline),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}















// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flavour_verse/Auth/Login.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'Tabs/Popular.dart';
// import 'Tabs/Recommended.dart';
//
// class Explore extends StatefulWidget {
//   const Explore({super.key});
//
//   @override
//   State<Explore> createState() => _ExploreState();
// }
//
// class _ExploreState extends State<Explore> {
//
//   Future getUser() async {
//     SharedPreferences userLoginDetails = await SharedPreferences.getInstance();
//     return userLoginDetails.getString("UserLoggedIn");
//   }
//   String uEmail = '';
//   @override
//   void initState() {
//     // TODO: implement initState
//     getUser().then((value) {
//       setState(() {
//         uEmail = value;
//       });
//     });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         body: Column(
//           children: [
//
//             StreamBuilder(
//                 stream: FirebaseFirestore.instance.collection("userData").where('User-Email',isEqualTo: uEmail).snapshots(),
//                 builder: (context, snapshot) {
//                   if(snapshot.connectionState == ConnectionState.waiting){
//                     return const CircularProgressIndicator();
//                   }
//                   if (snapshot.hasData) {
//
//                     var dataLength = snapshot.data!.docs.length;
//
//                     return dataLength==0? Login()
//                     // GestureDetector(
//                     //   onTap:() {
//                     //     Navigator.push(context, MaterialPageRoute(builder:
//                     //     (context) => const Login(),));
//                     //     }
//                     //   ,
//                     // )
//                         :
//                     ListView.builder(
//                       itemCount: dataLength,
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) {
//                         String userID = snapshot.data!.docs[index]['User-Id'];
//                         String userName = snapshot.data!.docs[index]['User-Name'];
//
//
//                         return
//                           Column(
//                             children: [
//                               Row(
//                                   children:[
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           margin: const EdgeInsets.only(left: 20,top: 30),
//                                           child: Text(userName,style: GoogleFonts.poppins(
//                                               color: Theme.of(context).colorScheme.primary,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400
//                                           ),),
//                                         ),
//
//                                         Container(
//                                           margin: const EdgeInsets.only(left: 20),
//                                           child: Text("What would you like",style: GoogleFonts.poppins(
//                                               color: Theme.of(context).colorScheme.secondary,
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w600
//                                           ),),
//                                         ),
//
//                                         Container(
//                                           margin: const EdgeInsets.only(left: 20),
//                                           child: Text("to cook today?",style: GoogleFonts.poppins(
//                                               color: Theme.of(context).colorScheme.secondary,
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w600
//                                           ),),),
//
//                                       ],),
//
//                                     Container(
//                                       margin: const EdgeInsets.only(top: 30,left: 50),
//                                       child: const CircleAvatar(
//                                         radius: 30.0,
//                                         backgroundImage:
//                                         AssetImage('assets/profile.jpg'),
//                                         // backgroundColor: Theme.of(context).colorScheme.background,
//                                       ),
//                                     ),
//
//                                   ]),
//                               const TabBar(
//                                 tabs:  [
//                                   Tab(
//                                     child: Text('Popular'),
//                                   ),
//                                   Tab(
//                                     child: Text('Recommended'),
//                                   ),
//                                   // Tab(
//                                   //   child: Text('New'),
//                                   // ),
//                                 ],
//                               ),
//
//                               const Expanded(child: TabBarView(
//                                 children: [
//                                   //First tab Popular
//                                   Popular(),
//                                   //Second Tab Recommended
//                                   Recommended()
//                                 ],),
//                               ),
//
//                             ],
//                           );
//
//                       },);
//                   }
//                   if (snapshot.hasError) {
//                     return const Icon(Icons.error_outline);
//                   }
//                   return Container();
//                 })  ,
//
//
// //Tab bar
// //             const TabBar(
// //               tabs:  [
// //                 Tab(
// //                   child: Text('Popular'),
// //                 ),
// //                 Tab(
// //                   child: Text('Recommended'),
// //                 ),
// //                 // Tab(
// //                 //   child: Text('New'),
// //                 // ),
// //               ],
// //
// //             ),
//
//
//
//
//
//           ],
//         ),
//
//       ),
//     );
//   }
// }




















//Heading
//       Row(
//           children:[
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(left: 20,top: 30),
//                   child: Text("Hello, Anne",style: GoogleFonts.poppins(
//                       color: Theme.of(context).colorScheme.primary,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400
//                   ),),
//                 ),
//
//                 Container(
//                   margin: EdgeInsets.only(left: 20),
//                   child: Text("What would you like",style: GoogleFonts.poppins(
//                       color: Theme.of(context).colorScheme.secondary,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600
//                   ),),
//                 ),
//
//                 Container(
//                   margin: EdgeInsets.only(left: 20),
//                   child: Text("to cook today?",style: GoogleFonts.poppins(
//                       color: Theme.of(context).colorScheme.secondary,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600
//                   ),),),
//
//               ],),
//
//             Container(
//               margin: EdgeInsets.only(top: 30,left: 50),
//               child: CircleAvatar(
//                 radius: 30.0,
//                 // backgroundImage:
//                 // AssetImage('assets/images/profile.jpg'),
//                 backgroundColor: Theme.of(context).colorScheme.secondary,
//               ),
//             ),
//
//           ]),
//Search
//       Container(
//           width: 400,
//           height: 50,
//           margin: const EdgeInsets.only(left: 20,top: 10,right: 50),
//           decoration: BoxDecoration(
//               color: Color(0xffffffff),
//               border: Border.all(color:Color(0xffbdbdbd),width: 1.5
//               ),
//               borderRadius: BorderRadius.circular(40)
//
//           ),
//           child: Row(
//             children: [
//               Container(
//                   margin: EdgeInsets.only(left: 28),
//                   child:  Text("Search any recipes",style: GoogleFonts.poppins(
//                       color: const Color(0xf0676767),
//                       fontSize: 15,
//                       fontWeight: FontWeight.w400
//                   ),)
//               ),
//               Container(
//                   margin: EdgeInsets.only(left: 80),
//                   child:  Text("|",style: GoogleFonts.poppins(
//                       color: const Color(0xf0d2d2d2),
//                       fontSize: 35,
//                       fontWeight: FontWeight.w100
//                   ),)
//               ),
//               Container(
//                   margin: EdgeInsets.only(left: 10),
//                   child: const Icon(Icons.search,color: Color(0xf0adadad),)
//               ),
//             ],
//           )
//       ),
//
//       SizedBox(height: 20,),



// Row(
//   children: [
//     GestureDetector(
//       child: Container(
//         margin: EdgeInsets.only(left: 20,right: 20),
//         child: Text("Popular",style: GoogleFonts.poppins(
//             color: Color(0xff000000),
//             fontSize: 16,
//             fontWeight: FontWeight.w600
//         ),),
//       ),
//     ),
//     Container(
//       margin: EdgeInsets.only(left: 20,right: 20),
//       child: Text("Recommended",style: GoogleFonts.poppins(
//           color: Color(0xff000000),
//           fontSize: 16,
//           fontWeight: FontWeight.w600
//       ),),
//     ),
//     Container(
//       margin: EdgeInsets.only(left: 20,),
//       child: Text("New",style: GoogleFonts.poppins(
//           color: Color(0xff000000),
//           fontSize: 16,
//           fontWeight: FontWeight.w600
//       ),),
//     ),
// ],),
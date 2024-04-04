import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';


import 'Bottom_Navigation.dart';
import 'Services.dart';

class DescriptionScreen extends StatefulWidget {
  var idMeal;

  DescriptionScreen({required this.idMeal});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState(id_Meal: idMeal);
}

class _DescriptionScreenState extends State<DescriptionScreen> {

  var id_Meal;
  _DescriptionScreenState({required this.id_Meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future:  MyServices.descfetch(id_Meal),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Icon(Icons.error));
            } else {
              Map map = jsonDecode(snapshot.data.toString());
              List mydata = map['meals'];
              String instruction = mydata[0]['strInstructions'];
              String img = mydata[0]['strMealThumb'];
              String name =mydata[0]['strMeal'];

              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('$img'),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        margin: const EdgeInsets.only(left: 5, top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const bottomNavigation()),
                            );
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            size: 31,
                            color: Colors.black,
                          ),
                        ),
                      ),





                      Container(
                        width: double.infinity,
                        // height:400,
                        height: MediaQuery.of(context).size.height -255,
                        margin: EdgeInsets.only(top: 250,left: 20,right: 20),
                        padding: EdgeInsets.only(top: 30,left: 20,right: 15),
                        decoration: BoxDecoration(
                            color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(20)
                        ),


                        child:
                        SingleChildScrollView(
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20,top: 0),
                                  child: Text('$name',style: GoogleFonts.poppins(
                                      color: Color(0xff000000),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                  ),),
                                ),
                                SizedBox(height: 20),
                                Text('$instruction',style: GoogleFonts.poppins(
                                    color: Color(0xff000000),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                ),),
                                SizedBox(height: 20),



                              ],
                            ),
                          ),
                        ),
                      ),


                      Container(
                          width: 60,
                          height: 63,
                          margin: EdgeInsets.only(top: 230,left: MediaQuery.of(context).size.width -105,),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffcc3030),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffb0b0b0,),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: Offset(1, 5),
                                )
                              ]
                            // border: Border.all(color: Color(0xffa19e9e))
                          ),
                          child: Icon(CupertinoIcons.heart,color: Color(0xffffffff))
                      ),

                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}







// Positioned(
//   left: 20,
//   right: 20,
//   bottom: 20,
//   child: Container(
//     height: MediaQuery.of(context).size.height * 0.65,
//     decoration: BoxDecoration(
//       color: Color(0xffffffff),
//       borderRadius: BorderRadius.circular(20),
//     ),
//     child: SingleChildScrollView(
//       child: IntrinsicHeight(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               margin: EdgeInsets.only(left: 20, top: 20),
//
//               child: Text('$name', style: GoogleFonts.poppins(
//                 color: Color(0xff000000),
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               )),
//             ),
//             SizedBox(height: 20),
//             Text('$instruction', style: GoogleFonts.poppins(
//               color: Color(0xff000000),
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             )),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     ),
//   ),
// ),





//
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:meal_db/Bottom_Navigation.dart';
// import 'package:meal_db/Explore.dart';
// import 'Services.dart';
//
// class DescriptionScreen extends StatefulWidget {
//   var idMeal;
//
//   DescriptionScreen({required this.idMeal});
//
//   @override
//   State<DescriptionScreen> createState() => _DescriptionScreenState(id_Meal: idMeal);
// }
//
// class _DescriptionScreenState extends State<DescriptionScreen> {
//   var id_Meal;
//   _DescriptionScreenState({required this.id_Meal});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: FutureBuilder(
//           future: MyServices.descfetch(id_Meal),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Icon(Icons.error));
//             } else {
//               Map map = jsonDecode(snapshot.data.toString());
//               List mydata = map['meals'];
//               String instruction = mydata[0]['strInstructions'];
//               String img = mydata[0]['strMealThumb'];
//               String name = mydata[0]['strMeal'];
//
//               return Stack(
//                 children: [
//                   Column(
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         height: 300,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             fit: BoxFit.cover,
//                             image: NetworkImage('$img'),
//                           ),
//                         ),
//                       ),
//
//                     ],
//                   ),
//                   Positioned(
//                     left: 20,
//                     right: 20,
//                     bottom: 20,
//                     child: Container(
//                       height: MediaQuery.of(context).size.height * 0.65,
//                       decoration: BoxDecoration(
//                         color: Color(0xffffffff),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: SingleChildScrollView(
//                         child: IntrinsicHeight(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.only(left: 20, top: 20),
//
//                                 child: Text('$name', style: GoogleFonts.poppins(
//                                   color: Color(0xff000000),
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w600,
//                                 )),
//                               ),
//                               SizedBox(height: 20),
//                               Text('$instruction', style: GoogleFonts.poppins(
//                                 color: Color(0xff000000),
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               )),
//                               SizedBox(height: 20),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

















// import 'dart:convert';
//
// import 'package:food_app/MaterialApp.dart';
// import 'package:food_app/services.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class DescriptionScreen extends StatefulWidget {
//
//   var idMeal;
//
//   DescriptionScreen({required this.idMeal});
//
//   @override
//   State<DescriptionScreen> createState() => _DescriptionScreenState(id_Meal: idMeal);
// }
//
// class _DescriptionScreenState extends State<DescriptionScreen> {
//
//   var id_Meal;
//   _DescriptionScreenState({required this.id_Meal});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//         body: FutureBuilder(
//           future: MyServices.descfetch(id_Meal),
//           builder: (BuildContext context, AsyncSnapshot snapshot){
//
//             if (snapshot.hasData) {
//               Map map = jsonDecode(snapshot.data);
//
//                 List mydata= map['meals'];
//
//               return ListView.builder(
//                shrinkWrap: true,
//                 // physics: const ScrollPhysics(),
//                 // scrollDirection: Axis.vertical,
//                 itemCount: mydata.length,
//                 itemBuilder: (context, index) {
//                   String instruction = mydata[index]['strInstructions'];
//                   String img = mydata[index]['strMealThumb'];
//                   return  SafeArea(
//                     child: Column(
//
//                           children: [
//
//                             Stack(
//                               children: [
//
//                                 Container(
//                                   width: double.infinity,
//                                   height: 300,
//                                   decoration: BoxDecoration(
//                                      image: DecorationImage(
//                                      fit: BoxFit.cover,
//                                      image: NetworkImage('$img'))
//                                   ),
//                                 ),
//
//                                 Container(
//                                   padding: const EdgeInsets.all(20.0),
//                                   margin: const EdgeInsets.only(left: 20,top: 20),
//                                   decoration: BoxDecoration(
//                                     // color: Colors.white,
//                                       borderRadius: BorderRadius.circular(40)
//                                   ),
//                                   child: GestureDetector(
//                                     onTap: (){
//                                       Navigator.push(context, MaterialPageRoute(builder: (context)=> const Menu()));
//                                     },
//                                     child: const Icon(
//                                       Icons.arrow_back ,// Arrow icon
//                                       size: 21, // Icon size
//                                       color: Colors.black, // Icon color (match the container background)
//                                     ),
//                                   ),
//                                 ),
//
//
//                                 SingleChildScrollView(
//
//                                   child: Container(
//                                     margin: const EdgeInsets.only(top: 270),
//                                     width: double.infinity,
//                                     height: 600,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20),
//                                       color: Colors.lightBlue,
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         Container(
//                                           margin: EdgeInsets.only(left: 20,top: 30),
//                                           child: Text("Hello, Anne",style: GoogleFonts.poppins(
//                                               color: Color(0xffbebebe),
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400
//                                           ),),
//                                         ),
//                                         Container(
//                                           margin: EdgeInsets.only(left: 20,top: 30),
//                                           child: Text("Hello, Anne",style: GoogleFonts.poppins(
//                                               color: Color(0xffbebebe),
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400
//                                           ),),
//                                         ),
//                                         Container(
//                                           margin: EdgeInsets.only(left: 20,top: 30),
//                                           child: Text("Hello, Anne",style: GoogleFonts.poppins(
//                                               color: Color(0xffbebebe),
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400
//                                           ),),
//                                         ),
//                                         Container(
//                                           margin: EdgeInsets.only(left: 20,top: 30),
//                                           child: Text("Hello, Anne",style: GoogleFonts.poppins(
//                                               color: Color(0xffbebebe),
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400
//                                           ),),
//                                         ),
//                                         Container(
//                                           margin: EdgeInsets.only(left: 20,top: 30),
//                                           child: Text("Hello, Anne",style: GoogleFonts.poppins(
//                                               color: Color(0xffbebebe),
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400
//                                           ),),
//                                         ),
//                                         Container(
//                                           margin: EdgeInsets.only(left: 20,top: 30),
//                                           child: Text("Hello, Anne",style: GoogleFonts.poppins(
//                                               color: Color(0xffbebebe),
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400
//                                           ),),
//                                         ),
//                                         Container(
//                                           margin: EdgeInsets.only(left: 20,top: 30),
//                                           child: Text("Hello, Anne",style: GoogleFonts.poppins(
//                                               color: Color(0xffbebebe),
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400
//                                           ),),
//                                         ),
//                                         Container(
//                                           margin: EdgeInsets.only(left: 20,top: 30),
//                                           child: Text("Hello, Anne",style: GoogleFonts.poppins(
//                                               color: Color(0xffbebebe),
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400
//                                           ),),
//                                         ),
//                                         Container(
//                                           margin: EdgeInsets.only(left: 20,top: 30),
//                                           child: Text("Hello, Anne",style: GoogleFonts.poppins(
//                                               color: Color(0xffbebebe),
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400
//                                           ),),
//                                         ),
//                                         Container(
//                                           margin: EdgeInsets.only(left: 20,top: 30),
//                                           child: Text("Hello, Anne",style: GoogleFonts.poppins(
//                                               color: Color(0xffbebebe),
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400
//                                           ),),
//                                         ),
//                                         Container(
//                                           margin: EdgeInsets.only(left: 20,top: 30),
//                                           child: Text("Hello, Anne",style: GoogleFonts.poppins(
//                                               color: Color(0xffbebebe),
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400
//                                           ),),
//                                         ),
//
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//
//
//                               ],
//                             ),
//
//                             // Container(
//                             //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                             //   width: double.infinity,
//                             //   height: 150,
//                             //   decoration: BoxDecoration(
//                             //       borderRadius: BorderRadius.circular(20),
//                             //       color: Color(0xff5bc2d0),
//                             //       boxShadow: [
//                             //         BoxShadow(
//                             //             color: Color(0xffb0adad),
//                             //             spreadRadius: 2,
//                             //             blurRadius: 10,
//                             //             offset: Offset(4, 4)
//                             //         )
//                             //       ],
//                             //       image: DecorationImage(
//                             //           fit: BoxFit.cover,
//                             //           image: NetworkImage('$img'))
//                             //
//                             //   ),
//                             // ),
//                             // SizedBox(height: 30,),
//                             //
//                             // SingleChildScrollView(
//                             //   physics: const ScrollPhysics(),
//                             //   scrollDirection: Axis.vertical,
//                             //   child: Container(
//                             //     margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
//                             //     width: double.infinity,
//                             //     height: 500,
//                             //
//                             //     decoration: BoxDecoration(
//                             //         borderRadius: BorderRadius.circular(20),
//                             //         color: Color(0x8647c8f5),
//                             //         boxShadow: [
//                             //           BoxShadow(
//                             //               color: Color(0xffb0adad),
//                             //               spreadRadius: 2,
//                             //               blurRadius: 10,
//                             //               offset: Offset(4, 4)
//                             //           )
//                             //         ],
//                             //
//                             //     ),
//                             //     child: Padding(
//                             //       padding: EdgeInsets.all(16.0),
//                             //       child: Text('$instruction',style: GoogleFonts.poppins(
//                             //         fontSize: 14,
//                             //         fontWeight: FontWeight.w400,
//                             //
//                             //       ),),
//                             //     ),
//                             //   ),
//                             // ),
//
//                           ],
//                     ),
//                   );
//                 },);
//             }
//
//             if (snapshot.hasError){
//               return Center(child: Icon(Icons.error));
//             }
//             if (snapshot.connectionState==ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//
//             }
//             return Container();
//
//           },
//         )
//
//     );
//   }
// }

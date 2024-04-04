import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Tabs/Popular.dart';
import 'Tabs/Recommended.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [



      //Heading
            Row(
                children:[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20,top: 30),
                        child: Text("Hello, Anne",style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                        ),),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text("What would you like",style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                        ),),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text("to cook today?",style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                        ),),),

                    ],),

                  Container(
                    margin: EdgeInsets.only(top: 30,left: 50),
                    child: CircleAvatar(
                      radius: 30.0,
                      // backgroundImage:
                      // AssetImage('assets/images/profile.jpg'),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                  ),

                ]),
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


//Tab bar
            TabBar(
              tabs:  [
                Tab(
                  child: Text('Popular'),
                ),
                Tab(
                  child: Text('Recommended'),
                ),
                // Tab(
                //   child: Text('New'),
                // ),
              ],

            ),

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

            Expanded(child: TabBarView(
              children: [
                //First tab Popular
                Popular(),
                //Second Tab Recommended
                Recommended()
              ],),
            ),

          ],
        ),

      ),
    );
  }
}

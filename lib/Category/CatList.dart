import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Services.dart';
import '../DescriptionScreen.dart';

class CatList extends StatefulWidget {
  final String catName;

  const CatList({super.key, required this.catName});

  @override
  State<CatList> createState() => _CatListState();
}

class _CatListState extends State<CatList> {
  Future<List<dynamic>> fetchData() async {
    // Fetch data from both APIs simultaneously
    final List<Future<dynamic>> futures = [
      MyServices.apifetch(),
      MyServices.apifetch2(),
    ];

    // Wait for both requests to complete
    final List<dynamic> responses = await Future.wait(futures);

    // Decode and combine data from both responses
    List<dynamic> combinedData = [];
    for (String response in responses) {
      Map map = jsonDecode(response);
      List mydata = map['meals'];
      combinedData.addAll(mydata);
    }

    return combinedData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Icon(Icons.error));
          }

          if (snapshot.hasData) {
            List<dynamic> combinedData = snapshot.data as List<dynamic>;

            // Filter combined data based on catName
            List filteredData = combinedData.where((recipe) => recipe['strCategory'] == widget.catName || recipe['strMeal'].contains(widget.catName)).toList();

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    child: GridView.count(
                      crossAxisCount: 2,
                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2 / 2.3,
                      children: List.generate(filteredData.length, (index) {
                        var recipe = filteredData[index];
                        return GestureDetector(
                          onTap: () {
                            var idMeal = recipe['idMeal'];
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DescriptionScreen(idMeal: idMeal)),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                            width: 200,
                            height: 400,
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 50),
                                  width: 250,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 8, top: 100),
                                        child: Text(
                                          "${recipe['strMeal']}",
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xf0000000),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 18),
                                  width: 130,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                      colorFilter: ColorFilter.mode(const Color(0xffffffff).withOpacity(0.2), BlendMode.darken),
                                      fit: BoxFit.cover,
                                      image: NetworkImage('${recipe['strMealThumb']}'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}




























// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../DescriptionScreen.dart';
// import '../Services.dart';
//
// class CatList extends StatefulWidget {
//   var catName;
//
//   CatList({required this.catName});
//
//   @override
//   State<CatList> createState() => _CatListState();
// }
//
// class _CatListState extends State<CatList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//
//             FutureBuilder(
//               future: MyServices.apifetch(),
//               builder: (context, snapshot){
//
//                 if (snapshot.hasData) {
//                   Map map = jsonDecode(snapshot.data);
//                   List mydata = map['meals'];
//                   List filteredData = mydata.where((recipe) => recipe['strCategory'] == widget.catName).toList();
//
//                   return SizedBox(
//                     // height: 380,
//                     // height: MediaQuery.of(context).size.height - 320 ,
//
//                     child: GridView.count(
//                       // scrollDirection: Axis.horizontal,
//                       crossAxisCount: 2,
//                       scrollDirection: Axis.vertical,
//                       physics: const ScrollPhysics(),
//                       shrinkWrap: true,
//                       mainAxisSpacing: 10,
//                       crossAxisSpacing: 10,
//                       childAspectRatio: 2/2.3,
//                       children: List.generate(filteredData.length, (index) =>
//                           GestureDetector(
//                             onTap:(){
//
//                               var idMeal = filteredData[index]['idMeal'];
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=> DescriptionScreen(idMeal: idMeal),));},
//                             child: Expanded(
//                               child: Container(
//                                 margin: EdgeInsets.only(left: 10,right: 10,top: 10),
//                                 width: 200,
//                                 height: 400,
//                                 // color: Colors.brown,
//                                 child: Stack(
//                                   children: [
//
//                                     Container(
//                                       margin: EdgeInsets.only(top: 50),
//                                       width: 250,
//                                       height: 200,
//                                       decoration: BoxDecoration(
//                                         color: Theme.of(context).primaryColor,
//                                         //0xff7532fa 0xff0d66b2 0xff1f9fb6
//                                         // boxShadow: [
//                                         //   BoxShadow(
//                                         //     // color: Color(0xff6c6c6c,),
//                                         //     // spreadRadius: 1,
//                                         //     // blurRadius: 5,
//                                         //     // offset: Offset(1, 1),
//                                         //     color: Colors.grey.withOpacity(0.45),
//                                         //     spreadRadius: 3,
//                                         //     blurRadius: 2,
//                                         //     offset: Offset(0, 1),
//                                         //
//                                         //   )
//                                         // ],
//                                         //0xffd27515 ,0xff1390a6
//                                         borderRadius: BorderRadius.circular(20),
//
//                                       ),
//                                       child: Column(
//                                         children: [
//                                           Container(
//                                               margin: EdgeInsets.only(left: 8,top: 100),
//                                               child:  Text("${filteredData[index]['strMeal']}",style: GoogleFonts.poppins(
//                                                   color: const Color(
//                                                       0xf0000000),
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.w600
//                                               ),)
//                                           ),
//
//                                         ],
//                                       ),
//                                     ),
//
//                                     Container(
//                                       margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width /18 ,),
//                                       width: 130,
//                                       height: 150,
//                                       decoration: BoxDecoration(
//                                         // color: Colors.amber,
//                                         borderRadius: BorderRadius.circular(30),
//                                         // boxShadow: [
//                                         //   BoxShadow(
//                                         //     color: Color(0xff414141,),
//                                         //     spreadRadius: 0.65,
//                                         //     blurRadius: 15,
//                                         //     offset: Offset(1, 1),
//                                         //     // color: Colors.grey.withOpacity(0.45),
//                                         //     // spreadRadius: 5,
//                                         //     // blurRadius: 2,
//                                         //     // offset: Offset(0, 3),
//                                         //
//                                         //   )
//                                         // ],
//                                         image: DecorationImage(
//                                             colorFilter: ColorFilter.mode(const Color(
//                                                 0xffffffff).withOpacity(0.2), BlendMode.darken),
//                                             fit: BoxFit.cover,
//                                             image: NetworkImage('${filteredData[index]['strMealThumb']}')),
//                                       ),
//                                     ),
//                                   ],),
//                               ),
//                             ),
//                           ),
//                       ),),
//                   );
//                 }
//
//                 if (snapshot.hasError){
//                   return Center(child: Icon(Icons.error));
//                 }
//                 if (snapshot.connectionState==ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//
//                 }
//                 return Container();
//
//               },
//             ),
//
//
//
//
//             FutureBuilder(
//               future: MyServices.apifetch2(),
//               builder: (context, snapshot){
//
//                 if (snapshot.hasData) {
//                   Map map = jsonDecode(snapshot.data);
//                   List mydata = map['meals'];
//                   List filteredData = mydata.where((recipe) => recipe['strMeal'].contains(widget.catName)).toList();
//
//
//                   return SizedBox(
//                     // height: 380,
//                     // height: MediaQuery.of(context).size.height - 320 ,
//
//                     child: GridView.count(
//                       // scrollDirection: Axis.horizontal,
//                       crossAxisCount: 2,
//                       scrollDirection: Axis.vertical,
//                       physics: const ScrollPhysics(),
//                       shrinkWrap: true,
//                       mainAxisSpacing: 10,
//                       crossAxisSpacing: 10,
//                       childAspectRatio: 2/2.3,
//                       children: List.generate(filteredData.length, (index) =>
//                           GestureDetector(
//                             onTap:(){
//
//                               var idMeal = filteredData[index]['idMeal'];
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=> DescriptionScreen(idMeal: idMeal),));},
//                             child: Expanded(
//                               child: Container(
//                                 margin: EdgeInsets.only(left: 10,right: 10,top: 10),
//                                 width: 200,
//                                 height: 400,
//                                 // color: Colors.brown,
//                                 child: Stack(
//                                   children: [
//
//                                     Container(
//                                       margin: EdgeInsets.only(top: 50),
//                                       width: 250,
//                                       height: 200,
//                                       decoration: BoxDecoration(
//                                         color: Theme.of(context).primaryColor,
//                                         //0xff7532fa 0xff0d66b2 0xff1f9fb6
//                                         // boxShadow: [
//                                         //   BoxShadow(
//                                         //     // color: Color(0xff6c6c6c,),
//                                         //     // spreadRadius: 1,
//                                         //     // blurRadius: 5,
//                                         //     // offset: Offset(1, 1),
//                                         //     color: Colors.grey.withOpacity(0.45),
//                                         //     spreadRadius: 3,
//                                         //     blurRadius: 2,
//                                         //     offset: Offset(0, 1),
//                                         //
//                                         //   )
//                                         // ],
//                                         //0xffd27515 ,0xff1390a6
//                                         borderRadius: BorderRadius.circular(20),
//
//                                       ),
//                                       child: Column(
//                                         children: [
//                                           Container(
//                                               margin: EdgeInsets.only(left: 8,top: 100),
//                                               child:  Text("${filteredData[index]['strMeal']}",style: GoogleFonts.poppins(
//                                                   color: const Color(
//                                                       0xf0000000),
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.w600
//                                               ),)
//                                           ),
//
//                                         ],
//                                       ),
//                                     ),
//
//                                     Container(
//                                       margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width /18 ,),
//                                       width: 130,
//                                       height: 150,
//                                       decoration: BoxDecoration(
//                                         // color: Colors.amber,
//                                         borderRadius: BorderRadius.circular(30),
//                                         // boxShadow: [
//                                         //   BoxShadow(
//                                         //     color: Color(0xff414141,),
//                                         //     spreadRadius: 0.65,
//                                         //     blurRadius: 15,
//                                         //     offset: Offset(1, 1),
//                                         //     // color: Colors.grey.withOpacity(0.45),
//                                         //     // spreadRadius: 5,
//                                         //     // blurRadius: 2,
//                                         //     // offset: Offset(0, 3),
//                                         //
//                                         //   )
//                                         // ],
//                                         image: DecorationImage(
//                                             colorFilter: ColorFilter.mode(const Color(
//                                                 0xffffffff).withOpacity(0.2), BlendMode.darken),
//                                             fit: BoxFit.cover,
//                                             image: NetworkImage('${filteredData[index]['strMealThumb']}')),
//                                       ),
//                                     ),
//                                   ],),
//                               ),
//                             ),
//                           ),
//                       ),),
//                   );
//                 }
//
//                 if (snapshot.hasError){
//                   return Center(child: Icon(Icons.error));
//                 }
//                 if (snapshot.connectionState==ConnectionState.waiting) {
//                   // return CircularProgressIndicator();
//
//                 }
//                 return Container();
//
//               },
//             )
//
//
//
//           ],),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flavour_verse/Category/CatList.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Services.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
        
            FutureBuilder(
              future: MyServices.apifetchCat(),
              builder: (context, snapshot){
        
                if (snapshot.hasData) {
                  Map map = jsonDecode(snapshot.data);
                  List mydata = map['categories'];
        
                  return SizedBox(
                    // height: 380,
                    height: MediaQuery.of(context).size.height *0.89 ,
        
                    child: GridView.count(
                      // scrollDirection: Axis.horizontal,
                      crossAxisCount: 2,
                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2/2.3,
                      children: List.generate(mydata.length, (index) =>
                          GestureDetector(
                            onTap:(){
                              var idMeal = mydata[index]['idCategory'];
                              var catName=mydata[index]['strCategory'];
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> CatList(catName: catName),));},
                            child: Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
                                width: 200,
                                height: 400,
                                // color: Colors.brown,
                                child: Stack(
                                  children: [
        
                                    Container(
                                      margin: const EdgeInsets.only(top: 50),
                                      width: 250,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        //0xff7532fa 0xff0d66b2 0xff1f9fb6
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     // color: Color(0xff6c6c6c,),
                                        //     // spreadRadius: 1,
                                        //     // blurRadius: 5,
                                        //     // offset: Offset(1, 1),
                                        //     color: Colors.grey.withOpacity(0.45),
                                        //     spreadRadius: 3,
                                        //     blurRadius: 2,
                                        //     offset: Offset(0, 1),
                                        //
                                        //   )
                                        // ],
                                        //0xffd27515 ,0xff1390a6
                                        borderRadius: BorderRadius.circular(20),
        
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                              margin: const EdgeInsets.only(left: 8,top: 100),
                                              child:  Text("${mydata[index]['strCategory']}",style: GoogleFonts.poppins(
                                                  color: const Color(
                                                      0xf0000000),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600
                                              ),)
                                          ),
        
                                        ],
                                      ),
                                    ),
        
                                    Container(
                                      margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width /18 ,),
                                      width: 130,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        // color: Colors.amber,
                                        borderRadius: BorderRadius.circular(30),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color: Color(0xff414141,),
                                        //     spreadRadius: 0.65,
                                        //     blurRadius: 15,
                                        //     offset: Offset(1, 1),
                                        //     // color: Colors.grey.withOpacity(0.45),
                                        //     // spreadRadius: 5,
                                        //     // blurRadius: 2,
                                        //     // offset: Offset(0, 3),
                                        //
                                        //   )
                                        // ],
                                        image: DecorationImage(
                                            colorFilter: ColorFilter.mode(const Color(
                                                0xffffffff).withOpacity(0.2), BlendMode.darken),
                                            fit: BoxFit.cover,
                                            image: NetworkImage('${mydata[index]['strCategoryThumb']}')),
                                      ),
                                    ),
                                  ],),
                              ),
                            ),
                          ),
                      ),),
                  );
                }
        
                if (snapshot.hasError){
                  return const Center(child: Icon(Icons.error));
                }
                if (snapshot.connectionState==ConnectionState.waiting) {
                  return Container(
                    margin: EdgeInsets.only(top: 300),
                      child: Center(child: const CircularProgressIndicator()));

                }
                return Container();
        
              },
            )
        
          ],),
      ),
    );
  }
}

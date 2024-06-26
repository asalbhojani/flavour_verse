import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../DescriptionScreen.dart';
import '../Services.dart';

class Popular extends StatefulWidget {
  const Popular({super.key});

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: FutureBuilder(
        future: MyServices.apifetch(),
        builder: (context, snapshot){

          if (snapshot.hasData) {
            Map map = jsonDecode(snapshot.data);
            List mydata = map['meals'];

            return SizedBox(
              // height: 380,
              // height: MediaQuery.of(context).size.height - 320 ,

              child: GridView.count(
                // scrollDirection: Axis.horizontal,
                crossAxisCount: 2,
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2/2.3,
                children: List.generate(4, (index) =>
                    GestureDetector(
                      onTap:(){
                        var idMeal = mydata[index]['idMeal'];
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DescriptionScreen(idMeal: idMeal),));},
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
                                  boxShadow: [
                                    BoxShadow(
                                      // color: Color(0xff6c6c6c,),
                                      // spreadRadius: 1,
                                      // blurRadius: 5,
                                      // offset: Offset(1, 1),
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: Offset(0, 1),

                                    )
                                  ],
                                  //0xffd27515 ,0xff1390a6
                                  borderRadius: BorderRadius.circular(20),

                                ),
                                child: Column(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(left: 8,top: 100),
                                        child:  Text("${mydata[index]['strMeal']}",style: GoogleFonts.poppins(
                                            color: const Color(
                                                0xf0000000),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600
                                        ),)
                                    ),


                                    Container(
                                        margin: const EdgeInsets.only(left: 8,top: 0),
                                        child:  Text("${mydata[index]['strCategory']}",style: GoogleFonts.poppins(
                                            color: const Color(
                                                0xf0000000),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500
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
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(2, 3), // changes position of shadow
                                    ),
                                  ],
                                  image: DecorationImage(
                                      colorFilter: ColorFilter.mode(const Color(
                                          0xffffffff).withOpacity(0.2), BlendMode.darken),
                                      fit: BoxFit.cover,
                                      image: NetworkImage('${mydata[index]['strMealThumb']}')),
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
            return Center(child: const CircularProgressIndicator());

          }
          return Container();

        },
      ),
    );
  }
}

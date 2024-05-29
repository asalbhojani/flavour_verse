import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen1 extends StatefulWidget {
  const IntroScreen1({super.key});

  @override
  State<IntroScreen1> createState() => _IntroScreen1State();
}

class _IntroScreen1State extends State<IntroScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // backgroundColor: Color(0xff7838c0),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(0.3,0.3),
              end: Alignment(0.5,0.7),
              colors: <Color>[Color(0xff943ecc), Color(0xffab66d5)],
              tileMode: TileMode.mirror,
              // colors: [Color(0xff943ecc), Color(0xffab66d5)],
              // begin: const FractionalOffset(0.0, 0.0),
              // end: const FractionalOffset(1, 0.0),
              // stops: [0.0, 1.0],
              // tileMode: TileMode.clamp
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            SizedBox(
              height: 400,
              width: 500,
              child: Image.asset("assets/images/intro11.png"),
            ),
            
            Container(
              width: 200,
              margin: const EdgeInsets.only(left: 30,top: 0),
              child: Text("Cook Like",style: GoogleFonts.poppins(
                  color: const Color(0xffffffff),
                  fontSize: 40,
                  fontWeight: FontWeight.w600
              ),),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30,top: 0),
              child: Text("A Chef",style: GoogleFonts.poppins(
                  color: const Color(0xffffffff),
                  fontSize: 43,
                  fontWeight: FontWeight.w600
              ),),
            ),

            Container(
              width: 250,
              margin: const EdgeInsets.only(left: 30),
              child: Text("Cook Professional Dishes right in your kitchen",style: GoogleFonts.poppins(
                  color: const Color(0xffffffff),
                  fontSize: 16,
                  fontWeight: FontWeight.w400
              ),),
            ),



          ],),
      ),
    );
  }
}

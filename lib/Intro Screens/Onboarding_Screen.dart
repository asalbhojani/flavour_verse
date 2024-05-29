import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Explore.dart';
import 'Intro_Screen1.dart';
import 'Intro_Screen2.dart';
import 'Intro_Screen3.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final PageController _controller= PageController();
  bool onLastPage=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index){
              setState(() {
                onLastPage= (index==2);
              });
            },
            children: const [
              IntroScreen1(),
              IntroScreen2(),
              IntroScreen3()
            ],
          ),

          Container(
              alignment: const Alignment(0,0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  //Skip
                  GestureDetector(
                    onTap:(){
                      _controller.jumpToPage(2);
                    },

                    child: Text("Skip",style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w400,
                    ),),
                  ),

                  SmoothPageIndicator(controller: _controller, count: 3),

                  //next or done
                  onLastPage?
                  GestureDetector(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Explore()));
                    } ,
                    child: Text("Done",style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w400,
                    ),),
                  ):
                  GestureDetector(
                    onTap:(){
                      _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                    } ,
                    child: Text("Next",style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w400,
                    ),),
                  ),

                ],)
          )

        ],),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Bottom_Navigation.dart';
import 'Register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController email=TextEditingController();
  TextEditingController pass =TextEditingController();

  void login_user()async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.toString(), password: pass.text.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const BottomNavigation()));
      SharedPreferences userLoginDetails = await SharedPreferences.getInstance();
      userLoginDetails.setString("UserLoggedIn", email.text.toString());
    }on FirebaseAuthException catch(ex){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ex.code.toString())));
    }
  }

  final _formkey =GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        body: SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //   color: Color(0xf0000731),
              //   padding: EdgeInsets.all(16.0),
              //   child: Row(
              //     children: [
              //       Container(
              //         padding: EdgeInsets.all(7.0),
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(40)
              //         ),
              //         child: Icon(
              //           Icons.arrow_back_ios_rounded, // Arrow icon
              //           size: 18, // Icon size
              //           color: Color(0xff282828), // Icon color (match the container background)
              //         ),
              //       ),
              //       SizedBox(width: 8), // Add spacing between the arrow and other content
              //     ],
              //   ),
              // ),

              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 250,
                    color: Theme.of(context).primaryColor,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Container(
                              padding: const EdgeInsets.all(7.0),
                              margin: const EdgeInsets.only(left: 40,top: 50),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const BottomNavigation(),));
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios_rounded, // Arrow icon
                                  size: 18, // Icon size
                                  color: Color(0xff282828), // Icon color (match the container background)
                                ),
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.only(left: 100,top: 15),
                              child: Text("Welcome Back", style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).iconTheme.color,
                              ),),
                            ),

                            Container(
                              margin: const EdgeInsets.only(left: 124,),
                              child: Text("SignIn to your account", style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color:Theme.of(context).iconTheme.color,
                              ),),
                            ),

                          ],),
                      ],),
                  ),

                  Container(
                    width: double.infinity,
                    height: 500,
                    margin: const EdgeInsets.symmetric(vertical: 200),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40)
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 24,top: 40),
                          child: Text("Sign In ", style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.secondary,
                          ),),
                        ),

                        Form(
                          key: _formkey,
                          child: Column(
                            children: [

                              const SizedBox(height:20,),
                              Container(
                                  margin: const EdgeInsets.symmetric(horizontal:30),
                                  child:TextFormField(
                                      controller: email,
                                      validator: (value) {
                                        if (value==null || value.isEmpty || value==" ") {
                                          return "Email is required ";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        label: const Text("Enter your email"),
                                        filled: true,
                                        // fillColor: Color(0xffff6d40),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide: BorderSide(
                                            color: Theme.of(context).primaryColor,
                                            // width: 2,
                                          ),
                                        ),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(left: 25.0,right: 20),
                                          child: Icon(Icons.person,color: Theme.of(context).primaryColor,),),
                                        // prefixIcon: Icon(Icons.person,color: Color(0xf001074f),),
                                      )
                                  )
                              ),

                              const SizedBox(height: 20,),

                              Container(
                                  margin: const EdgeInsets.symmetric(horizontal:30),
                                  child:TextFormField(
                                      controller: pass,
                                      validator: (value){
                                        if (value==null || value.isEmpty || value==" ") {
                                          return "Password is required ";
                                        }
                                        return null;
                                      },
                                      obscureText: true,
                                      obscuringCharacter: "*",
                                      decoration: InputDecoration(
                                        label: const Text("Enter your password"),
                                        filled: true,
                                        // fillColor: Color(0xffff6d40),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Theme.of(context).primaryColor, ),
                                          borderRadius: BorderRadius.circular(40),
                                        ),
                                        prefixIcon: Padding(
                                            padding: const EdgeInsets.only(left: 25.0,right: 20),
                                            child: Icon(Icons.key,color: Theme.of(context).primaryColor, // _myIcon is a 48px-wide widget.
                                            )),
                                        // prefixIcon: Icon(Icons.key,color: Color(0xf001074f),),
                                      )
                                  )
                              ),

                              const SizedBox(height:20,),

                              GestureDetector(
                                onTap: (){
                                  if (_formkey.currentState!.validate()) {

                                    login_user();

                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 20,left: 30,right: 30),
                                  width: 250,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    // border: Border.all(color: Color(0xffffffff),width: 3),
                                    borderRadius: BorderRadius.circular(40),

                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4,vertical:1 ),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 80,),
                                        Text("Sign In", style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color:  const Color(0xffffffff)
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // SizedBox(height: 30,),
                              // Text("Or Sign in with",style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600),),
                              //
                              // Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children:[
                              //
                              //       Container(
                              //         height: 50,
                              //         width: 50,
                              //         decoration: BoxDecoration(
                              //           image: DecorationImage(image: NetworkImage("https://pbs.twimg.com/profile_images/1605297940242669568/q8-vPggS_400x400.jpg"),
                              //           ),
                              //           color: Theme.of(context).scaffoldBackgroundColor,
                              //           boxShadow: [
                              //             BoxShadow(
                              //               color: Color(0xffa4a4a4),
                              //               spreadRadius: 2,
                              //               blurRadius: 4,
                              //               offset: Offset(3, 3),
                              //             )],
                              //         ),
                              //       ),
                              //       SizedBox(width: 20,height: 50,),
                              //       Container(
                              //         height: 50,
                              //         width: 50,
                              //         decoration: BoxDecoration(
                              //           image: DecorationImage(image: NetworkImage("https://www.wizcase.com/wp-content/uploads/2022/05/Facebook-Logo.png"),
                              //           ),
                              //           color: Theme.of(context).scaffoldBackgroundColor,
                              //           boxShadow: [
                              //             BoxShadow(
                              //               color: Theme.of(context).colorScheme.background,
                              //               spreadRadius: 2,
                              //               blurRadius: 4,
                              //               offset: Offset(3, 3),
                              //             )],
                              //
                              //         ),
                              //       ),
                              //     ]
                              // ),

                              const SizedBox(height: 30,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Text("Don't Have an Account ? ",style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w300),),
                                  /*  ElevatedButton(onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context) => signup(),));
                     }, child:  Text("SignUp",style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600),)),*/

                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Register(),));
                                    },
                                    child:Text("SignUp",style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w700),),
                                  ),
                                ],
                              )

                            ],),
                        ),


                      ],
                    ),
                  ),



                ],
              ),

            ],
          ),
        )

    );
  }
}
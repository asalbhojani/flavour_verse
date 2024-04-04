import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../Bottom_Navigation.dart';
import 'Login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  TextEditingController name=TextEditingController();
  TextEditingController age=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController pass =TextEditingController();

  File? userProfile;

  void InsertUserwithImg()async{

    // UploadTask uploadTask = FirebaseStorage.instance.ref().child("User-Images").child(Uuid().v1()).putFile(userProfile!);
    // TaskSnapshot taskSnapshot = await uploadTask;
    // String userImage = await taskSnapshot.ref.getDownloadURL();
    InsertUser();
    // imgURL: userImage
    // Navigator.push(context, MaterialPageRoute(builder: (context)=> Login(),));

  }
  void InsertUser ()async{
    // {String? imgURL}
    String userId = Uuid().v1();

    Map<String , dynamic> userDetails ={
      "User-Id":userId,
      "User-Name":name.text.toString(),
      "User-Age":age.text.toString(),
      // "User-Image": imgURL,
      "User-Email":email.text.toString(),
      "User-Password":pass.text.toString(),
    };
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.toString(), password: pass.text.toString());
      await FirebaseFirestore.instance.collection("userData").doc(userId).set(userDetails);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
      // SharedPreferences userLoginDetails = await SharedPreferences.getInstance();
      // userLoginDetails.setBool("UserLoggedIn", true);
    }on FirebaseAuthException catch(ex){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${ex.code.toString()}')));
    }
  }
  var _formkey =GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    age.dispose();
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
                    color: Color(0xf0000523),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Container(
                              padding: EdgeInsets.all(7.0),
                              margin: EdgeInsets.only(left: 40,top: 50),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> bottomNavigation(),));
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_rounded, // Arrow icon
                                  size: 18, // Icon size
                                  color: Color(0xff282828), // Icon color (match the container background)
                                ),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 100,top: 15),
                              child: Text("Welcome Back", style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffffffff),
                              ),),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 124,),
                              child: Text("SignIn to your account", style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffffffff),
                              ),),
                            ),

                          ],),
                      ],),
                  ),

                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 200),
                    decoration: BoxDecoration(
                        color: Color(0xf0ffffff),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40)
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 24,top: 40),
                          child: Text("Register ", style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff171717),
                          ),),
                        ),

                        Form(
                          key: _formkey,
                          child: Column(
                            children: [

                              SizedBox(height: 20,),

                              // GestureDetector(
                              //   onTap: () async {
                              //     XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                              //     if (selectedImage!=null) {
                              //       File convertedFile  =File(selectedImage.path);
                              //       setState(() {
                              //         userProfile = convertedFile;
                              //       });
                              //     }
                              //     else{
                              //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Image Selected")));
                              //     }
                              //   },
                              //   child: CircleAvatar(
                              //     radius: 40,
                              //     backgroundColor: Colors.grey.shade400,
                              //     backgroundImage: userProfile!=null?FileImage(userProfile!):null,
                              //   ),
                              // ),

                              SizedBox(height: 20,),

                              Container(
                                  margin: EdgeInsets.symmetric(horizontal:20),
                                  child:TextFormField(
                                      controller: name,
                                      validator: (value){
                                        if (value==null || value.isEmpty || value==" ") {
                                          return "Name is required ";
                                        }
                                        if(RegExp(r'[0-9]').hasMatch(value)){
                                          return "Name cannot contain numbers ";
                                        }

                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        label: Text("Enter your name"),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide: BorderSide(
                                              color: Colors.lime
                                          ),
                                        ),
                                        prefixIcon: Icon(Icons.person),
                                      )
                                  )
                              ),

                              SizedBox(height: 20,),

                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  controller: age,
                                  keyboardType: TextInputType.number, // Set keyboard type to number
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly // Allow only digits
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty || value.trim().isEmpty) {
                                      return "Age is required";
                                    }
                                    if (int.tryParse(value) == null) {
                                      return "Age must be a number";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Enter your Age",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide(color: Colors.lime),
                                    ),
                                    prefixIcon: Icon(Icons.person),
                                  ),
                                ),
                              ),


                              SizedBox(height:20,),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal:20),
                                  child:TextFormField(
                                      controller: email,
                                      validator: (value){
                                        if (value==null || value.isEmpty || value==" ") {
                                          return "Email is required ";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        label: Text("Enter your email"),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide: BorderSide(
                                              color: Colors.lime
                                          ),
                                        ),
                                        prefixIcon: Icon(Icons.person),
                                      )
                                  )
                              ),

                              SizedBox(height: 20,),

                              Container(
                                  margin: EdgeInsets.symmetric(horizontal:20),
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
                                        label: Text("Enter your password"),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide: BorderSide(
                                              color: Colors.lime
                                          ),
                                        ),
                                        prefixIcon: Icon(Icons.key),
                                      )
                                  )
                              ),

                              SizedBox(height:20,),

                              ElevatedButton(onPressed: (){

                                if (_formkey.currentState!.validate()) {

                                  InsertUserwithImg();

                                }
                              },
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(width: 0, color: Colors.white), backgroundColor: Colors.white,
                                  elevation: 0,
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(top: 20,left: 30,right: 30),
                                  width: 350,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Color(0xf0000523),
                                    // border: Border.all(color: Color(0xffffffff),width: 3),
                                    borderRadius: BorderRadius.circular(40),

                                  ),
                                  child:Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4,vertical:1 ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 120,),
                                        Text("Register", style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            color:  Color(0xffffffff)
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Text("Already Have an Account ? ",style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w300),),
                                  /*  ElevatedButton(onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context) => signup(),));
                     }, child:  Text("SignUp",style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600),)),*/

                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Login(),));
                                    },
                                    child:Text("SignIn",style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w700),),
                                  ),
                                ],
                              )
                            ],
                          ),
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

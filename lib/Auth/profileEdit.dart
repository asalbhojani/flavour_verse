import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class profileEdit extends StatefulWidget {

  String UId;
  String UName;
  String UAge;
  // String UImage;
  String UEmail;
  String UPassword;

  // required this.UImage,
  profileEdit({required this.UId,required this.UName,required this.UAge,required this.UEmail,required this.UPassword});


  @override
  State<profileEdit> createState() => _profileEditState();
}

class _profileEditState extends State<profileEdit> {

  TextEditingController name=TextEditingController();
  TextEditingController age=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController pass =TextEditingController();

  File? userProfile;

  updateUserImg()async{
    //
    // FirebaseStorage.instance.refFromURL(widget.UImage).delete();
    UploadTask uploadTask = FirebaseStorage.instance.ref().child("User-Images").child(Uuid().v1()).putFile(userProfile!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String userImage = await taskSnapshot.ref.getDownloadURL();
    UpdateUser(imgUrl: userImage);
    Navigator.pop(context);
  }

  UpdateUser({String? imgUrl})async{

    await FirebaseFirestore.instance.collection("userData").doc(widget.UId).update(
        {
          "User-Id":widget.UId,
          "User-Name":name.text.toString(),
          "User-Age":age.text.toString(),
          "User-Image":imgUrl,
          "User-Email":email.text.toString(),
          "User-Password":pass.text.toString(),

        });

    Navigator.pop(context);

  }

  @override
  void initState() {
    // TODO: implement initState

    name.text=widget.UName;
    age.text=widget.UAge;
    email.text= widget.UEmail;
    pass.text=widget.UPassword;

    super.initState();
  }

  var _formkey =GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [

          Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            width: double.infinity,

            child: Column(
              children:[
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8kRhrC41k2YTHBlUgAE0NqJ8WzkfXyspDhr7hgdDMp3ozch8W54HXdi3mOBIgKZy5VJM&usqp=CAU"),
                    ),
                  ),
                ),

                Form(
                  key: _formkey,
                  child: Column(
                    children: [

                      SizedBox(height: 20,),

                      Text("Update!",style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600),),

                      SizedBox(height: 20,),

                      GestureDetector(
                          onTap: ()async{
                            XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                            if (selectedImage!=null) {
                              File convertedImg = File(selectedImage.path);
                              setState(() {
                                userProfile = convertedImg;
                              });
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Image Selected")));
                            }
                          },
                          child: userProfile==null?CircleAvatar(
                            radius: 40,
                            // backgroundImage: NetworkImage(widget.UImage),
                          ):CircleAvatar(
                            radius: 40,
                            backgroundImage: userProfile!=null?FileImage(userProfile!):null,
                          )
                      ),

                      SizedBox(height: 20,),

                      Container(
                          margin: EdgeInsets.symmetric(horizontal:20),
                          child:TextFormField(
                              controller: name,
                              validator: (value){
                                if (value==null || value.isEmpty || value==" ") {
                                  return "Name is required ";
                                }
                              },
                              decoration: InputDecoration(
                                label: Text("Enter your name"),
                                border: OutlineInputBorder(

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
                              controller: age,
                              validator: (value){
                                if (value==null || value.isEmpty || value==" ") {
                                  return "Age is required ";
                                }
                              },
                              decoration: InputDecoration(
                                label: Text("Enter your Age"),
                                border: OutlineInputBorder(

                                  borderSide: BorderSide(
                                      color: Colors.lime
                                  ),
                                ),
                                prefixIcon: Icon(Icons.person),
                              )
                          )
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
                              },
                              decoration: InputDecoration(
                                label: Text("Enter your email"),
                                border: OutlineInputBorder(

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
                              },
                              obscureText: true,
                              obscuringCharacter: "*",
                              decoration: InputDecoration(
                                label: Text("Enter your password"),
                                border: OutlineInputBorder(

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
                          /*   print(name.text.toString());*/

                          UpdateUser();

                          email.clear();
                          pass.clear();
                          age.clear();
                          name.clear();

                        }

                      },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xff002a62)),
                          ),
                          child: Text("Update", style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500
                          ),)),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          //    Text("Already Have an Account ? ",style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w300),),
                          //    /*  ElevatedButton(onPressed: (){
                          //   Navigator.push(context, MaterialPageRoute(builder: (context) => signup(),));
                          // }, child:  Text("SignUp",style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600),)),*/
                          //
                          //    GestureDetector(
                          //      onTap: (){
                          //        Navigator.push(context, MaterialPageRoute(builder: (context)=> Login(),));
                          //      },
                          //      child:Text("SignIn",style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w700),),
                          //    ),
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
    );
  }
}

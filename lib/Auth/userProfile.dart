import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Bottom_Navigation.dart';
import '../Theme/changeThemeButton.dart';
import 'Login.dart';

class userProfile extends StatefulWidget {
  const userProfile({super.key});

  @override
  State<userProfile> createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  Future getUser()async{
    SharedPreferences userEmail = await SharedPreferences.getInstance();
    return userEmail.getString("UserLoggedIn");
  }
  String uEmail = '';
  @override
  void initState() {
    // TODO: implement initState
    getUser().then((value) {
      setState(() {
        uEmail = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("userData").where('User-Email',isEqualTo:uEmail)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    var dataLength = snapshot.data!.docs.length;

                    return dataLength == 0
                        ? Center(
                      child: Text("Nothing to show"),
                    )
                        : ListView.builder(
                        itemCount: dataLength,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          String userId =
                              snapshot.data!.docs[index].id;
                          String userName =
                              snapshot.data!.docs[index]['User-Name'];
                          String userAge =
                              snapshot.data!.docs[index]['User-Age'];
                          // String userImage =
                          // snapshot.data!.docs[index]['User-Image'];
                          String userEmail =
                             snapshot.data!.docs[index]['User-Email'];
                          String userPassword =
                             snapshot.data!.docs[index]['User-Password'];

                          return Stack(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 250,
                                color: Theme.of(context).primaryColor,

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Container(
                                          padding: EdgeInsets.all(7.0),
                                          margin: EdgeInsets.only(left: 40, top: 50),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                              borderRadius: BorderRadius.circular(40)),
                                          child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => bottomNavigation(),));
                                              },

                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .arrow_back_ios_rounded, // Arrow icon
                                                    size: 18, // Icon size
                                                    color: Theme.of(context).iconTheme.color, // Icon color (match the container background)
                                                  ),
                                                  Text("Back",style: TextStyle(
                                                      color: Theme.of(context).iconTheme.color
                                                  ),)
                                                ],
                                              )
                                          ),
                                        ),

                                      ],),

                                    // Container(
                                    //   margin: EdgeInsets.only( top: 5),
                                    //   child: Center(
                                    //     child: Text(
                                    //       "Welcome Back ",
                                    //       style: GoogleFonts.poppins(
                                    //         fontSize: 20,
                                    //         fontWeight:
                                    //             FontWeight.w600,
                                    //         color: Color(0xffffffff),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // Container(
                                    //   // margin: EdgeInsets.only(left: 100,),
                                    //   child: Center(
                                    //     child: Text(
                                    //       "$userName",
                                    //       style: GoogleFonts.poppins(
                                    //         fontSize: 17,
                                    //         fontWeight:
                                    //             FontWeight.w500,
                                    //         color: Color(0xffffffff),
                                    //       ),),),),

                                  ],),),

                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(vertical: 200),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(40),
                                        topLeft: Radius.circular(40))),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:EdgeInsets.only(top:120,),
                                      child: Center(
                                        child: Text("$userName",style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          // color: Theme.of(context).primaryColor,
                                        ),),
                                      ),
                                    ),

                                    Center(
                                      child: Text("$userEmail",style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Color(0xf08f8f8f),
                                      ),),
                                    ),

                                    SizedBox(height: 20,),

                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 50),
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        // color: Colors.orange
                                      ),
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => bottomNavigation(),));
                                              },

                                              child:
                                              Text(
                                                String.fromCharCode(CupertinoIcons.pen.codePoint),
                                                style: TextStyle(
                                                  inherit: false,
                                                  color: Theme.of(context).primaryColor,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: CupertinoIcons.pen.fontFamily,
                                                  package: CupertinoIcons.pen.fontPackage,
                                                ),
                                              )
                                            // Icon(
                                            //   Icons.edit_outlined, // Arrow icon
                                            //   size: 30, // Icon size
                                            //   color: Color(0xffff9e20), // Icon color (match the container background)
                                            // ),
                                          ),
                                          SizedBox(width: 25,),
                                          Text("Personal Information",style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17,
                                            color: Color(0xf0343434),
                                          ),),

                                        ],),
                                    ),


                                    SizedBox(height: 10,),

                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 50),
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        // color: Colors.orange
                                      ),
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => bottomNavigation(),));
                                              },

                                              child:
                                              Text(
                                                String.fromCharCode(CupertinoIcons.moon.codePoint),
                                                style: TextStyle(
                                                  inherit: false,
                                                  color: Theme.of(context).primaryColor,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: CupertinoIcons.moon.fontFamily,
                                                  package: CupertinoIcons.moon.fontPackage,
                                                ),
                                              )
                                            // Icon(
                                            //   Icons.edit_outlined, // Arrow icon
                                            //   size: 30, // Icon size
                                            //   color: Color(0xffff9e20), // Icon color (match the container background)
                                            // ),
                                          ),
                                          SizedBox(width: 25,),
                                          Text("Night Mode",style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17,
                                            color: Color(0xf0343434),
                                          ),),
                                          // SizedBox(width: 75,),
                                          ChangeThemeButtonWidget(),

                                        ],),
                                    ),



                                    SizedBox(height: 10,),

                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 45),
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        // color: Colors.orange
                                      ),
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          GestureDetector(
                                            onTap: () async {
                                              FirebaseAuth.instance.signOut();
                                              SharedPreferences userLoginDetails= await SharedPreferences.getInstance();
                                              userLoginDetails.clear();
                                              Navigator.push(context,MaterialPageRoute(builder: (context) => Login()));
                                            },

                                            child:
                                            Row(
                                              children: [
                                                Text(
                                                  String.fromCharCode(CupertinoIcons.square_arrow_right.codePoint),
                                                  style: TextStyle(
                                                    inherit: false,
                                                    color: Theme.of(context).primaryColor,
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: CupertinoIcons.square_arrow_right.fontFamily,
                                                    package: CupertinoIcons.square_arrow_right.fontPackage,
                                                  ),
                                                ),
                                                SizedBox(width: 25,),
                                                Text("Logout",style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 17,
                                                  color: Color(0xf0343434),
                                                ),),
                                              ],),

                                            // Icon(
                                            //   Icons.edit_outlined, // Arrow icon
                                            //   size: 30, // Icon size
                                            //   color: Color(0xffff9e20), // Icon color (match the container background)
                                            // ),


                                          ),
                                        ],),
                                    ),

                                    // Container(
                                    //   padding: EdgeInsets.all(9.0),
                                    //   margin: EdgeInsets.only(left: 120, top: 80),
                                    //   decoration: BoxDecoration(
                                    //       color: Color(0xf0000523),
                                    //       borderRadius: BorderRadius.circular(40)),
                                    //   child: GestureDetector(
                                    //     onTap: () {
                                    //       Navigator.push(context, MaterialPageRoute(builder: (context) => bottomNavigation(),));
                                    //     },
                                    //
                                    //     child: Icon(
                                    //       Icons.edit, // Arrow icon
                                    //       size: 20, // Icon size
                                    //       color: Color(0xffc0c0c0), // Icon color (match the container background)
                                    //     ),
                                    //   ),),


                                  ],),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 90,top:100),
                                padding:EdgeInsets.symmetric(horizontal:10,vertical:10),
                                decoration: BoxDecoration(
                                  color:Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(120),
                                ),
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundColor: Color(0xf0ababab),
                                  // backgroundImage: NetworkImage(userImage),
                                  // child: Icon(Icons.person,color: Color(
                                  //     0xf08c8c8c),size: 200,),
                                ),
                              ),
                            ],
                          );
                        });
                  }

                  return Container();
                }),
          ],
        ),
      ),
    );
  }
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'Bottom_Navigation.dart';
import 'DescriptionScreen.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> searchData = [];

  Future<void> fetchData(String searchQuery) async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$searchQuery'));
    if (response.statusCode == 200) {
      setState(() {
        searchData = json.decode(response.body)['meals'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              if (value.isNotEmpty) {
                fetchData(value);
              } else {
                setState(() {
                  searchData = [];
                });
              }
            },
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).iconTheme.color,
            ),
            decoration: InputDecoration(
              hintText: 'Search Here',
              hintStyle: TextStyle(color: Theme.of(context).iconTheme.color),
              contentPadding: const EdgeInsets.only(left: 60, top: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  // perform search
                  fetchData(searchController.text);
                },
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            cursorColor: Theme.of(context).iconTheme.color,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomNavigation()));
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20 ),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          );
        }),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          top:true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10, left: 20),
                child: Text(
                  "Search Results",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              searchData.isEmpty
                  ? Container(
                margin: const EdgeInsets.only(top: 40),
                    child: Center(
                                    child: Text("Nothing To Show",style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                                    ),),
                                  ),
                  )
                  : SizedBox(
                 height: MediaQuery.of(context).size.height * 0.73 ,
                    child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: searchData.length,
                                    itemBuilder: (context, index) {
                    var item = searchData[index];
                    var idMeal=item['idMeal'];
                    return ListTile(
                      onTap: () {
                        // Handle onTap
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DescriptionScreen(idMeal: idMeal),));
                        },

                      leading: CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(item['strMealThumb']),
                      ),
                      title: Text(item['strMeal']),
                      subtitle: Text(item['strCategory']),
                    );
                                    },
                                  ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

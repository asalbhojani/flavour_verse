import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'Bottom_Navigation.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

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
        backgroundColor: Colors.white,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 5),
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
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.black),
              contentPadding: EdgeInsets.only(left: 20, top: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  // perform search
                  fetchData(searchController.text);
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
            cursorColor: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => bottomNavigation()));
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          );
        }),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 10, left: 20),
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
                padding: EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: Text(
                  'No results found',
                  style: TextStyle(fontSize: 16),
                ),
              )
                  : ListView.builder(
                shrinkWrap: true,
                itemCount: searchData.length,
                itemBuilder: (context, index) {
                  var item = searchData[index];
                  return ListTile(
                    onTap: () {
                      // Handle onTap
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
            ],
          ),
        ),
      ),
    );
  }
}

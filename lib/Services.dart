 import 'package:http/http.dart' as http;

class MyServices{

  static Future apifetch() async{

    var request = http.Request('GET', Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      return res;
    }
    else {
      print(response.reasonPhrase);
      return null;
    }

  }


//Alphabetical Order fetch
  static Future apifetch2()async{
    var request = http.Request('GET', Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?i'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      return res;
    }
    else {
      print(response.reasonPhrase);
      return null;
    }
  }


  //Categories
  static Future apifetchCat()async{
    var request = http.Request('GET', Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      return res;
    }
    else {
      print(response.reasonPhrase);
      return null;
    }

  }


  //Description
  static Future<dynamic> descfetch(var id) async{
    var request = http.Request('GET', Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     var res = await response.stream.bytesToString();
     return res;
    }
    else {
      print(response.reasonPhrase);
      return null;
    }


  }


}
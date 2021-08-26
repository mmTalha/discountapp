import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class Horizontallist extends StatefulWidget {
  @override
  State<Horizontallist> createState() => _HorizontallistState();
}

class _HorizontallistState extends State<Horizontallist> {
  Future getproduct() async {
    var url =
    Uri.http('https://discounthub.uptreedevelopers.com','/api/fetch_merchants.php' );

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get( Uri.parse('https://jsonplaceholder.typicode.com/albums/1' ) ,
      headers: {

        'Content-Type': 'application/json'
      },
    );


    var responseJson = await json.decode(response.body);
    var data = responseJson;
    var product = data;
    print(product);
    return product;
  }
  Future  fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://discounthub.uptreedevelopers.com/api/fetch_merchants.php'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body) ;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    //  Container(
    // height:100 .0,
    // child:
    //
    //
    //
    //      ),

    return FutureBuilder(
        future: fetchAlbum(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Center(child: CircularProgressIndicator());
      } else {
        print(' link${snapshot.data}   ');
      }
      return Container(
        height: 80.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            category(
              image_caption: 'shirt',
              image_location: 'assets/watch.jpg',
            ),
            category(
              image_caption: 'Accesories',
              image_location: 'assets/shoes.jpg',
            ),
            category(
              image_caption: 'Dress',
              image_location: 'assets/shoes1.jpg',
            ),
          ],
        ),
      );

    });
  }
}

class category extends StatelessWidget {
  final String? image_location;

  final String? image_caption;

  category({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.all(10),
          width: 110.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: AssetImage(
                  image_location!,
                ),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black54, BlendMode.colorBurn)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              image_caption!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

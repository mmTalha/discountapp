import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:native_font/native_font.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:untitled2/details.dart';
import 'package:untitled2/home.dart';
import 'package:http/http.dart' as http;

class seemore extends StatefulWidget {
  const seemore({Key? key}) : super(key: key);

  @override
  State<seemore> createState() => _seemoreState();
}

class _seemoreState extends State<seemore> {
  Future<List> fetchAlbum() async {
    final response = await http.get(Uri.parse(
        'https://discounthub.uptreedevelopers.com/api/fetch_merchants.php'));

    if (response.statusCode == 200) {
      List datas = (jsonDecode(response.body));
      return datas;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1200,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: Container(
                  height: 80,
                  color: Color.fromRGBO(22, 97, 207, 10),
                  child:Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Top Picks For You',
                          style: nativeFontTextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                  future: fetchflat(),
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                      snapshot.hasData
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: 650,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => details(
                                                id: snapshot.data![index]['id'],
                                                image:
                                                    'https://discounthub.uptreedevelopers.com/${snapshot.data![index]['header_image1']}',
                                                address: snapshot.data![index]
                                                    ['category'],
                                                phoneno:
                                                    ' ${snapshot.data![index]['\tphone']}',
                                              )),
                                    );
                                  },
                                  child: bigoffers(
                                    caption:
                                        'Flat ${snapshot.data![index]['total_discount']}% off',
                                    image_location: snapshot.data![index]
                                        ['header_image1'],
                                    image_caption: snapshot.data![index]
                                        ['logo'],
                                    second: snapshot.data![index]['category'],
                                  ),
                                ),
                              ),
                            )
                          : Center(
                               child: Text('loading'),
                            )),
            ],
          ),
        ),
      ),
    );
  }
}

class bigoffers extends StatelessWidget {
  final String? image_location;

  final String? image_caption;
  final String? caption;
  final String? second;
  final String? id;
  final String? image;

  bigoffers({
    this.image_location,
    this.image_caption,
    this.caption,
    this.second,
    this.id,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: InkWell(
          child: Container(
            height: 200,
            width: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18.0),
                              child: CachedNetworkImage(
                                width: 300,
                                fit: BoxFit.cover,
                                imageUrl:
                                    "https://discounthub.uptreedevelopers.com/$image_location",
                                errorWidget: (context, url, error) =>
                                    new Icon(Icons.error),
                              ),
                            ),
                            // Image.file(   ,width: 300,
                            //   fit: BoxFit.cover,)
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: Container(
                          width: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://discounthub.uptreedevelopers.com/$image_caption'),
                            ),

                            // image: AssetImage('assets/Abudllah_Lights.jpg')),
                            // border: Border.all(
                            //   color: Colors.white,
                            //   width: 5,
                            // ),
                          ),
                          height: 70,
                        ),
                      ),
                      left: 210,
                      top: 110,

                      // left: (MediaQuery.of(context).size.width / 1) -   10,
                      // top:90,
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    caption!,
                    style: nativeFontTextStyle(
                      fontFamily: 'Roboto',
                      color: Color.fromRGBO(22, 97, 207, 10),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    second!,
                    style: nativeFontTextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class details extends StatefulWidget {
  final id;
  final image;
  final address;

  details({Key? key, this.id, this.image,this.address}) : super(key: key);

  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<details> {
 var address1 = 'lahore';
  void _launchMapsUrl( ) async {
    final url = 'https://www.google.com/maps/search/${Uri.encodeFull(widget.address)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }






  Future<List> details() async {
    final response = await http.get(Uri.parse(
        'https://discounthub.uptreedevelopers.com/api/fetch_promotion.php?id=${widget.id}'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List datas = (jsonDecode(response.body));
      print(datas);
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/discountlogo.png',
          height: 40,
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: details(),
          builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) => snapshot
                  .hasData
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       Image.network( '${widget.image}'),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(snapshot.data![index]['brand_name']),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('clothing'),
                      ),
                      // Row(
                      //   children: [
                      //     Icon(Icons.location_on),
                      //     Text('0.72'),
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        width: 2, color:  Color . fromRGBO(22, 97, 207,10),)),
                                child: Icon(
                                  Icons.phone,
                                  color:  Color . fromRGBO(22, 97, 207,10),,
                                ),
                              ),
                              Text('phone')
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        width: 2, color:  Color . fromRGBO(22, 97, 207,10),)),
                                child: Icon(
                                  Icons.lock_clock_outlined,
                                  color:  Color . fromRGBO(22, 97, 207,10),,
                                ),
                              ),
                              Text('Timing')
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap:  _launchMapsUrl,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 2, color: Color . fromRGBO(22, 97, 207,10),    )),
                                  child: Icon(
                                    Icons.map,
                                    color:Color . fromRGBO(22, 97, 207,10),
                                  ),
                                ),
                              ),
                              Text('Location')
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        width: 2, color: Color . fromRGBO(22, 97, 207,10),)),
                                child: Icon(
                                  Icons.reviews,
                                  color: Color . fromRGBO(22, 97, 207,10),
                                ),
                              ),
                              Text('Reviews'),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'offers',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(20),
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Color . fromRGBO(22, 97, 207,10),
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Flat  ${snapshot.data![index]['user_discount']}% off ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            Text(
                              snapshot.data![index]['category'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}

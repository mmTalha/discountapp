import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:native_font/native_font.dart';

import 'package:http/http.dart' as http;
import 'package:untitled2/details.dart';
import 'package:untitled2/provider.dart';

class searchproducts extends StatefulWidget {
  const searchproducts({Key? key}) : super(key: key);

  @override
  _searchproductsState createState() => _searchproductsState();
}

class _searchproductsState extends State<searchproducts> {
  final TextEditingController _searchQuery = TextEditingController();
  Future<List>? data;
  Future<List> search(brandname) async {
    var data = {
      'brand_name': brandname,
    };
    final response = await http.post(
        Uri.parse(
          'https://discounthub.uptreedevelopers.com/api/search_brand.php',
        ),
        body: data);

    if (response.statusCode == 200) {
      var datas = (jsonDecode(response.body));

      print(datas);

      return datas;

    } else {

      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

@override
  void initState() {

     data ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EligiblityScreenProvider>(
        create: (context) => EligiblityScreenProvider(),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Image.asset(
                'assets/discountlogo.png',
                height: 30,
              ),
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: true,
            ),
            body: Consumer<EligiblityScreenProvider>(
                builder: (context, provider, child) {
              return SingleChildScrollView(
                child: Column(children: [
                  Container(
                    height:  150,
                    margin: EdgeInsets.only(top: 20),
                    child: Center(
                        child: Column(
                      children: [
                        // Text(
                        //   'Search here by Name',
                        //   style:nativeFontTextStyle(
                        //       fontFamily: 'Roboto',
                        //       color: Color.fromRGBO(22, 97, 207, 10),
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.w500),
                        // ),
                        Container(
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: TextFormField(
                              controller: _searchQuery,
                               onChanged: (val){

                                   setState(() {
                                     data = provider.search(_searchQuery.text);
                                   });

                               },
                              decoration: InputDecoration(

                                  fillColor: Colors.white,
                                  focusColor: Colors.white,
                                  hoverColor: Colors.white,
                                  prefixIcon: InkWell(
                                    onTap: () {

                                      provider.search(_searchQuery.text);
                                      setState(() {
                                        data = provider.search(_searchQuery.text);
                                      });
                                      _searchQuery.clear();
                                    },
                                    child: Icon(
                                      CupertinoIcons.search,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  prefixStyle: TextStyle(color: Colors.white),
                                  hintText: 'Search here by Name ',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.red))),
                            ),
                          ),
                        ),
                      ],
                    )),
                  ),
                  Consumer<EligiblityScreenProvider>(
                      builder: (context, provider, child) {
                    return FutureBuilder(
                        future: data,
                        builder: (BuildContext ctx,
                                AsyncSnapshot<List> snapshot) =>
                            snapshot.hasData
                                ? Container(
                                    decoration: BoxDecoration(),
                                    height: 300,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 1 ,
                                      itemBuilder:
                                          (BuildContext context, index) =>
                                              GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => details(
                                                        id: snapshot.data![index]
                                                            ['id'],
                                                        image:
                                                            'https://discounthub.uptreedevelopers.com/${snapshot.data![index]['header_image1']}',
                                                        address:
                                                            snapshot.data![index]
                                                                ['address'],
                                                      )));
                                        },
                                        child: bigoffers(
                                          caption: 'Flat ${snapshot.data![index]['total_discount']}% off',
                                          image_location: snapshot.data![index]
                                              ['header_image1'],
                                          image_caption: snapshot.data![index]
                                              ['logo'],
                                          second: snapshot.data![index]
                                              ['category'],
                                        ),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Text('search items'),
                                  ));

                  }),

                ]),
              );
            }),
          );
        }));
  }
}

class offers extends StatelessWidget {
  final String? image_location;

  final String? image_caption;
  final String? caption;
  final String? second;
  final String? id;
  final String? image;

  offers({
    this.image_location,
    this.image_caption,
    this.caption,
    this.second,
    this.id,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        child: Container(
          height: 500.0,
          width: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 100,
                        child: CachedNetworkImage(
                          width: 300,
                          fit: BoxFit.cover,
                         imageUrl:
                              "https://discounthub.uptreedevelopers.com/$image_location",
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),
                        // Image.file(   ,width: 300,
                        //   fit: BoxFit.cover,)
                      ),
                    ],
                  ),
                  Positioned(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        width: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://discounthub.uptreedevelopers.com/$image_caption'),
                          ),

                          // image: AssetImage('assets/Abudllah_Lights.jpg')),
                          border: Border.all(
                            color: Colors.white,
                            width: 5,
                          ),
                        ),
                        height: 70,
                      ),
                    ),
                    left: 190,
                    top: 60,

                    // left: (MediaQuery.of(context).size.width / 1) -   10,
                    // top:90,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                caption!,
                style: nativeFontTextStyle(
                    fontFamily: 'Roboto',color: Colors.blue, fontSize: 10),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                second!,
                style: nativeFontTextStyle(
                    fontFamily: 'Roboto',fontSize: 10),
              ),
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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        child: Container(
          height: 250.0,
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
                    fontFamily: 'Roboto',color: Color.fromRGBO(22, 97, 207, 10),
                    fontSize: 20,fontWeight: FontWeight.w500,
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
                    fontFamily: 'Roboto',fontSize: 10,  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
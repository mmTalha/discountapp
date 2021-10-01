import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:untitled2/cards.dart';
import 'package:untitled2/details.dart';
import 'package:untitled2/horizontal_listview.dart';
import 'package:untitled2/model_user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:untitled2/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/see_more.dart';
import 'package:untitled2/sigin.dart';
import 'package:untitled2/signin.dart ';
import 'package:native_font/native_font.dart';

class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  _mainpageState createState() => _mainpageState();
}

Future<List> _loadData() async {
  List posts = [];
  try {
    const API = 'https://jsonplaceholder.typicode.com/posts';

    final http.Response response = await http.get(Uri.parse(API));
    posts = json.decode(response.body);
  } catch (err) {
    print(err);
  }

  return posts;
}

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

Future<List> fetchflat() async {
  final response = await http.get(Uri.parse(
      'https://discounthub.uptreedevelopers.com/api/fetch_promotion_ads.php'));

  if (response.statusCode == 200) {
    List datas = (jsonDecode(response.body));
    return datas;
  } else {
    throw Exception('Failed to load album');
  }
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

final List<String> images = [
  'assets/crousel1.jpg',
  'assets/crousel2.jpg',
  'assets/crousel3.jpg',
  'assets/crousel4.jpg',
  'assets/crousel5.jpg',
  'assets/crousel6.jpg',
  'assets/crousel7.jpg',
  'assets/crousel8.jpg',
  'assets/crousel9.jpg',
  'assets/crousel10.jpg',
];

@override
class _mainpageState extends State<mainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/discountlogo.png',
            height: 30,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => searchproducts(),
                      ));
                },
                icon: const Icon(
                  CupertinoIcons.search,
                  size: 20,
                  color: Colors.black,
                )),
          ],
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        drawer: Drawer(
          elevation: 2.5,
          child: ListView(
              children: [
            SafeArea(
              child: Container(
                height: 200,
                color: Color.fromRGBO(22, 97, 207, 10),
                child: Center(
                    child: Text(
                  'Discount hub',
                  style: nativeFontTextStyle(
                      fontFamily: 'Roboto', color: Colors.white, fontSize: 20),
                )),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => mainpage(),
                    ));
              },
              child: ListTile(
                title: Text(
                  'Home',
                  style: nativeFontTextStyle(
                      fontFamily: 'Roboto', color: Colors.black),
                ),
                leading: Icon(
                  Icons.home,
                  color: Color.fromRGBO(22, 97, 207, 10),
                ),
              ),
            ),
            // InkWell(
            //   onTap: () {},
            //   child: ListTile(
            //     title: Text(
            //       'Profile',
            //       style: nativeFontTextStyle(
            //           fontFamily: 'Roboto',color: Colors.black),
            //     ),
            //     leading: Icon(
            //       Icons.account_box,
            //       color: Color.fromRGBO(22, 97, 207, 10),
            //     ),
            //   ),
            // ),
            InkWell(
              onTap: () {
                Widget cancelButton = TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
                Widget continueButton = TextButton(
                  child: Text("logout"),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => siginup()),
                      (route) => false,
                    );
                  },
                );

                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: Text("Logout"),
                  content: Text("Do you want to Logout?"),
                  actions: [
                    cancelButton,
                    continueButton,
                  ],
                );

                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              },
              child: ListTile(
                title: Text(
                  ' Logout',
                  style: nativeFontTextStyle(
                      fontFamily: 'Roboto', color: Colors.black),
                ),
                leading: Icon(
                  Icons.logout,
                  color: Color.fromRGBO(22, 97, 207, 10),
                ),
              ),
            ),
            // InkWell(
            //   onTap: () async {
            //     SharedPreferences prefs = await SharedPreferences.getInstance();
            //     prefs.clear();
            //     Navigator.pushAndRemoveUntil(
            //       context,
            //       PageRouteBuilder(
            //           transitionDuration: Duration(seconds: 2),
            //           pageBuilder: (context, animation, animationtime) =>
            //               siginup(),
            //           transitionsBuilder:
            //               (context, animation, animationtime, child) {
            //             animation = CurvedAnimation(
            //                 parent: animation, curve: Curves.elasticInOut);
            //             return ScaleTransition(
            //               scale: animation,
            //               child: child,
            //               alignment: Alignment.center,
            //             );
            //           }),
            //       (route) => false,
            //     );
            //   },
            //   child: ListTile(
            //     title: Text(
            //       'Settings',
            //       style: nativeFontTextStyle(
            //           fontFamily: 'Roboto', color: Colors.black),
            //     ),
            //     leading: Icon(
            //       Icons.settings,
            //       color: Color.fromRGBO(22, 97, 207, 10),
            //     ),
            //   ),
            // )
          ]),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Horizontallist(),
            CarouselSlider(
              options: CarouselOptions(
                 
                height: 150,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                scrollDirection: Axis.horizontal,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),

              ),
              items: images.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return   Container(
                        padding: EdgeInsets.all(10),
                          height: 40.0,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 2.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          child: ClipRRect(
                             borderRadius:BorderRadius.circular(15),
                            child: Card(
                              elevation: 2.5,
                              child: Image.asset(
                                i,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(
               height: 5,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 30, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Picks For You',
                    style: nativeFontTextStyle(
                      fontFamily: 'Roboto',
                      color: Color.fromRGBO(135, 132, 132, 10),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => seemore(),
                          ));
                    },
                    child: Text(
                      'See more',
                      style: nativeFontTextStyle(
                        fontFamily: 'Roboto',
                        color: Color.fromRGBO(135, 132, 132, 10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 3,
            ),


            FutureBuilder(
                future: fetchAlbum(),
                builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                    snapshot.hasData
                        ? Container(
                            decoration: BoxDecoration(),
                            height: 180,
                            width:  400,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
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
                                        phoneno: snapshot.data![index]
                                            ['\tphone'],
                                      ),
                                    ),
                                  );
                                },
                                  child: offers(
                                  id: snapshot.data![index]['id'],
                                  caption:
                                      'Flat ${snapshot.data![index]['total_discount']}% off',
                                  image_location: snapshot.data![index]
                                      ['header_image1'],
                                  image_caption: snapshot.data![index]['logo'],
                                  second: snapshot.data![index]['category'],
                                ),
                              ),
                            ),
                          ):
                          Center(
                            child: Text('loading'),
                          )
            ),

            //new card
            // SizedBox(
            //   height: 10,
            // ),
            // Text('Treding near you'),
            // SizedBox(
            //   height: 15,
            // ),
            // //main container
            // Container(
            //   width: 300, //actualwidth300
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Stack(
            //         overflow: Overflow.visible,
            //         children: <Widget>[
            //           Column(
            //             children: <Widget>[
            //               Container(
            //                 height: 150,
            //                 child: Image.asset(
            //                   'assets/crousel8.jpg',
            //                   fit: BoxFit.cover,
            //                 ),
            //               ),
            //             ],
            //           ),
            //           Positioned(
            //             child: ClipRRect(
            //               borderRadius: BorderRadius.circular(8.0),
            //               child: Container(
            //                 width: 80,
            //                 decoration: BoxDecoration(
            //                   image: DecorationImage(
            //                       image: AssetImage(
            //                           'assets/Bath and Kitchen.jpg')),
            //
            //                 ),
            //                 height: 70,
            //               ),
            //             ),
            //             left: 190,
            //             top: 100,
            //
            //             // left: (MediaQuery.of(context).size.width / 1) -   10,
            //             // top:90,
            //           )
            //         ],
            //       ),
            //       SizedBox(
            //         height: 15,
            //       ),
            //       Text(
            //         'Flat 20% off',
            //         style: TextStyle(color: Colors.blue, fontSize: 20),
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Text(
            //         'clothing',
            //         style: TextStyle(fontSize: 15),
            //       ),
            //     ],
            //   ),
            // ),

            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discounts Near you',
                      style: nativeFontTextStyle(
                        fontFamily: 'Roboto',
                        color: Color.fromRGBO(135, 132, 132, 10),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => searchproducts(),
                            ));
                      },
                      child: Text(
                        'See more',
                        style: nativeFontTextStyle(
                          fontFamily: 'Roboto',
                          color: Color.fromRGBO(135, 132, 132, 10),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(

            ),
            FutureBuilder(
                future: fetchflat(),
                builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                    snapshot.hasData
                        ? Container(
                            height: 500,
                            width: MediaQuery.of(context).size.width,
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
                                  image_caption: snapshot.data![index]['logo'],
                                  second: snapshot.data![index]['category'],
                                ),
                              ),
                            ),
                          )
                        : Center(
                              child: Text('loading'),
                          )),
          ]),
        ));
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
          margin: EdgeInsets.only(left: 20,right: 20),
          height: 150.0,

          width: 320,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
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
                    ],
                  ),
                  Positioned(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
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
                    fontFamily: 'Roboto',
                    color: Color.fromRGBO(22, 97, 207, 10),
                    fontSize: 15),
              ),
              SizedBox(

              ),
              Text(

                second!,
                style: nativeFontTextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 10,

                ),
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
      padding: const EdgeInsets.all(10),
      child: InkWell(
        child: Container(
          height: 200,

          // height: 250.0,
          // width: 350,
          width: 150,
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
                 height: 3,
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
    );
  }
}

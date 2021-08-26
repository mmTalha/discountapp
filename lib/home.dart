import 'dart:convert';
import 'dart:ffi';
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

class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  _mainpageState createState() => _mainpageState();
}

Future<List> _loadData() async {
  List posts = [];
  try {
    // This is an open REST API endpoint for testing purposes
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
    // If the server did return a 200 OK response,
    // then parse the JSON.
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
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List datas = (jsonDecode(response.body));
    return datas;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
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

// final List<String> images = [
//   'https://media.istockphoto.com/photos/young-woman-snorkeling-with-coral-reef-fishes-picture-id939931682?s=612x612',
//   'https://media.istockphoto.com/photos/woman-relaxing-in-sleeping-bag-on-red-mat-camping-travel-vacations-in-picture-id1210134412?s=612x612',
//   'https://media.istockphoto.com/photos/green-leaf-with-dew-on-dark-nature-background-picture-id1050634172?s=612x612',
//   'https://media.istockphoto.com/photos/mountain-landscape-picture-id517188688?s=612x612',
//   // 'https://www.istockphoto.com/en/photo/woman-standing-and-looking-at-lago-di-carezza-in-dolomites-gm1038870630-278083784',
//   'https://media.istockphoto.com/photos/picturesque-morning-in-plitvice-national-park-colorful-spring-scene-picture-id1093110112?s=612x612',
//   'https://media.istockphoto.com/photos/connection-with-nature-picture-id1174472274?s=612x612',
//   'https://media.istockphoto.com/photos/in-the-hands-of-trees-growing-seedlings-bokeh-green-background-female-picture-id1181366400',
//   'https://media.istockphoto.com/photos/winding-road-picture-id1173544006?s=612x612',
//   'https://media.istockphoto.com/photos/sunset-with-pebbles-on-beach-in-nice-france-picture-id1157205177?s=612x612',
//   'https://media.istockphoto.com/photos/waves-of-water-of-the-river-and-the-sea-meet-each-other-during-high-picture-id1166684037?s=612x612',
//   'https://media.istockphoto.com/photos/happy-family-mother-father-children-son-and-daughter-on-sunset-picture-id1159094800?s=612x612',
//   'https://media.istockphoto.com/photos/butterflies-picture-id1201252148?s=612x612',
//   'https://media.istockphoto.com/photos/beautiful-young-woman-blows-dandelion-in-a-wheat-field-in-the-summer-picture-id1203963917?s=612x612',
//   'https://media.istockphoto.com/photos/summer-meadow-picture-id1125637203?s=612x612',
// ];
final double topWidgetHeight = 200;

final double avatarRadius = 50;

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
                      PageRouteBuilder(
                          transitionDuration: Duration(seconds: 2),
                          pageBuilder: (context, animation, animationtime) =>
                              searchproducts(),
                          transitionsBuilder:
                              (context, animation, animationtime, child) {
                            animation = CurvedAnimation(
                                parent: animation, curve: Curves.elasticInOut);
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                              alignment: Alignment.center,
                            );
                          }));
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
          child: ListView(children: [
            Container(
              height: 200,
              color:  Color . fromRGBO(22, 97, 207,10),
              child: Center(
                  child: Text(
                'Discount hub',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text(
                  'Home',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(Icons.home, color:  Color . fromRGBO(22, 97, 207,10),),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text(
                  'Profile',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(Icons.account_box, color: Color . fromRGBO(22, 97, 207,10),),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text(
                  ' Moreitems',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(Icons.bookmark_border, color: Colors.black),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text(
                  'Settings',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(Icons.settings, color:  Color . fromRGBO(22, 97, 207,10),),
              ),
            )
          ]),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 150,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                scrollDirection: Axis.horizontal,
              ),
              items: images.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        child: Image.asset(
                          i,
                          fit: BoxFit.cover,
                        ));
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 15,
            ),
            Horizontallist(),
            SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Top picks for you'),
            ),
            SizedBox(
              height: 5,
            ),

            SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: fetchAlbum(),
                builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                    snapshot.hasData
                        ? Container(
                            decoration: BoxDecoration(),
                            height: 200,
                            width: MediaQuery.of(context).size.width,
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
                                              )));
                                    },
                                    child: offers(
                                id: snapshot.data![index]['id'],
                                caption:'Flat${snapshot.data![index]['total_discount']}%off' ,
                                image_location: snapshot.data![index]
                                      ['header_image1'],
                                image_caption: snapshot.data![index]['logo'],
                                second: snapshot.data![index]['category'],
                              ),
                                  ),
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          )),

            //new card
            SizedBox(
              height: 10,
            ),
            Text('Treding near you'),
            SizedBox(
              height: 15,
            ),
            //main container
            Container(
              width: 300, //actualwidth300
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            height: 150,
                            child: Image.asset(
                              'assets/crousel8.jpg',
                              fit: BoxFit.cover,
                            ),
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
                                  image: AssetImage(
                                      'assets/Bath and Kitchen.jpg')),
                              border: Border.all(
                                color: Colors.white,
                                width: 5,
                              ),
                            ),
                            height: 70,
                          ),
                        ),
                        left: 190,
                        top: 100,

                        // left: (MediaQuery.of(context).size.width / 1) -   10,
                        // top:90,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Flat 20% off',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'clothing',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Treding near you'),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: fetchflat(),
                builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                    snapshot.hasData
                        ? Container(
                            decoration: BoxDecoration(),
                            height: 200,
                            width: MediaQuery.of(context).size.width,
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
                                              )));
                                },
                                child: offers(
                                  caption:'Flat${snapshot.data![index]['total_discount']}%off' ,
                                  image_location: snapshot.data![index]
                                      ['header_image1'],
                                  image_caption: snapshot.data![index]['logo'],
                                  second: snapshot.data![index]['category'],
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
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
          height: 50.0,
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
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                second!,
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:untitled2/billing.dart';
import 'package:untitled2/error.dart';
import 'package:untitled2/home.dart';
import 'package:untitled2/model_user.dart ';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:native_font/native_font.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:extended_image/extended_image.dart';
import 'package:google_fonts/google_fonts.dart';

class details extends StatefulWidget {
  final id;
  final image;
  final address;
  final phoneno;

  details({Key? key, this.id, this.image, this.address, this.phoneno})
      : super(key: key);

  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<details> {
  var address1 = 'lahore';
  String qrCode = 'Unknown';
  var brandname;

  void _launchMapsUrl() async {
    final url =
        'https://www.google.com/maps/search/${Uri.encodeFull(widget.address)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL() async {
    if (await canLaunch("tel://${widget.phoneno} ")) {
      await launch("tel://${widget.phoneno}");
    } else {
      throw 'Could not launch';
    }
  }

  Future    <List>          details() async {
    final response = await http.get(Uri.parse(
        'https://discounthub.uptreedevelopers.com/api/fetch_promotion.php?id=${widget.id}'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var  datas = (jsonDecode(response.body));

      print(datas);

      return datas  ;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });

      print(qrCode);
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(

          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    barcodeScanRes.toString().split(",");
    setState(() {
      qrCode = barcodeScanRes;
    });
    qrCode.contains('${brandname}')
        ? Navigator.push(
            context, MaterialPageRoute(builder: (context) => billing_Screen()))
        :AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.ERROR ,
      body: Center(child: Text(
        'please add valid qrcode',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),),
      title: 'Error',
      desc:   'This is also Ignored',
      btnOkOnPress: () {
        Navigator.pop(context);
      },
    )  ;
    // Navigator.push(
    //         context, MaterialPageRoute(builder: (context) => error()));


    print(qrCode);
  }

  @override
  Widget build(BuildContext context) {

    var detailsone = detailsS;

    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   scanQR();
      //   if (qrCode.contains('${brandname}')) {
      //     return print('true');
      //   } else {
      //     print('false');
      //   }
      //   ;
      // }),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/discountlogo.png',
          height: 40,
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () {
              Navigator.pop(
                  context, MaterialPageRoute(builder: (c) => mainpage()));
            }),
      ),
      body: FutureBuilder  (
          future: details(),
          builder: (BuildContext ctx,   AsyncSnapshot<List> snapshot) =>

          snapshot
              .hasData

              ?
          ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 1,
                  itemBuilder: (BuildContext context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Image.network('${widget.image}'),
                      ExtendedImage.network(
                        widget.image,
                        width: MediaQuery.of(context).size.width,
                        height:   150 ,
                        fit: BoxFit.cover,
                        cache: true,



                        //cancelToken: cancellationToken,
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(

                          snapshot.data![index] ['brand_name'] ,
                        style:
                          nativeFontTextStyle(

                            fontFamily: 'Roboto',
                            fontWeight:FontWeight.w600
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child:
                            Text(
                              'Flat ${snapshot.data![index]['user_discount']}% off ',
                            style: nativeFontTextStyle(
                                fontFamily: 'Roboto',

                                 ),)),
                      // Row(
                      //   children: [
                      //     Icon(Icons.location_on),
                      //     Text('0.72'),
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _launchURL();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        width: 2,
                                        color: Color.fromRGBO(22, 97, 207, 10),
                                      )),
                                  child: Icon(
                                    Icons.phone,
                                    color: Color.fromRGBO(22, 97, 207, 10),
                                  ),
                                ),
                              ),
                              Text('phone',
                                  style: nativeFontTextStyle(
                                    fontFamily: 'Roboto',
                                  )),
                            ],
                          ),
                          SizedBox(width: 20,),
                          // Column(
                          //   children: [
                          //     Container(
                          //       padding: EdgeInsets.all(10),
                          //       decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(100),
                          //           border: Border.all(
                          //             width: 2,
                          //             color: Color.fromRGBO(22, 97, 207, 10),
                          //           )),
                          //       child: Icon(
                          //         Icons.lock_clock_outlined,
                          //         color: Color.fromRGBO(22, 97, 207, 10),
                          //       ),
                          //     ),
                          //     Text('Timing',
                          //         style: nativeFontTextStyle(
                          //           fontFamily: 'Roboto',
                          //         ))
                          //   ],
                          // ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: _launchMapsUrl,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        width: 2,
                                        color: Color.fromRGBO(22, 97, 207, 10),
                                      )),
                                  child: Icon(
                                    Icons.map,
                                    color: Color.fromRGBO(22, 97, 207, 10),
                                  ),
                                ),
                              ),
                              Text('Location',
                                  style: nativeFontTextStyle(
                                    fontFamily: 'Roboto',
                                  ))
                            ],
                          ),
                          SizedBox(width: 20,),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: Color.fromRGBO(22, 97, 207, 10),
                                    )),
                                child: Icon(
                                  Icons.reviews,
                                  color: Color.fromRGBO(22, 97, 207, 10),
                                ),
                              ),
                              Text('Reviews',
                                  style: nativeFontTextStyle(
                                    fontFamily: 'Roboto',
                                  )),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Offers',
                          style: nativeFontTextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontSize: 15),
                        ),
                      ),
                      InkWell(
                        onTap: ()async {
                          brandname = snapshot.data![index]['brand_name'];



                            String barcodeScanRes;
                            // Platform messages may fail, so we use a try/catch PlatformException.
                            try {
                              barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                                  '#ff6666', 'Cancel', true, ScanMode.QR);
                              print(barcodeScanRes);
                            } on PlatformException {
                              barcodeScanRes = 'Failed to get platform version.';
                            }

                            // If the widget was removed from the tree while the asynchronous platform
                            // message was in flight, we want to discard the reply rather than calling
                            // setState to update our non-existent appearance.
                            if (!mounted) return;
                            barcodeScanRes.toString().split(",");
                            setState(() {
                              qrCode = barcodeScanRes;
                            });
                            qrCode.contains('${brandname}')
                                ? Navigator.push(
                                context, MaterialPageRoute(builder: (context) => billing_Screen(
                              brandid:snapshot.data![index]['brand_id'],
                              userid: snapshot.data![index]['id'],
                              dh_discount: 0,
                              date: DateTime.now(),
                              discountprice:snapshot.data![index]['user_discount'] ,
                              user_discount: snapshot.data![index]['user_discount'],
                              username: 'customer',
                            )))
                                :
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => error(name: snapshot.data![index]['brand_name'],)));

                            print(qrCode);

                        },
                        child: Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(20),
                          height: 110,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(22, 97, 207, 10),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Save ${snapshot.data![index]['user_discount']}% off ',

                                style: nativeFontTextStyle(
                                    fontFamily: 'Roboto',
                                    color: Colors.white,
                                    fontSize: 30),
                              ),

                              Text(
                                snapshot.data![index]['category'],
                                style: nativeFontTextStyle(
                                    fontFamily: 'Roboto',
                                    color: Colors.white,
                                    fontSize: 10),
                              ),
                            ],
                          ),
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

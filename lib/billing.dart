import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native_font/native_font.dart';
import 'package:http/http.dart' as http;
import 'package:untitled2/home.dart';

class billing_Screen extends StatefulWidget {
  final userid;
  final brandid;

  final dh_discount;
  final user_discount;
  final discountprice;
  final date;
  final username;

  const billing_Screen(
      {Key? key,
      this.userid,
      this.brandid,
      this.dh_discount,
      this.user_discount,
      this.discountprice,
      this.date,
      this.username})
      : super(key: key);

  @override
  _billing_ScreenState createState() => _billing_ScreenState();
}

class _billing_ScreenState extends State<billing_Screen> {
  final TextEditingController _searchQuery = TextEditingController();
  Map? user;
  var userid;
  var brand_id;
  var total_bill_amount;
  var dh_discount;
  var user_discount;
  var discount_price;
  var date;
  var user_name;
  bool isok = false;
  var finaldiscount;
  var lasttotalprice;

  Future ferchbill() async {
    var data = {
      'user_id': 186,
      'brand_id': 13,
      'total_bill_amount': 200,
      'dh_discount': 10,
      'user_discount': 10,
      'discount_price': 10,
      'date': 2,
      'user_name': 'talh a',
    };

    final response = await http.post(
      Uri.parse(
        'https://discounthub.uptreedevelopers.com/api/billing.php?user_id=${widget.userid}&brand_id=${widget.brandid} &total_bill_amount=${lasttotalprice}&dh_discount=${widget.dh_discount}&user_discount=${widget.user_discount}&discount_price=${finaldiscount}&date=${widget.date}&user_name=${widget.username}',
      ),
    );
    print(widget.userid);
    print(widget.brandid);
    print(_searchQuery.text);
    print(widget.dh_discount);
    print(widget.user_discount);

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
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SafeArea(
              child: Container(
                height: 80,
                color: Color.fromRGBO(22, 97, 207, 10),
                child: Center(
                  child: Text(
                    'Calculate Your Bill',
                    style: nativeFontTextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: 15
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Enter Your Bill',
                style: nativeFontTextStyle(
                    fontFamily: 'Roboto',
                    color: Color.fromRGBO(22, 97, 207, 10),
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: _searchQuery,
                          decoration: InputDecoration(
                              prefixStyle: TextStyle(color: Colors.grey),
                              hintText: 'Enter here',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red))),
                        ),
                      ),
                    )),
                    Container(
                      height: 50,
                      width: 240,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Color.fromRGBO(22, 97, 207, 10),
                        child: Text(
                          'Calculate Discount',
                          style: nativeFontTextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          // userid = widget.userid;
                          // user_discount = widget.user_discount;
                          // brand_id = widget.brandid;
                          // dh_discount = widget.dh_discount;
                          // discount_price = widget.discountprice;
                          // date = DateTime.now();
                          // user_name = widget.username;

                          setState(() {
                            isok = true;
                            var user = int.parse(widget.user_discount);
                            var discount = int.parse(_searchQuery.text);
                            var end = discount * user / 100;
                            print(end);
                            finaldiscount = end;
                            var total = discount - end;
                            print(total);
                            lasttotalprice = total;
                          });

                          // ferchbill();
                          //     int discount = widget.user_discount ;
                          //     int amount = int.parse(_searchQuery.text )   ;
                          //     double discountvalue = (amount*discount)/100;
                          //  print(discountvalue);]]]]]]
                        },
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    isok
                        ? Container(
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.all(20),
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(22, 97, 207, 10),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Total Bill : ${_searchQuery.text} ',
                                  style: nativeFontTextStyle(
                                    fontFamily: 'Roboto',
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Total Discount : ${finaldiscount}',
                                  style: nativeFontTextStyle(
                                    fontFamily: 'Roboto',
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'You have to Pay : $lasttotalprice ',
                                  style: nativeFontTextStyle(
                                    fontFamily: 'Roboto',
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ): Container(),

                    SizedBox(
                      height: 20,
                    ),
                    isok
                        ?  Container(
                        height: 50,
                        width: 140,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Color.fromRGBO(22, 97, 207, 10),
                          child: Text(
                            'Finish',
                            style: nativeFontTextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            ferchbill();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => mainpage(),
                                ));
                          },
                        )): Container(),
                  ],
                ),
              ),
            )
          ]),
    ));
  }
}

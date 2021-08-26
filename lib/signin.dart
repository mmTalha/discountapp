import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/home.dart';
import 'package:http/http.dart' as http;
import 'package:untitled2/sigin.dart';

class siginin extends StatefulWidget {
  const siginin({Key? key}) : super(key: key);

  @override
  _sigininState createState() => _sigininState();
}

class _sigininState extends State<siginin> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formGlobalKey = GlobalKey<FormState>();
  final TextEditingController phone = TextEditingController();
  final TextEditingController refcode = TextEditingController();
  final TextEditingController password = TextEditingController();

  signup(refcode, phone, password) async {
    var data = {
      'ref_code': refcode,
      'phone': phone,
      'password': password,
    };
    final response = await http.post(
        Uri.parse(
          'https://discounthub.uptreedevelopers.com/api/user_signup.php',
        ),
        body: data);

    if (response.statusCode == 200) {
      var datas = (jsonDecode(response.body));

      print(datas);
      _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text(datas['result'].toString()),
        backgroundColor: Colors.red,
      ));
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(seconds: 2),
              pageBuilder:
                  (context, animation, animationtime) =>
                  mainpage(),
              transitionsBuilder: (context, animation,
                  animationtime, child) {
                animation = CurvedAnimation(
                    parent: animation,
                    curve: Curves.elasticInOut);
                return ScaleTransition(
                  scale: animation,
                  child: child,
                  alignment: Alignment.center,
                );
              }));

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
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Form(
            key: formGlobalKey,
            child: Column(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                color: Color.fromRGBO(22, 97, 207, 10),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Discound hub Get Discount on',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'everything',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Column(
                children: [
                  Text(
                    'Sign up',
                    style: TextStyle(
                        color: Color.fromRGBO(22, 97, 207, 10),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Enter your information ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 340,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: TextFormField(
                        validator: (val) =>
                            !val!.contains('+92') ? 'add +92' : null,
                        onSaved: (val) => val = phone.text,
                        keyboardType: TextInputType.phone,
                        controller: phone,
                        decoration: InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.phone,
                                color: Color.fromRGBO(22, 97, 207, 10)),
                            prefixStyle: TextStyle(color: Colors.grey),
                            hintText: 'Enter your phoneno',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(22, 97, 207, 10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(22, 97, 207, 10))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                  ),
                  Container(
                    width: 340,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: TextFormField(
                        validator: (String? msg) {
                          if (msg!.isEmpty) {
                            return 'enter password';
                          }
                        },
                        obscureText: true,
                        controller: password,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              CupertinoIcons.lock,
                              color: Color.fromRGBO(22, 97, 207, 10),
                            ),
                            prefixStyle: TextStyle(color: Colors.grey),
                            hintText: 'Enter your password',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(22, 97, 207, 10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(22, 97, 207, 10))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.red))),
                      ),
                    ),
                  ),
                  Container(
                    width: 240,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: refcode,
                        decoration: InputDecoration(
                            prefixStyle: TextStyle(color: Colors.grey),
                            hintText: ' refrral code (optional)',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(22, 97, 207, 10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(22, 97, 207, 10))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.red))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: 140,
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Color.fromRGBO(22, 97, 207, 10),
                        child: Text(
                          'signup',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Geeza Pro'),
                        ),
                        onPressed: () {
                          if (formGlobalKey.currentState!.validate() &&
                              phone.text.length == 13) {
                            return signup(
                                phone.text, password.text, refcode.text);
                          } else if (phone.text.length != 13) {
                            _scaffoldKey.currentState!.showSnackBar(SnackBar(
                              content: Text('enter valid number'),
                              backgroundColor: Colors.red,
                            ));
                          } else
                            (_scaffoldKey.currentState!.showSnackBar(SnackBar(
                              content: Text('error occured'),
                              backgroundColor: Colors.red,
                            )));
                        }),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}

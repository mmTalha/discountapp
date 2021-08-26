import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/home.dart';
import 'package:http/http.dart' as http;
import 'package:untitled2/signin.dart';

class siginup extends StatefulWidget {



  const siginup({Key? key}) : super(key: key);

  @override
  _siginupState createState() => _siginupState();
}

class _siginupState extends State<siginup> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formGlobalKey = GlobalKey < FormState > ();

  final TextEditingController phone1 = TextEditingController();
  final TextEditingController password1 = TextEditingController();
  var result;
  signin() async {

    try {
      final response = await http.post(
        Uri.parse(
          'https://discounthub.uptreedevelopers.com/api/user_login.php?phone=${phone1
              .text}&password=${password1.text}',
        ),
      );

      if (response.statusCode == 200) {
        var datas = (jsonDecode(response.body));
        print(datas);

        _scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text('${datas['result']}'),
          backgroundColor: Colors.red,
        ));
        var crdentials = datas['result'][0];
        print(crdentials);
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

    } catch (e) {
      print(e.toString());
    }
  }
  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return 'nothing happend';

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
                color: Color . fromRGBO(22, 97, 207,10),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Discound hub Get Discount on',
                        style: TextStyle(color: Colors.white , fontSize: 15),
                      ),
                      const SizedBox(
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
                    'Signin',
                    style: TextStyle(
                        color: Color . fromRGBO(22, 97, 207,10),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Enter your password and phone number',
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
                         controller: phone1,
                         validator:   (val) =>!val!.contains( '+92')?'add +92'   : null,

                          onSaved: (val)=>val=phone1.text,


                        decoration: InputDecoration(

                            prefixIcon: Icon(
                              CupertinoIcons.person,
                              color: Color . fromRGBO(22, 97, 207,10),
                            ),
                            prefixStyle: TextStyle(color: Colors.grey),
                            hintText: 'phone no +92',
                            enabledBorder: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Color . fromRGBO(22, 97, 207,10),)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Color . fromRGBO(22, 97, 207,10),)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color:Colors .red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color:  Colors .red))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 340,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: TextFormField(
                        controller: password1,
                         obscureText: true,
                         validator: (String? msg ){
                          if(msg!.isEmpty ){
                            return 'enter password';
                          }
                        },
                        decoration: InputDecoration(

                            prefixIcon: Icon(
                              CupertinoIcons.lock,
                              color: Color . fromRGBO(22, 97, 207,10),
                            ),
                            prefixStyle: TextStyle(color: Colors.grey),
                            hintText: 'Enter your password',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Color . fromRGBO(22, 97, 207,10),)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color:Color . fromRGBO(22, 97, 207,10),)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Color . fromRGBO(22, 97, 207,10),)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color:Colors.red ))),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 140,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Color . fromRGBO(22, 97, 207,10),
                      child: Text(
                        'Signin',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Geeza Pro'),
                      ),
                      onPressed: () {


                        if(  formGlobalKey.currentState!.validate()&&phone1.text.length==13 ) {
                         return signin();

                        }
                       else if (phone1.text.length!=13){
                           _scaffoldKey.currentState!.showSnackBar(SnackBar(
                           content: Text('enter valid number'),
                           backgroundColor: Colors.red,
                         ));

                        }
                        else(

                        _scaffoldKey.currentState!.showSnackBar(SnackBar(
                         content: Text('error occured'),
                              backgroundColor: Colors.red,
                                 ))
                          );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(left: 100),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Not a Member yet?',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      transitionDuration: Duration(seconds: 2),
                                      pageBuilder:
                                          (context, animation, animationtime) =>
                                          siginin(),
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
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}

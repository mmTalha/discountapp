import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/home.dart';
import 'package:untitled2/provider.dart';
import 'package:untitled2/sigin.dart';
import 'package:untitled2/signin.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => EligiblityScreenProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:   spalsh(),
    );
  }
}
class spalsh extends StatefulWidget {
  @override
  _spalshState createState() => _spalshState();
}

class _spalshState extends State<spalsh> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
            () => Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 2),
                pageBuilder: (context, animation, animationtime) => siginup(),
                transitionsBuilder: (context, animation, animationtime, child) {
                  animation = CurvedAnimation(
                      parent: animation, curve: Curves.bounceIn);
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                    alignment: Alignment.center,
                  );
                })));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,

      child: Center(
        child: Image.asset('assets/splash.png',height: 250,width: 250,),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController phone = TextEditingController();

  Future<List> phonefetch(phone) async {
    var data = {
      'phone': phone,
    };
    final response = await http.post(
        Uri.parse(
          'https://discounthub.uptreedevelopers.com/api/user_phone_check.php',
        ),
        body: data);

    if (response.statusCode == 200) {
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(seconds: 2),
              pageBuilder: (context, animation, animationtime) => siginup(),
              transitionsBuilder: (context, animation, animationtime, child) {
                animation =
                    CurvedAnimation(parent: animation, curve: Curves.ease);
                return ScaleTransition(
                  scale: animation,
                  child: child,
                  alignment: Alignment.center,
                );
              }));
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
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'lets Roll',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'get discount on your',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'favroutes brands',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Column(
            children: [
              Image.asset(
                'assets/discountlogo.png',
                height: 100,
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                'Enter your mobile number',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: 340,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          CupertinoIcons.search,
                          color: Colors.grey,
                        ),
                        prefixStyle: TextStyle(color: Colors.grey),
                        hintText: 'Enter mobile Number ',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.blue)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blue)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 260,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.blue,
                  child: Text(
                    'send',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Geeza Pro'),
                  ),
                  onPressed: () {
                    FutureBuilder(
                        future: phonefetch(phone.text),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return siginin();
                          } else {
                            print(' link${snapshot.data}   ');
                          }
                          return siginup();
                        });
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';



class error extends StatefulWidget {
  final name;
  const error({Key? key, this.name}) : super(key: key);

  @override
  _errorState createState() => _errorState();
}

class _errorState extends State<error> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text('Error',style: TextStyle(color: Colors.green,fontSize: 40,fontWeight: FontWeight.bold),),
            Text('404',style: TextStyle(color: Colors.red,fontSize: 40,fontWeight: FontWeight.bold),),

            Text('This is not ${widget.name} QR Code'),
              Text('Please use valid QR Code'),
          ],),
        ),
      )

    );
  }
}

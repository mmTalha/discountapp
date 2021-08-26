import 'package:flutter/material.dart';

class cards extends StatefulWidget {
  const cards({Key? key}) : super(key: key);

  @override
  _cardsState createState() => _cardsState();
}

class _cardsState extends State<cards> {
  final double topWidgetHeight = 200;

  final double avatarRadius = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    new Column(
                      children: <Widget>[
                        new Container(
                          height: 150,
                          color: Colors.yellow,
                          child: Image.asset(
                            'assets/watch.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    new Positioned(
                      child: new CircleAvatar(
                        backgroundImage: AssetImage('assets/discountlogo.png'),
                        radius: avatarRadius,
                        backgroundColor: Colors.green,


                      ),
                      left: (MediaQuery.of(context).size.width / 1) - 170,
                      top: 90,
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
                  height: 25,
                ),
                Text('clothing'),
              ],
            ),
          )
        ],
      ),
    );
  }
}

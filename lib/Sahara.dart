import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OeschinenLakeScreen(),
    );
  }
}

class OeschinenLakeScreen extends StatelessWidget {
  const OeschinenLakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderImage(),
          titleSection(),
          iconSection(),
          DescriptionSection(), 
        ],
      ),
    );
  }
  Widget titleSection(){
    var namePlace = "Hoang mạc";
    var addresss = "Chấu Phi";
    var votePlace = "41";
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(namePlace , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 30),),
              Text(addresss)
              ]
            ),
          Row(children: [Text(votePlace) , Icon(Icons.star , color: Colors.red,)])
        ],
      ),
    );
  }
  Widget iconSection(){
    var color = Colors.blue;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(Icons.call , color: color,),
              Text("CALL" , style: TextStyle(color: color),),
            ],
            
          ),
          Column(
            children: [
              Icon(Icons.near_me , color: color,),
              Text("ROUTE"  , style: TextStyle(color: color),),
            ],
            
          ),
          Column(
            children: [
              Icon(Icons.share , color: color,),
              Text("SHARE"  , style: TextStyle(color: color),),
            ],
            
          )
        ],
      ),
    );
  }
}

class HeaderImage extends StatelessWidget {
  const HeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/20190725_Oeschinensee-Panorama%2C_Kandersteg_%2806540-42_stitch%29.jpg/960px-20190725_Oeschinensee-Panorama%2C_Kandersteg_%2806540-42_stitch%29.jpg',
    );
  }
}
class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. '
        'Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. '
        'A gondola ride from Kandersteg, followed by a half-hour walk through pastures '
        'and pine forest, leads you to the lake, which warms to 20 degrees Celsius in '
        'the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.',
      ),
    );
  }
}
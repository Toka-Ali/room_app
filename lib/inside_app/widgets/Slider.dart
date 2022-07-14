import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:room_app/inside_app/widgets/elevatedButton.dart';
final  List<String> imgList = [
  'https://img.freepik.com/free-psd/corporate-identity-psd-mockup-set-with-t-shirt-tablet-sticker_53876-138256.jpg?t=st=1657759381~exp=1657759981~hmac=0e78e5168318d9b94bca4c9d570ab29a58b52e2660b4bffee3cf65e54efefc23&w=996',
  'https://img.freepik.com/free-psd/apparel-with-t-shirt-tote-bag_53876-113707.jpg?t=st=1657747312~exp=1657747912~hmac=ca22ab4c6a9a3acd6c797825b2154cf18e20e9c387d6063e596cc2b732d0b6fb&w=996',
  'https://img.freepik.com/free-psd/shirt-with-floral-pattern_53876-113677.jpg?t=st=1657726959~exp=1657727559~hmac=fd2677ebb389be665b33dbdac4af255c5e0b69f41301fd7b820d27ae87dcf4e8&w=360'
];

//
// final themeMode = ValueNotifier(2);
//
// class CarouselDemo extends StatelessWidget {
//   const CarouselDemo( {Key? key, required this.image}) : super(key: key);
//   final String image;
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       builder: (context, value, g) {
//         return MaterialApp(
//           initialRoute: '/',
//           darkTheme: ThemeData.dark(),
//           themeMode: ThemeMode.values.toList()[value as int],
//           debugShowCheckedModeBanner: false,
//           routes: {
//             '/complicated': (ctx) => ComplicatedImageDemo(),
//           },
//         );
//       },
//       valueListenable: themeMode,
//     );
//   }
// }
//
// class DemoItem extends StatelessWidget {
//   final String title;
//   final String route;
//   DemoItem(this.title, this.route);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(title),
//       onTap: () {
//         Navigator.pushNamed(context, route);
//       },
//     );
//   }
// }
//
// final List<Widget> imageSliders = imgList
//     .map((item) => Container(
//   child: Container(
//     margin: EdgeInsets.all(5.0),
//     child: ClipRRect(
//         borderRadius: BorderRadius.all(Radius.circular(5.0)),
//         child: Stack(
//           children: <Widget>[
//
//             Image.network(item, fit: BoxFit.cover, width: 1000.0),
//             Positioned(
//               bottom: 0.0,
//               left: 0.0,
//               right: 0.0,
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Color.fromARGB(200, 0, 0, 0),
//                       Color.fromARGB(0, 0, 0, 0)
//                     ],
//                     begin: Alignment.bottomCenter,
//                     end: Alignment.topCenter,
//                   ),
//                 ),
//                 padding: EdgeInsets.symmetric(
//                     vertical: 10.0, horizontal: 20.0),
//                 child: Text(
//                   'T_shirt',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         )),
//   ),
// ))
//     .toList();

class ComplicatedImageDemo extends StatelessWidget {
  const ComplicatedImageDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: false,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
        items: [
          ElevatButton('assets/images/shirt1.png' , 'shirt'),
          ElevatButton('assets/images/shirt1.png' , 'shirt'),
          ElevatButton('assets/images/shirt1.png' , 'shirt'),
          ElevatButton('assets/images/shirt1.png' , 'shirt'),
        ],
      ),
    );
  }
}

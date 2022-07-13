import 'package:flutter/material.dart';
import 'package:room_app/inside_app/Screens/select_image.dart';
import 'package:room_app/inside_app/widgets/Slider.dart';
import 'package:room_app/inside_app/widgets/sources_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import "package:path/path.dart";

import 'dart:io';

import 'package:async/async.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  late File image ;

  onbuttonpressed (File pickedImage)async {
    var stream = http.ByteStream(DelegatingStream.typed(pickedImage.openRead()));  // get file length
    var length = await pickedImage.length();

    // string to uri
    var uri =
    Uri.parse("https://jaundice-classfire.herokuapp.com//predict");

    // create multipart request
    var request = http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(pickedImage.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      value;
    });
  }  // get file length

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        title: const Padding(
          padding: EdgeInsets.only(left: 50.0),
          child: Text('Fitting Room'),
        ),
        actions: [
          IconButton(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(right: 40),
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        children: [
          const SourcesBar(),
          Expanded(
              flex: 2,
              child: ComplicatedImageDemo()),
           Expanded(
              flex:3,
              child: SelectImage(image: image)),
          Container(
            margin: EdgeInsets.only(bottom: 60),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
              elevation: 18.0,
              color: Colors.black,
              clipBehavior: Clip.antiAlias,
              child: MaterialButton(
                onPressed: () {
                  onbuttonpressed(image);

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const OutfitScreen(),
                  //     ));
                },
                child: const Text("Show OutFit" , style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:room_app/inside_app/Screens/select_image.dart';
import 'package:room_app/inside_app/widgets/Slider.dart';
import 'package:room_app/inside_app/widgets/sources_bar.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? personImage;
  File? clothingImage;
  Uint8List? outfitImage;
  bool loading = false;

  Future<void> _uploadImage(File personImage, File clothingImage) async {
    String clothingImageApi = clothingImage.path.split('/').last;
    String personImageApi = personImage.path.split('/').last;
    setState(() {
      loading = true;
    });
    FormData data = FormData.fromMap({
      "clothing_image": await MultipartFile.fromFile(
        clothingImage.path,
        filename: clothingImageApi,
      ),
      "person_image": await MultipartFile.fromFile(
        personImage.path,
        filename: personImageApi,
      ),
    });

    Dio dio = Dio();
    String url = "http://f362-35-193-112-76.ngrok.io";
    await dio
        .post(
      url + "/apply",
      data: data,
    )
        .then((response) async {
      var data = response.data as Map<String, dynamic>;
      log(data["result"]);
      var _imgString = data["result"];

      Uint8List bytes = const Base64Decoder().convert(_imgString);
      setState(() {
        loading = false;
        outfitImage = bytes;
      });

// You can check if data is normal base64 - should return true

// Will returns your image as Uint8List
    }).catchError((error) {
      print(error);
    });
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  String base64String(Uint8List data) {
    return base64Encode(data);
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SourcesBar(),
            ComplicatedImageDemo(),
            SelectImage(
              tittle: "Pick Clothing Image from Gallery",
              fromGallery: true,
              afterSelectImage: (File pic) {
                clothingImage = pic;
              },
            ),
            SelectImage(
              tittle: "Pick Person Image from Gallery",
              fromGallery: true,
              afterSelectImage: (File pic) {
                personImage = pic;
              },
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 60),
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0)),
                elevation: 18.0,
                color: Colors.black,
                clipBehavior: Clip.antiAlias,
                child: MaterialButton(
                  onPressed: () async {
                    if (personImage != null && clothingImage != null) {
                      await _uploadImage(personImage!, clothingImage!);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text("Please Select Image"),
                      ));
                    }
                  },
                  child: const Text(
                    "Show OutFit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: loading
                    ? const Center(child: CircularProgressIndicator())
                    : outfitImage != null
                        ? Image.memory(
                            outfitImage!,
                            fit: BoxFit.fill,
                          )
                        : const Text("Image Not Loaded Yet"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

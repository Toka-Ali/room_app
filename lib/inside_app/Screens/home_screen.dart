import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:room_app/api_manger.dart';

import 'package:room_app/inside_app/Screens/select_image.dart';
import 'package:room_app/inside_app/widgets/slider.dart';
import 'package:room_app/inside_app/widgets/sources_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? personImage;
  String? clothingImageUrl;
  Uint8List? outfitImage;
  bool loading = false;
  bool isWomen = true;

  Future<void> _uploadImage(File personImage, String clothingImageUrl) async {
    setState(() {
      loading = true;
    });
    File clothingImage = await ApiManger.urlToFile(clothingImageUrl);
    await ApiManger.uploadImageApi(personImage, clothingImage,
        (Uint8List bytes) {
      setState(() {
        loading = false;
        outfitImage = bytes;
      });
    }, () {
      setState(() {
        loading = false;
      });
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
            SliderImage(
                list: isWomen ? imgListWomen : imgListMen,
                selectedImage: (url) {
                  clothingImageUrl = url;
                }),
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
                    if (personImage != null && clothingImageUrl != null) {
                      await _uploadImage(personImage!, clothingImageUrl!);
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

final List<String> imgListWomen = [
  "https://lcw.akinoncdn.com/products/2021/10/07/1556086/1d86bfc3-a56d-48a1-9f98-645ed6e59f18_size561x730.jpg",
  "https://lcw.akinoncdn.com/products/2022/04/12/3325949/68ad3bce-cae8-47d2-ba66-3a79ad7b6bce_size561x730.jpg",
  "https://lcw.akinoncdn.com/products/2022/04/08/3318191/f61c9d35-6685-47ca-baf1-b3649da4279f_size561x730.jpg",
  "https://lcw.akinoncdn.com/products/2022/04/01/3303016/665f29db-b5f6-4e60-b07d-c12c62fa7af2_size561x730.jpg",
];
final List<String> imgListMen = [
  "https://lcw.akinoncdn.com/products/2021/10/07/1556086/1d86bfc3-a56d-48a1-9f98-645ed6e59f18_size561x730.jpg",
  "https://lcw.akinoncdn.com/products/2022/04/12/3325949/68ad3bce-cae8-47d2-ba66-3a79ad7b6bce_size561x730.jpg",
  "https://lcw.akinoncdn.com/products/2022/04/08/3318191/f61c9d35-6685-47ca-baf1-b3649da4279f_size561x730.jpg",
  "https://lcw.akinoncdn.com/products/2022/04/01/3303016/665f29db-b5f6-4e60-b07d-c12c62fa7af2_size561x730.jpg",
];

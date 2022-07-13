import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class SelectImage extends StatefulWidget {
  late final File? image ;
   SelectImage({Key? key, required this.image}) : super(key: key);

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => widget.image = imageTemp);
    } on PlatformException catch (e) {
       print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => widget.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MaterialButton(
                      color: Colors.black,
                      child: const Text("Pick Image from Gallery",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        pickImage();
                      }),

                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.image != null
                        ? Image.file(widget.image!)
                        : const Text("No image selected"),
                  ),
                  const Padding(padding: EdgeInsets.all(8))
                ],
              ),
            ),
          )),
    );
  }
}

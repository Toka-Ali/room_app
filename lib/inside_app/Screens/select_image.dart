import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectImage extends StatefulWidget {
  final void Function(File image) afterSelectImage;
  final bool fromGallery;
  final String tittle;
  const SelectImage(
      {Key? key,
      required this.afterSelectImage,
      required this.fromGallery,
      required this.tittle})
      : super(key: key);

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  File? selectedImage;
  Future pickImage() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) throw PlatformException;

      final imageTemp = File(image.path);

      setState(() => selectedImage = imageTemp);
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) throw PlatformException;

      final imageTemp = File(image.path);

      setState(() => selectedImage = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        MaterialButton(
            color: Colors.black,
            child: Text(widget.tittle,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () async {
              widget.fromGallery ? await pickImage() : await pickImageC();
              if (selectedImage != null) {
                widget.afterSelectImage(selectedImage!);
              }
            }),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 200,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: selectedImage != null
                ? Image.file(
                    selectedImage!,
                    fit: BoxFit.fill,
                  )
                : const Text("No image selected"),
          ),
        ),
        const Padding(padding: EdgeInsets.all(8))
      ],
    ));
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SliderImage extends StatefulWidget {
  final void Function(String imageUrl) selectedImage;
  final List<String> list;
  const SliderImage({
    Key? key,
    required this.selectedImage,
    required this.list,
  }) : super(key: key);

  @override
  State<SliderImage> createState() => _SliderImageState();
}

class _SliderImageState extends State<SliderImage> {
  String selectedImageUrl = "";

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: imageSliders(),
    );
  }

  List<Widget> imageSliders() => widget.list
      .map((item) => ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: InkWell(
            onTap: () {
              setState(() {
                selectedImageUrl = item;
                widget.selectedImage(selectedImageUrl);
              });
            },
            child: Container(
                color: selectedImageUrl == item ? Colors.blue : null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
                )),
          )))
      .toList();
}

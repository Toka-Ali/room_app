import 'package:flutter/material.dart';

class OutfitScreen extends StatefulWidget {
  const OutfitScreen({Key? key}) : super(key: key);

  @override
  State<OutfitScreen> createState() => _OutfitScreenState();
}

class _OutfitScreenState extends State<OutfitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        title: Container(child: const Text('Fitting Room')),
      ),
    );
  }
}

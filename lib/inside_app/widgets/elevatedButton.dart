import 'package:flutter/material.dart';

class ElevatButton extends StatelessWidget {
  final String image;
  final String title;

  ElevatButton(this.image, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ElevatedButton(
        onPressed: () {},
        child: Stack(
          children: [
            Image.asset(image, fit: BoxFit.fill),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(5),
              child: const Text(
                'T_shirt',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors
              .transparent, // background (button) color// foreground (text) color
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SourceItemName extends StatelessWidget {
  final String title ;
  const SourceItemName(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.all(5),
      child: TextButton(
          style: TextButton.styleFrom(
              primary: Colors.black,
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: Colors.black)
            )
          ),
          onPressed: (){}, child: FittedBox(child: Text(title , style: TextStyle(color: Colors.white),))),
    );
  }
}

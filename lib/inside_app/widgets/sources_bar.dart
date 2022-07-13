import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_app/inside_app/widgets/source_item_name.dart';

class SourcesBar extends StatelessWidget {
  const SourcesBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SourceItemName('women'),
          SourceItemName('Men'),
        ],

    );
  }
}

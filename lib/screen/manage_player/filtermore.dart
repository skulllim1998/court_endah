import 'package:flutter/material.dart';

import '../../utils/color_constants.dart';

class Filtermore extends StatelessWidget {
  final Function setIndex;

  Filtermore(this.setIndex);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton.icon(
              onPressed: () => setIndex(2),
              icon: Icon(
                Icons.keyboard_arrow_left_outlined,
                size: 40,
                color: ColorConstants.primaryColor,
              ),
              label: Text(
                '',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.light_green,
                side: const BorderSide(
                  width: 2, // the thickness
                  color: ColorConstants.primaryColor, // the color of the border
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton.icon(
              onPressed: () => setIndex(1),
              icon: Icon(
                Icons.keyboard_arrow_right_outlined,
                size: 40,
                color: ColorConstants.primaryColor,
              ),
              label: Text(
                '',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.light_green,
                side: const BorderSide(
                  width: 2, // the thickness
                  color: ColorConstants.primaryColor, // the color of the border
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

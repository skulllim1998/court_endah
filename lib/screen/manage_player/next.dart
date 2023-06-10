import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color_constants.dart';

class Next extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 60,
      padding: EdgeInsets.all(10),
      color: ColorConstants.primaryColor,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(
          Icons.arrow_right_alt_outlined,
          size: 40,
        ),
        label: Text(
          'abc',
        ),
      ),
    );
  }
}

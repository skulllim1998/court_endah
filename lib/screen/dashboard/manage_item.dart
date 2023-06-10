import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color_constants.dart';
import '../../utils/image_constants.dart';

class ManageItem extends StatelessWidget {
  final String imageItem;
  final String titleItem;
  final Function navigateScreen;

  ManageItem(this.imageItem, this.titleItem, this.navigateScreen);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigateScreen,
      splashColor: ColorConstants.primaryColor,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imageItem,
              height: 100,
              width: double.infinity,
            ),
            Text(
              titleItem,
              style: GoogleFonts.nunito(
                color: ColorConstants.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 1),
              blurRadius: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}

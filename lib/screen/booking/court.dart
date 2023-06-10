import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color_constants.dart';

class Court extends StatelessWidget {
  final int isClick;
  final Function setIsClick;

  Court(this.isClick, this.setIsClick);

  @override
  Widget build(BuildContext context) {
    return isClick == 1
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: OutlinedButton(
                    onPressed: () {
                      setIsClick(1);
                    },
                    child: Text(
                      'Court A',
                      style: GoogleFonts.nunito(
                        color: ColorConstants.primaryColor,
                        fontSize: 18,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: ColorConstants.light_green,
                      minimumSize: Size.fromHeight(50),
                      side: BorderSide(
                        width: 3,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: OutlinedButton(
                    onPressed: () {
                      setIsClick(2);
                    },
                    child: Text(
                      'Court B',
                      style: GoogleFonts.nunito(
                        color: ColorConstants.primaryColor,
                        fontSize: 18,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      side: BorderSide(
                        width: 3,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: OutlinedButton(
                    onPressed: () {
                      setIsClick(1);
                    },
                    child: Text(
                      'Court A',
                      style: GoogleFonts.nunito(
                        color: ColorConstants.primaryColor,
                        fontSize: 18,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      side: BorderSide(
                        width: 3,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: OutlinedButton(
                    onPressed: () {
                      setIsClick(2);
                    },
                    child: Text(
                      'Court B',
                      style: GoogleFonts.nunito(
                        color: ColorConstants.primaryColor,
                        fontSize: 18,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: ColorConstants.light_green,
                      minimumSize: Size.fromHeight(50),
                      side: BorderSide(
                        width: 3,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}

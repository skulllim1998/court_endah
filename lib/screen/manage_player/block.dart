import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color_constants.dart';
import '../../models/filter_player.dart';

class Block extends StatelessWidget {
  final int isClick;
  final Function setIsClick;
  final Function filterPlayer;
  final FilterPlayer editedPlayer;

  Block(this.isClick, this.setIsClick, this.filterPlayer, this.editedPlayer);

  @override
  Widget build(BuildContext context) {
    return isClick == 0
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: OutlinedButton(
                    onPressed: () {
                      setIsClick(1);
                      var player = FilterPlayer(
                          play_block: 'C',
                          play_level: editedPlayer.play_level,
                          play_year: editedPlayer.play_year,
                          play_month: editedPlayer.play_month,
                          play_active: editedPlayer.play_active);
                      filterPlayer(player);
                    },
                    child: Text(
                      'Block C',
                      style: GoogleFonts.nunito(
                        color: ColorConstants.primaryColor,
                        fontSize: 18,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size.fromHeight(30),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: OutlinedButton(
                    onPressed: () {
                      setIsClick(2);
                      var player = FilterPlayer(
                          play_block: 'D',
                          play_level: editedPlayer.play_level,
                          play_year: editedPlayer.play_year,
                          play_month: editedPlayer.play_month,
                          play_active: editedPlayer.play_active);
                      filterPlayer(player);
                    },
                    child: Text(
                      'Block D',
                      style: GoogleFonts.nunito(
                        color: ColorConstants.primaryColor,
                        fontSize: 18,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size.fromHeight(30),
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
        : isClick == 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: OutlinedButton(
                        onPressed: () {
                          setIsClick(1);
                          var player = FilterPlayer(
                              play_block: 'C',
                              play_level: editedPlayer.play_level,
                              play_year: editedPlayer.play_year,
                              play_month: editedPlayer.play_month,
                              play_active: editedPlayer.play_active);
                          filterPlayer(player);
                        },
                        child: Text(
                          'Block C',
                          style: GoogleFonts.nunito(
                            color: ColorConstants.primaryColor,
                            fontSize: 18,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: ColorConstants.light_green,
                          minimumSize: Size.fromHeight(30),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: OutlinedButton(
                        onPressed: () {
                          setIsClick(2);
                          var player = FilterPlayer(
                              play_block: 'D',
                              play_level: editedPlayer.play_level,
                              play_year: editedPlayer.play_year,
                              play_month: editedPlayer.play_month,
                              play_active: editedPlayer.play_active);
                          filterPlayer(player);
                        },
                        child: Text(
                          'Block D',
                          style: GoogleFonts.nunito(
                            color: ColorConstants.primaryColor,
                            fontSize: 18,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size.fromHeight(30),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: OutlinedButton(
                        onPressed: () {
                          setIsClick(1);
                          var player = FilterPlayer(
                              play_block: 'C',
                              play_level: editedPlayer.play_level,
                              play_year: editedPlayer.play_year,
                              play_month: editedPlayer.play_month,
                              play_active: editedPlayer.play_active);
                          filterPlayer(player);
                        },
                        child: Text(
                          'Block C',
                          style: GoogleFonts.nunito(
                            color: ColorConstants.primaryColor,
                            fontSize: 18,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size.fromHeight(30),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: OutlinedButton(
                        onPressed: () {
                          setIsClick(2);
                          var player = FilterPlayer(
                              play_block: 'C',
                              play_level: editedPlayer.play_level,
                              play_year: editedPlayer.play_year,
                              play_month: editedPlayer.play_month,
                              play_active: editedPlayer.play_active);
                          filterPlayer(player);
                        },
                        child: Text(
                          'Block D',
                          style: GoogleFonts.nunito(
                            color: ColorConstants.primaryColor,
                            fontSize: 18,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: ColorConstants.light_green,
                          minimumSize: Size.fromHeight(30),
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

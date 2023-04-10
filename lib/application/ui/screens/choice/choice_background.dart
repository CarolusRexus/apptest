import 'package:apptest/application/constants/svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChoiceBackground extends StatelessWidget {
  const ChoiceBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SvgPicture.asset(SvgAssets.choiceUpperLeft),
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(SvgAssets.choiceLowerRight),
          ),
          Positioned(
            left: 67,
            bottom: 138,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                SvgPicture.asset(SvgAssets.choiceTransparentCircle),
                SvgPicture.asset(SvgAssets.choiceCircle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

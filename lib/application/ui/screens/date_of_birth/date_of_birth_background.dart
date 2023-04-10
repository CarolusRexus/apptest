import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/svg.dart';

class DateOfBirthBackground extends StatelessWidget {
  const DateOfBirthBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SvgPicture.asset(SvgAssets.dateOfBirthTopLeft),
          Positioned(
            top: 12,
            left: 24,
            child: SvgPicture.asset(SvgAssets.dateOfBirthLine),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(SvgAssets.dateOfBirthLowerRight),
          ),
          Positioned(
            bottom: 72,
            left: 28,
            child:
                SvgPicture.asset(SvgAssets.dateOfBirthTransparentLowerBottom),
          ),
          Positioned(
            top: 28,
            right: 75,
            child: SvgPicture.asset(SvgAssets.dateOfBirthTransparentTopRight),
          ),
          Positioned(
            top: 63,
            right: 70,
            child: SvgPicture.asset(SvgAssets.dateOfBirthCircle),
          ),
          Positioned(
            bottom: 290,
            right: 0,
            child:
                SvgPicture.asset(SvgAssets.dateOfBirthTransparentRightCenter),
          ),
        ],
      ),
    );
  }
}

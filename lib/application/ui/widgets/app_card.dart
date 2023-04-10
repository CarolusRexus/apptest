import 'package:apptest/application/constants/svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/colors.dart';

class AppCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onPressed;

  const AppCard({
    Key? key,
    required this.title,
    this.subtitle,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 31,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: AppColors.lightGray,
            ),
            child: Stack(
              children: [
                if (onPressed != null)
                  Positioned.fill(
                    right: 19,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(SvgAssets.rightArrow),
                    ),
                  ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            subtitle ?? '',
                            style: const TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

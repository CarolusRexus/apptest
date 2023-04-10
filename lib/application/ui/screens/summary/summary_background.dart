import 'package:flutter/cupertino.dart';


class SummaryBackground extends StatelessWidget {
  const SummaryBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: const [
        ],
      ),
    );
  }
}

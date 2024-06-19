import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BadNetwork extends StatelessWidget {
  const BadNetwork({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset('assets/plug-connect.svg'),
          const SizedBox(
            height: 20,
          ),
          const Text("Looks like you lost Internet connection"),
          const SizedBox(
            height: 20,
          ),
          const Text('Try again'),
        ],
      ),
    );
  }
}

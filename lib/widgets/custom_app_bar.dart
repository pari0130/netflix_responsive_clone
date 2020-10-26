import 'package:flutter/material.dart';
import 'package:netflix/assets.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo0)
        ],
      ),
    );
  }
}

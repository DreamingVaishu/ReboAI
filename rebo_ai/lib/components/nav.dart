import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:rebo_ai/assets/menu.svg';

class Nav extends StatelessWidget {
  const Nav({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      color: const Color.fromARGB(255, 32, 32, 32),
      height: max(50, 60),
      width: double.infinity,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              print('Menu tapped');
            },
            child: SvgPicture.asset(
              'lib/assets/menu.svg',
              width: 12,
              height: 12,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Hello',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

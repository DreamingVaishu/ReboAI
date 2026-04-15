import 'dart:math';

import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext home) {
    return Center(
      child: Container(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.all(23),
          padding: EdgeInsets.all(23),
          // decoration: BoxDecoration(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(34),
            color: const Color.fromARGB(255, 85, 85, 85),
          ),
          height: 100,
          width: max(500, 200),
          // alignment: Alignment.topCenter,
          // color: const Color.fromARGB(255, 152, 152, 152),
        ),
      ),
    );
  }
}

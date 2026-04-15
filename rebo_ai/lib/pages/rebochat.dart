import 'package:flutter/material.dart';

class Rebochat extends StatelessWidget {
  const Rebochat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(children: [Container(child: TextField())]),
      ),
    );
  }
}

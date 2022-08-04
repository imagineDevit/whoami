import 'package:flutter/material.dart';
import 'package:henri_sedjame/misc/colors.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration:  const BoxDecoration(
          gradient: LinearGradient(
              colors: [lightPurple, darkPurple, blackPurple, dark],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),

      child: Column(
        children: const [

        ],
      ),

    );
  }
}

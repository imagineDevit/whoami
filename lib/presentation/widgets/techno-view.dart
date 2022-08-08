import 'package:flutter/material.dart';
import 'dart:math' as math;

class TechnoView extends StatefulWidget {
  final String name;

  const TechnoView({Key? key, required this.name}) : super(key: key);

  @override
  State<TechnoView> createState() => _TechnoViewState();
}

class _TechnoViewState extends State<TechnoView> with TickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _animation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 2 * math.pi).animate(_controller)
      ..addListener(() {
        setState(() => {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.value = 0.0;
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          transform(Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(111, 222, 203, 0.7),
                    offset: Offset(0.0, 5.0),
                    blurRadius: 30.0,
                    spreadRadius: 2,
                  )
                ]),
          )),
          Positioned(
            top: 2,
            left: 10,
            child: transform(Transform.rotate(
              angle: _animation.value,
              child: Image(
                image: AssetImage("assets/${widget.name}.png"),
                width: 125,
                height: 125,
                color: Colors.black12,
              ),
            )),
          ),
          Positioned(
            top: 15,
            left: 25,
            child: transform(Transform.rotate(
              angle: _animation.value,
              child: Image(
                image: AssetImage("assets/${widget.name}.png"),
                width: 110,
                height: 110,
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget transform(Widget widget) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateX(-math.pi / 4),
      alignment: FractionalOffset.center,
      child: widget,
    );
  }

  Widget transformImg(Widget widget) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateX(-math.pi / 12),
      alignment: FractionalOffset.center,
      child: widget,
    );
  }
}

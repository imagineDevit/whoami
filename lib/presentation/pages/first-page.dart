import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:henri_sedjame/misc/colors.dart';
import 'package:henri_sedjame/misc/constants.dart';
import 'package:henri_sedjame/misc/images.dart';
import 'package:henri_sedjame/models/me.dart';
import 'package:henri_sedjame/presentation/widgets/data-builder.dart';
import 'package:henri_sedjame/utils/eq-utils.dart';
import 'package:henri_sedjame/utils/logo-utils.dart';
import 'package:henri_sedjame/utils/screen-utils.dart';
import 'dart:math' as math;

class FirstPage extends StatefulWidget {
  final double offset;
  final double logoSize;

  const FirstPage({Key? key, required this.offset, required this.logoSize})
      : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with TickerProviderStateMixin {
  late AnimationController _titleAnimationController;
  late Animation<double> _titleAnimation;

  @override
  void initState() {
    super.initState();

    _titleAnimationController = AnimationController(
        duration: const Duration(milliseconds: 750), vsync: this);

    _titleAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _titleAnimationController, curve: Curves.bounceOut))
      ..addListener(() {
        setState(() => {});
      });

    Future.delayed(const Duration(milliseconds: 2500), () {
      _titleAnimationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DataBuilder(
      builder: (data) => LayoutBuilder(builder: (context, constraints) {
        var nameSize = ScreenUtils.isSmall(constraints.maxWidth) ? 18.0 : 20.0;
        var nameSpaceTop =
            ScreenUtils.isSmall(constraints.maxWidth) ? 8.0 : 0.0;
        var titleSize =
            ScreenUtils.isSmall(constraints.maxWidth) ? (18 * 28 / 20) : 28.0;
        var titleSpaceTop =
            ScreenUtils.isSmall(constraints.maxWidth) ? 34.0 : 30.0;

        var initialPosition = (constraints.maxWidth - widget.logoSize) / 2;

        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [lightPurple, darkPurple, blackPurple, dark],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Stack(
            children: [
              profilView(titleSpaceTop, constraints),
              nameView(data.me, nameSpaceTop, initialPosition, nameSize),
              titleView(data.me, titleSpaceTop, initialPosition, titleSize),
              descriptionView(
                  data.me, titleSpaceTop, initialPosition, context, nameSize)
            ],
          ),
        );
      }),
    );
  }

  Positioned profilView(double titleSpaceTop, BoxConstraints constraints) {
    var profileRadius = widget.offset < logoMoveScrollGap
        ? EqUtils.linear(50, 30, widget.offset, logoMoveScrollGap)
        : 30.0;

    var initialBottomPosition = (3 * titleSpaceTop);

    var bottomPosition = EqUtils.linear(
                initialBottomPosition,
                (LogoUtils.getHeight(widget.logoSize) - profileRadius),
                widget.offset,
                2*logoMoveScrollGap);

    var finalBottoPosition = (LogoUtils.getHeight(widget.logoSize) - 30);


    var initialRightPosition = constraints.maxWidth / 4 - 50;
    var finalRightPosition = MediaQuery.of(context).size.width - initialRightPosition + 10.0;

    return Positioned(
        bottom: widget.offset < logoMoveScrollGap
            ? initialBottomPosition
            : (widget.offset < (2 *logoMoveScrollGap) ? bottomPosition: finalBottoPosition),
        right: widget.offset < logoMoveScrollGap
          ? EqUtils.linear(initialRightPosition, finalRightPosition, widget.offset, logoMoveScrollGap)
          : finalRightPosition,
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..rotateY(3 * math.pi * (1 - _titleAnimation.value) / 2),
          child: Opacity(
            opacity: 0.5,
            child: CircleAvatar(
              radius: profileRadius,
              backgroundColor: Colors.white,
              backgroundImage: const AssetImage(profilImg),
            ),
          ),
        ));
  }

  Positioned descriptionView(Me me, double titleSpaceTop,
      double initialPosition, BuildContext context, double nameSize) {
    return Positioned(
        bottom: (3 * titleSpaceTop),
        left: initialPosition,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 1.0,
              height: ((MediaQuery.of(context).size.height / 3)),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [brightGreen, dark],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: widget.logoSize,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: me
                      .descriptionLines()
                      .map((e) => descriptionLineView(e, nameSize))
                      .toList(),
                ),
              ),
            )
          ],
        ));
  }

  Padding descriptionLineView(String e, double nameSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        e,
        style: GoogleFonts.lato(
            fontSize: nameSize,
            color: Colors.white,
            fontWeight: FontWeight.w300),
      ),
    );
  }

  Positioned titleView(
      Me me, double titleSpaceTop, double initialPosition, double titleSize) {
    return Positioned(
      top: LogoUtils.getHeight(widget.logoSize) + titleSpaceTop,
      right: initialPosition,
      child: Transform.scale(
        scale: _titleAnimation.value,
        child: Opacity(
          opacity: widget.offset >= 10 ? 0 : 1 - (widget.offset / 10),
          child: DefaultTextStyle(
              style: GoogleFonts.lato(
                  color: green,
                  fontWeight: FontWeight.w700,
                  fontSize: titleSize,
                  letterSpacing: 2),
              child: Text(me.title)),
        ),
      ),
    );
  }

  Positioned nameView(
      Me me, double nameSpaceTop, double initialPosition, double nameSize) {
    return Positioned(
      top: LogoUtils.getHeight(widget.logoSize) + nameSpaceTop,
      right: EqUtils.linear(
              initialPosition, -1000, widget.offset, logoMoveScrollGap) -
          1,
      child: DefaultTextStyle(
        style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: nameSize,
            letterSpacing: 2),
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(me.name,
                cursor: "|", speed: const Duration(milliseconds: 100)),
          ],
          isRepeatingAnimation: false,
        ),
      ),
    );
  }
}

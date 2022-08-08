import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:henri_sedjame/misc/colors.dart';

class WAIButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  const WAIButton({Key? key, required this.text, required this.onPressed}) : super(key: key);
  @override
  State<WAIButton> createState() => _WAIButtonState();
}

class _WAIButtonState extends State<WAIButton> {

  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
          primary: _hovered ? brightGreen : Colors.transparent,
          elevation: 10.0,
          side: const BorderSide(
              color: brightGreen,
              width: 1.0
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0)
          )
      ),
      onPressed: widget.onPressed,
      onHover: (b){
        setState((){
          _hovered = b;
        });
      },
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
        child: Text(widget.text, style: GoogleFonts.lato(
          color: _hovered ? lightPurple : brightGreen,
          fontWeight: _hovered ?  FontWeight.w500 : FontWeight.w300,
          letterSpacing: _hovered ? 2.5 : 1.0,
        ),),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ButtonsWelcomeScreen extends StatelessWidget {
  ButtonsWelcomeScreen({this.colour, this.title, @required this.onPressed});

  final Color? colour;
  final String? title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title!,
            style: GoogleFonts.robotoSerif(color: Colors.white),
            ),
          ),
        ),
      );
  }
}
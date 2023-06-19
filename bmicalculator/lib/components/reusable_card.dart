import 'package:flutter/material.dart';
import 'package:bmicalculator/screens/input_page.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({Key? key, required this.colour, this.cardChild, this.onPress})
      : super(key: key);
  final Color colour;
  final Widget? cardChild;
  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
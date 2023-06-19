import 'package:flutter/material.dart';
import 'icon_content.dart';

class BottomButton extends StatelessWidget {
  BottomButton({required this.onTap, this.buttonTitle});

  final VoidCallback onTap;
  final String? buttonTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.redAccent,
        margin: EdgeInsets.all(10.0),
        width: double.infinity,
        height: 80.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(buttonTitle??'',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
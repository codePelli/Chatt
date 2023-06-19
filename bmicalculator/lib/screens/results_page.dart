import 'package:bmicalculator/constants.dart';
import 'package:bmicalculator/components/reusable_card.dart';
import 'package:flutter/material.dart';
import 'input_page.dart';
import 'package:bmicalculator/components/bottom_button.dart';

class ResultsPage extends StatelessWidget {

  ResultsPage({this.interp, this.bmiResult, this.resultText});

  final String? bmiResult;
  final String? resultText;
  final String? interp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Your result',
                style: labelTitle,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ReusableCard(
                colour: activeCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  Text(resultText!,
                    style: resultTextStyle,
                  ),
                  Text(bmiResult!,
                    style: bmiTextStyle,
                  ),
                  Text(interp!,
                    textAlign: TextAlign.center,
                    style: bmiResultStyle,
                  ),
                ],
              ),
            ),
          ),
          BottomButton(onTap:(){
            Navigator.pop(context);
          },
            buttonTitle: 'RE-CALCULATE',)
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: Text(
          "Calculator",
          style: TextStyle(
            fontSize: 27.5,
          ),
        ),
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double equationFontSize = 38;
  double defEquationFontSize = 38;
  double resultFontSize = 48;
  double defResultFontSize = 48;
  String equation = "0";
  String result = "0";
  String expression = "";

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: buttonColor,
        ),
        child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(16.0),
            onPressed: () => buttonPressed(buttonText),
            child: Text(
              buttonText,
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            )),
      ),
    );
  }

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C" || buttonText == "AC") {
        equation = "0";
        result = "0";
        equationFontSize = defEquationFontSize;
        resultFontSize = defResultFontSize;
        // print("\"$buttonText\" pressed");
      } else if (buttonText == "⌫") {
        // equationFontSize = defResultFontSize;
        // resultFontSize = defEquationFontSize;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
        print(buttonText);
      } else if (buttonText == "=") {
        equationFontSize = defEquationFontSize;
        resultFontSize = defResultFontSize;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          final _val = exp.evaluate(EvaluationType.REAL, cm);
          if(_val.runtimeType==double){
            result=_val.toStringAsFixed(_val.truncateToDouble() == _val ? 0 : 1);
          }else{
          result = "$_val";
          }
        } catch (e) {
          result = "Err";
        }
      } else {
        equationFontSize = defEquationFontSize;
        resultFontSize = defResultFontSize;
        if (equation == "0") {
          equation = buttonText;
        } else {
          if (result != "0") {
            resultFontSize = defEquationFontSize;
            equationFontSize = defEquationFontSize;
            result = "0";
            equation = "";
            equation += buttonText;
          } else if (result == "0") {
            resultFontSize = defEquationFontSize;
            equationFontSize = defEquationFontSize;
            equation += buttonText;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Text(
            equation,
            style: TextStyle(
              fontSize: equationFontSize,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Text(
            result,
            style: TextStyle(
              fontSize: resultFontSize,
            ),
          ),
        ),
        Expanded(child: Divider()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 1,
              child: Table(
                children: <TableRow>[
                  TableRow(
                    children: <Widget>[
                      buildButton("C", 1, Colors.redAccent),
                      buildButton("AC", 1, Colors.redAccent),
                      buildButton("⌫", 1, Colors.redAccent),
                      buildButton("÷", 1, Colors.green),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      buildButton("7", 1, Colors.orange),
                      buildButton("8", 1, Colors.orange),
                      buildButton("9", 1, Colors.orange),
                      buildButton("×", 1, Colors.green),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      buildButton("4", 1, Colors.orange),
                      buildButton("5", 1, Colors.orange),
                      buildButton("6", 1, Colors.orange),
                      buildButton("-", 1, Colors.green),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      buildButton("1", 1, Colors.orange),
                      buildButton("2", 1, Colors.orange),
                      buildButton("3", 1, Colors.orange),
                      buildButton("+", 1, Colors.green),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      buildButton(".", 1, Colors.orange),
                      buildButton("0", 1, Colors.orange),
                      buildButton("00", 1, Colors.orange),
                      buildButton("=", 1, Colors.green),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

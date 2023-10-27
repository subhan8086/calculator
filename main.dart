import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

const buttoncolor = Colors.red;
const operatorcolor = Colors.orange;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Calculator(),
  ));
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  //varialee
  double firstnum = 0.0;
  double secnum = 0.0;
  var input = "";
  var output = "";
  var operation = "";
  var hideinput = false;
  var outputsize = 34.0;
  ////creat metod
  onButtonClick(value) {
    //if value is AC
    if (value == "AC") {
      input = "";
      output = "";
    }
    //if value is <
    else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    }
    //if value is =

    else if (value == "=") {
      if (input.isNotEmpty) {
        var userinput = input;
        userinput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression ex = p.parse(userinput);
        ContextModel cm = ContextModel();
        var finalvalue = ex.evaluate(EvaluationType.REAL, cm);
        output = finalvalue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideinput = true;
        outputsize = 53.0;
      }
    } else {
      hideinput = false;
      outputsize = 34.0;
      input = input + value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ///input output area
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              //  color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideinput ? '' : input,
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                        fontSize: outputsize,
                        color: Colors.white.withOpacity(0.7)),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          // Buttons area
          Row(
            children: [
              button(
                text: "AC",
                textcolor: Colors.white,
                buttonbgcolor: Colors.grey,
              ),
              button(
                text: "<",
                textcolor: Colors.white,
                buttonbgcolor: Colors.grey,
              ),
              button(
                text: "",
                buttonbgcolor: Colors.grey,
              ),
              button(
                text: "/",
                buttonbgcolor: Colors.grey,
                textcolor: Colors.white,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(
                text: "x",
                buttonbgcolor: Colors.grey,
                textcolor: Colors.white,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                text: "-",
                buttonbgcolor: Colors.grey,
                textcolor: Colors.white,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(
                text: "+",
                buttonbgcolor: Colors.grey,
                textcolor: Colors.white,
              ),
            ],
          ),
          Row(
            children: [
              button(
                text: "%",
                buttonbgcolor: Colors.grey,
                textcolor: Colors.white,
              ),
              button(text: "0"),
              button(text: "."),
              button(
                text: "=",
                buttonbgcolor: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({
    required String text,
    Color textcolor = Colors.white,
    Color buttonbgcolor = Colors.green,
  }) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => onButtonClick(text),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: textcolor,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          primary: buttonbgcolor,
          padding: EdgeInsets.all(27),
        ),
      ),
    );
  }
}

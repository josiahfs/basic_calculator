import 'package:basic_calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Calculator',
      theme: ThemeData(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> buttons = [
    'C',
    '\u00b1',
    '%',
    '\u00f7',
    '7',
    '8',
    '9',
    '\u00d7',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '.',
    '0',
    'DEL',
    '=',
  ];

  var userInput = '';
  var result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F3),
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 3.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 3.0),
                  alignment: Alignment.centerRight,
                  child: AutoSizeText(
                    result,
                    style: TextStyle(fontSize: 96),
                    minFontSize: 40,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 3.3 * 2,
          child: Container(
            child: GridView.builder(
              padding: EdgeInsets.only(bottom: 8),
              itemCount: buttons.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (context, index) {
                return Buttons(
                  color: Colors.white,
                  textColor: Color(0xff000000),
                  buttonText: buttons[index],
                  onPressed: () {
                    setState(
                      () {
                        if (buttons[index] == 'C') {
                          userInput = '';
                          result = '';
                        } else if (buttons[index] == 'DEL') {
                          if (userInput.isNotEmpty) {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          }
                        } else if (buttons[index] == '\u00b1') {
                          if (userInput.isNotEmpty) {
                            userInput = '-' + userInput;
                          } else {
                            userInput = '-';
                          }
                        } else if (buttons[index] == '\u00f7') {
                          userInput += '\u00f7';
                        } else if (buttons[index] == '\u00d7') {
                          userInput += '\u00d7';
                        } else if (buttons[index] == '-') {
                          userInput += '-';
                        } else if (buttons[index] == '+') {
                          userInput += '+';
                        } else if (buttons[index] == '%') {
                          userInput += '%';
                        } else if (buttons[index] == '=') {
                          calculate();
                        } else {
                          userInput += buttons[index];
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        )
      ]),
    );
  }

  void calculate() {
    String finalInput = userInput;
    finalInput = finalInput
        .replaceAll('\u00d7', '*')
        .replaceAll('\u00f7', '/')
        .replaceAll('%', '*0.01');
    Parser p = Parser();
    Expression exp = p.parse(finalInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    result = removeDecimalZeroFormat(eval);
  }

  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }
}

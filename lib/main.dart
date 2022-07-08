import 'package:basic_calculator/buttons.dart';
import 'package:flutter/material.dart';

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
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'X',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    ' ',
    '0',
    '.',
    '=',
  ];

  var userInput = '';
  var result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F3),
      body: Column(children: [
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: TextStyle(fontSize: 96),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Center(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
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
                          } else if (buttons[index] == '=') {
                            result = calculate(userInput);
                          } else if (buttons[index] == '/') {
                            userInput += '/';
                          } else if (buttons[index] == 'X') {
                            userInput += '*';
                          } else if (buttons[index] == '-') {
                            userInput += '-';
                          } else if (buttons[index] == '+') {
                            userInput += '+';
                          } else if (buttons[index] == '%') {
                            userInput += '%';
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
          ),
        )
      ]),
    );
  }

  String calculate(String userInput) {
    result = userInput;
    return result;
  }
}

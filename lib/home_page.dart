import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'constants.dart';
import 'custom_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final buttonText = [
    'AC',
    'C',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '='
  ];

  List history = [];

  var userQuestion = '';
  var userAnswer = '0';

  bool isTopButton(String x) {
    if (x == 'AC' || x == 'C' || x == '%') {
      return true;
    } else {
      return false;
    }
  }

  bool isOperand(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    } else {
      return false;
    }
  }


  allClear() {
    userQuestion = '';
    userAnswer = '0';
  }


  clear() {
    userQuestion = userQuestion.substring(0, userQuestion.length - 1);
  }

  buttonTapped(text) {
    if(text=='+'|| text=='-'|| text=='x'|| text=='/'|| text== '%'){
      if(userAnswer != '0'){
        userQuestion = userAnswer + text;
        userAnswer='0';
      }else{userQuestion += text;}
  }else{
      if(userAnswer != '0'){
        userQuestion='';
        userQuestion += text;
        userAnswer='0';
      }else{userQuestion += text;}
    }
  }

  equal() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    if (eval % 1 == 0.0) {
      print(eval % 1);
      userAnswer = eval.toInt().toString();
    } else {
      userAnswer = eval.toStringAsFixed(3);
    }

    if (history.length == 10) {
      history.removeAt(0);
      history.add('$userQuestion = $userAnswer');
    } else {
      history.add('$userQuestion = $userAnswer');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        color: Colors.black,
        minHeight: 70,
        collapsed: Container(
          color: Colors.black,
          child: Center(
            child: Icon(
              Icons.keyboard_arrow_up_outlined,
              size: 40,
            ),
          ),
        ),
        panel: history.length == 0
            ? Center(
            child: Text('No history yet'),
            )
            : ListView.builder(
                itemCount: history.length,
                itemBuilder: (BuildContext context, i) {
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      history[i],
                      style: kHistory,
                    ),
                  );
                },
              ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userQuestion,
                        style: kQuestionTextStyle,
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        userAnswer,
                        style: kAnswerTextStyle,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: buttonText.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomButton(
                      buttonText: buttonText[index],
                      buttonColor: isTopButton(buttonText[index])
                          ? kLightGrey
                          : isOperand(buttonText[index])
                              ? kOrange
                              : kDarkGrey,
                      onPressed: buttonText[index] == 'AC'
                          ? () {
                              setState(() {
                                allClear();
                              });
                            }
                          : buttonText[index] == 'C'
                              ? () {
                                  setState(() {
                                    clear();
                                  });
                                }
                              : buttonText[index] == '='
                                  ? () {
                                      setState(() {
                                        equal();
                                      });
                                    }
                                  : () {
                                      setState(() {
                                        buttonTapped(buttonText[index]);
                                      });
                                    },
                    );
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.count(
                      (index == 18) ? 2 : 1, (index == 18) ? 1 : 1),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

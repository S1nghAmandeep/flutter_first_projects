import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key, required this.title});
  final String title;
  
  @override
  State<Calculator> createState() => _CalculatorState();
}


class _CalculatorState extends State<Calculator> {
  String resultString = "";
  String operator = "";

  void handleButtonPressed(String buttonPressed) {
    setState(() {
      resultString += buttonPressed;
    });
  }

  void handleOperatorButtonPressed(String operatorPressed) {
    setState(() {
      resultString += operatorPressed;
      operator = operatorPressed;
    });
  }

  void handleClearButtonPressed() {
    setState(() {
      resultString = '';
      operator = '';
    });
  }

  void handleEqualButtonPressed() {
    setState(() {
      int leftSideValueAsInteger = int.parse(resultString.substring(0, resultString.indexOf(operator)));
      int rightSideValueAsInteger = int.parse(resultString.substring(resultString.indexOf(operator) + 1));
      switch (operator) {
        case "+":
          resultString = (leftSideValueAsInteger + rightSideValueAsInteger).toString();
          break;
        case "-":
          resultString = (leftSideValueAsInteger - rightSideValueAsInteger).toString();
          break;
        case "x":
          resultString = (leftSideValueAsInteger * rightSideValueAsInteger).toString();
          break;
        case "/":
          resultString = (leftSideValueAsInteger / rightSideValueAsInteger).toString();
          break;
      }
      operator = '';
    });
  }

  void handleDeleteButtonPressed() {
    setState(() {
      if (resultString.isNotEmpty) {
        resultString = resultString.substring(0, resultString.length - 1);
      }
    });
  }

  Color getButtonColor(String text) {
    switch (text) {
      case 'DEL':
        return Colors.orangeAccent;
      case 'C':
        return Colors.redAccent;
      case '=':
        return Colors.lightGreen;
      default:
        return Colors.lightBlue.shade200;
    }
  }


  Widget buildButton(String text, void Function() onPressed) {
    return SizedBox(
        width: 1000,
        height: 2,
        child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(getButtonColor(text))),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: text == 'DEL' ? 20 : 28, color: Colors.black87),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  resultString,
                  style: const TextStyle(fontSize: 50),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount:4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: const EdgeInsets.all(10),
              children: [
                buildButton('7', () => handleButtonPressed('7')),
                buildButton('8', () => handleButtonPressed('8')),
                buildButton('9', () => handleButtonPressed('9')),
                buildButton('x', () => handleOperatorButtonPressed('x')),
                buildButton('4', () => handleButtonPressed('4')),
                buildButton('5', () => handleButtonPressed('5')),
                buildButton('6', () => handleButtonPressed('6')),
                buildButton('-', () => handleOperatorButtonPressed('-')),
                buildButton('1', () => handleButtonPressed('1')),
                buildButton('2', () => handleButtonPressed('2')),
                buildButton('3', () => handleButtonPressed('3')),
                buildButton('+', () => handleOperatorButtonPressed('+')),
                buildButton('C', handleClearButtonPressed),
                buildButton('0', () => handleButtonPressed('0')),
                buildButton('DEL', handleDeleteButtonPressed),
                buildButton('/', () => handleOperatorButtonPressed('/')),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(getButtonColor('='))),
                  onPressed: handleEqualButtonPressed,
                  child: const Text(
                    '=',
                    style: TextStyle(fontSize: 28,  color: Colors.black87), 
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

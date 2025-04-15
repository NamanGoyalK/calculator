import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String input = '0';
  double num1 = 0, num2 = 0, result = 0;
  String op = '';
  bool shouldReset = false;
  String activeOperation = '';

  void onDigit(int digit) => setState(() {
        if (input == '0' || shouldReset || input == 'Error') {
          input = digit.toString();
          shouldReset = false;
        } else {
          if (input.length < 10) {
            input += digit.toString();
          }
        }
      });

  void onOperation(String operation) {
    if (input == 'Error') return;
    setState(() {
      try {
        if (op.isNotEmpty && !shouldReset) calculate();
        num1 = double.parse(input);
        op = operation;
        activeOperation = operation;
        shouldReset = true;
      } catch (_) {
        input = 'Error';
      }
    });
  }

  void calculate() {
    if (op.isEmpty || input == 'Error') return;
    setState(() {
      try {
        num2 = double.parse(input);
        switch (op) {
          case '+':
            result = num1 + num2;
            break;
          case '–':
            result = num1 - num2;
            break;
          case '×':
            result = num1 * num2;
            break;
          case '÷':
            if (num2 == 0) throw Exception();
            result = num1 / num2;
            break;
          case '%':
            if (num2 == 0) throw Exception();
            result = num1 % num2;
            break;
        }

        if (result.abs() > 999999999) {
          input = result.toStringAsExponential(4);
        } else {
          input = result % 1 == 0
              ? result.toInt().toString()
              : result
                  .toStringAsFixed(8)
                  .replaceAll(RegExp(r'0+$'), '')
                  .replaceAll(RegExp(r'\.$'), '');
        }

        activeOperation = '';
        op = '';
        shouldReset = true;
        num1 = result;
      } catch (_) {
        input = 'Error';
        activeOperation = '';
        op = '';
        shouldReset = true;
      }
    });
  }

  void clear() => setState(() {
        input = '0';
        op = '';
        activeOperation = '';
        num1 = num2 = result = 0;
        shouldReset = false;
      });

  void toggleSign() => setState(() {
        if (input != '0' && input != 'Error') {
          double value = double.parse(input) * -1;
          input = value % 1 == 0 ? value.toInt().toString() : value.toString();
        }
      });

  void addDecimal() => setState(() {
        if (shouldReset || input == 'Error') {
          input = '0.';
          shouldReset = false;
        } else if (!input.contains('.')) {
          input += '.';
        }
      });

  void backspace() => setState(() {
        if (input == 'Error') {
          input = '0';
        } else if (input.length > 1) {
          input = input.substring(0, input.length - 1);
        } else {
          input = '0';
        }
      });

  Widget buildButton(String text, VoidCallback onPressed, {double? fontSize}) {
    final theme = Theme.of(context);
    final isOperation = ['+', '–', '×', '÷', '%', '='].contains(text);
    final isFunction = ['AC', '+/–'].contains(text);
    final isActive = text == activeOperation;

    // Enhanced color scheme for buttons
    Color buttonColor;
    Color textColor;

    if (isActive) {
      // Active operator highlights
      buttonColor = theme.colorScheme.tertiary;
      textColor = theme.colorScheme.onTertiary;
    } else if (isOperation) {
      buttonColor = theme.colorScheme.secondaryContainer;
      textColor = theme.colorScheme.onSurface;
    } else if (isFunction) {
      buttonColor = theme.colorScheme.surfaceContainerHighest;
      textColor = theme.colorScheme.onSurface;
    } else {
      buttonColor = theme.colorScheme.surface;
      textColor = theme.colorScheme.onSurface;
    }

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: SizedBox(
        width: 80,
        height: 80,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: textColor,
            elevation: isActive ? 8 : 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            padding: EdgeInsets.zero,
            // Add subtle shadow for better depth
            shadowColor: isActive
                ? theme.colorScheme.primary.withAlpha(128)
                : theme.colorScheme.onSurface.withAlpha(51),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize ?? 30,
              fontWeight:
                  isOperation || isActive ? FontWeight.bold : FontWeight.normal,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'C A L - C',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                letterSpacing: 2.0,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 26),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.onSurface.withAlpha(7),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                  BoxShadow(
                    color: theme.colorScheme.onSurface.withAlpha(3),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                    spreadRadius: -2,
                  ),
                ],
              ),
              height: 120,
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Show active operation indicator
                    if (activeOperation.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          activeOperation,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onTertiary,
                          ),
                        ),
                      ),
                    Text(
                      input,
                      style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton('AC', clear),
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: ElevatedButton(
                          onPressed: backspace,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                theme.colorScheme.surfaceContainerHighest,
                            foregroundColor: theme.colorScheme.onSurface,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: Icon(Icons.backspace_outlined,
                              color: theme.colorScheme.onSurface),
                        ),
                      ),
                      buildButton('+/–', toggleSign),
                      buildButton('÷', () => onOperation('÷')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton('7', () => onDigit(7)),
                      buildButton('8', () => onDigit(8)),
                      buildButton('9', () => onDigit(9)),
                      buildButton('×', () => onOperation('×')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton('4', () => onDigit(4)),
                      buildButton('5', () => onDigit(5)),
                      buildButton('6', () => onDigit(6)),
                      buildButton('–', () => onOperation('–')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton('1', () => onDigit(1)),
                      buildButton('2', () => onDigit(2)),
                      buildButton('3', () => onDigit(3)),
                      buildButton('+', () => onOperation('+')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton('%', () => onOperation('%')),
                      buildButton('0', () => onDigit(0)),
                      buildButton('.', addDecimal),
                      buildButton('=', calculate),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

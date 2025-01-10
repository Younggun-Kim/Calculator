import 'dart:io';

import 'package:conduit_coding_test/calculator/domain/calculator.dart';
import 'package:conduit_coding_test/calculator/domain/calculator_console.dart';

void main() {
  final Calculator calculator = CalculatorImpl();
  final CalculatorConsole console = CalculatorConsoleImpl(
    calculator: calculator,
    input: stdin,
    output: stdout,
  );

  console.start();
}

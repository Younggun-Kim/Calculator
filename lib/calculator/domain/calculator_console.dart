import 'dart:io';

import 'package:conduit_coding_test/calculator/type/operation_type.dart';
import 'package:decimal/decimal.dart';

import 'calculator.dart';
import 'exceptions.dart';

/// 계산기 콘솔
abstract class CalculatorConsole {
  final Calculator calculator;
  final Stdin input;
  final Stdout output;

  CalculatorConsole({
    required this.calculator,
    required this.input,
    required this.output,
  });

  void start();

  void printWelcomeMessage();

  String getLeftOperand();

  String getRightOperand();

  OperationType getOperation();

  void calculate(String left, String right, OperationType operation);

  void processCalculation();
}

class CalculatorConsoleImpl extends CalculatorConsole {
  CalculatorConsoleImpl({
    required super.calculator,
    required super.input,
    required super.output,
  });

  @override
  void start() {
    printWelcomeMessage();
    processCalculation();
  }

  @override
  void printWelcomeMessage() {
    output.writeAll(
      [
        '안녕하세요. 계산기를 시작합니다.',
        "종료하려면 'q'를 입력해주세요.",
      ],
      "\n",
    );
  }

  /// 왼쪽 피연산자 얻기
  @override
  String getLeftOperand() {
    output.writeAll(
      [
        '',
        '첫 번째 숫자를 입력해주세요.',
        '> ',
      ],
      "\n",
    );
    return _getOperand();
  }

  /// 오른쪽 피연산자 얻기
  @override
  String getRightOperand() {
    output.writeAll(
      [
        '',
        '두 번째 숫자를 입력해주세요.',
        '> ',
      ],
      "\n",
    );
    return _getOperand();
  }

  /// 연산자 얻기
  @override
  OperationType getOperation() {
    output.writeAll(
      [
        '',
        '연산자를 입력해주세요.',
        "연산자는 +, -, *, / 중 하나를 사용해주세요.",
        '> ',
      ],
      "\n",
    );

    final operationInput = _getInput();
    final operation = OperationType.from(operationInput);

    if (operation.isNone) {
      throw UnsupportedOperationException();
    }

    return operation;
  }

  @override
  void calculate(String left, String right, OperationType operation) {
    try {
      final result = calculator.calculate(left, right, operation);
      output.writeln('\n계산 결과 >>> $result');
    } catch (e) {
      if (e is DivideByZeroException) {
        rethrow;
      }
      throw CalculationException();
    }
  }

  /// 계산기 프로세스
  @override
  void processCalculation() {
    try {
      final left = getLeftOperand();
      final operation = getOperation();
      final right = getRightOperand();
      calculate(left, right, operation);
    } catch (e) {
      if (e is CalculatorException) {
        output.writeln(e.message);
      }
    }
  }

  /// 콘솔에서 값 입 받기
  String? _getInput() {
    return input.readLineSync();
  }

  /// 종료 커맨드 검사
  bool _isExitCommand(String? input) {
    return input == 'q';
  }

  /// 숫자 형식 유효성 검사
  bool _isValidNumber(String input) {
    return Decimal.tryParse(input) != null;
  }

  /// 피연산자 얻기.
  String _getOperand() {
    final input = _getInput();

    if (_isExitCommand(input)) {
      throw ExitCalculatorException();
    }

    if (input == null || !_isValidNumber(input)) {
      throw InvalidNumberFormat();
    }

    return input;
  }
}

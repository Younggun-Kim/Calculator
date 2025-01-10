import 'dart:io';

import 'package:conduit_coding_test/calculator/domain/calculator.dart';
import 'package:conduit_coding_test/calculator/type/operation_type.dart';

void main() {
  stdout.writeAll(
    [
      '안녕하세요. 계산기를 시작합니다.',
      "종료하려면 'q' 또는 'exit'를 입력하세요.",
      '첫 번째 숫자를 입력해주세요.',
      '> '
    ],
    "\n",
  );

  String? leftInput = stdin.readLineSync();

  if (leftInput == 'q' || leftInput == 'exit') {
    stdout.writeln('계산기를 종료합니다. 이용해주셔서 감사합니다!');
    return;
  }

  if (leftInput == null || double.tryParse(leftInput) == null) {
    stdout.writeln('올바른 숫자를 입력해주세요.');
    return;
  }

  stdout.writeAll(
    [
      '연산자를 입력해주세요.',
      "연산자는 +, -, *, / 중 하나를 사용해주세요.",
      '> ',
    ],
    "\n",
  );

  String? operationInput = stdin.readLineSync();
  OperationType? operation = OperationType.from(operationInput);

  if (operation.isNone) {
    stdout.writeln('! 지원하지 않는 연산자입니다. +, -, *, / 중 하나를 사용해주세요.');
    // 다시 연산자를 고르도록 해야겠네.
    return;
  }

  stdout.writeAll(
    [
      '두 번째 숫자를 입력해주세요.',
      '> ',
    ],
    "\n",
  );

  String? rightInput = stdin.readLineSync();
  if (rightInput == 'q' || rightInput == 'exit') {
    stdout.writeln('계산기를 종료합니다. 이용해주셔서 감사합니다!');
    return;
  }

  if (rightInput == null || double.tryParse(rightInput) == null) {
    stdout.writeln('올바른 숫자를 입력해주세요.');
    return;
  }

  final Calculator calculator = CalculatorImpl();
  final result = calculator.calculate(leftInput, rightInput, operation);

  print(result);
  stdout.writeln('계산 결과 >>> $result');
}

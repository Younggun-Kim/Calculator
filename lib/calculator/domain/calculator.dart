import 'package:conduit_coding_test/calculator/type/operation_type.dart';
import 'package:decimal/decimal.dart';

import 'operation.dart';

/// 계산기
abstract class Calculator {
  String calculate(
    String left,
    String right,
    OperationType operation,
  );
}

class CalculatorImpl implements Calculator {
  const CalculatorImpl();

  @override
  String calculate(
    String left,
    String right,
    OperationType operation,
  ) {
    final leftDecimal = Decimal.parse(left);
    final rightDecimal = Decimal.parse(right);
    final result =  Operation.from(operation).calculate(leftDecimal, rightDecimal);
    return result.toString();
  }
}

import 'package:conduit_coding_test/calculator/type/operation_type.dart';

import 'operation.dart';

class Calculator {
  const Calculator();

  static double calculator(
    double left,
    double right,
    OperationType operation,
  ) {
    return Operation.from(operation).calculate(left, right);
  }
}

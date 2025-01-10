import 'package:conduit_coding_test/calculator/core/constant.dart';
import 'package:conduit_coding_test/calculator/type/operation_type.dart';
import 'package:decimal/decimal.dart';

import 'exceptions.dart';

abstract class Operation {
  Decimal calculate(Decimal left, Decimal right);

  factory Operation.from(OperationType type) {
    switch (type) {
      case OperationType.add:
        return Add();
      case OperationType.subtract:
        return Subtract();
      case OperationType.multiply:
        return Multiply();
      case OperationType.divide:
        return Divide();
      case OperationType.none:
        return NoneOperation();
    }
  }
}

class NoneOperation implements Operation {
  @override
  Decimal calculate(Decimal left, Decimal right) {
    // TODO: implement calculate
    throw UnimplementedError();
  }
}

class Add implements Operation {
  @override
  Decimal calculate(Decimal left, Decimal right) {
    return left + right;
  }
}

class Subtract implements Operation {
  @override
  Decimal calculate(Decimal left, Decimal right) {
    return left - right;
  }
}

class Multiply implements Operation {
  @override
  Decimal calculate(Decimal left, Decimal right) {
    return left * right;
  }
}

class Divide implements Operation {
  @override
  Decimal calculate(Decimal left, Decimal right) {
    if (right == Decimal.zero) {
      throw DivideByZeroException();
    }
    ;
    return (left / right).toDecimal(
      scaleOnInfinitePrecision: CalculatorConstants.MAX_DECIMAL_PLACES,
    );
  }
}

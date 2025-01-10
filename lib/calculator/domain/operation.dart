import 'package:conduit_coding_test/calculator/type/operation_type.dart';

abstract class Operation {
  double calculate(double left, double right);

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
  double calculate(double left, double right) {
    // TODO: implement calculate
    throw UnimplementedError();
  }
}

class Add implements Operation {
  @override
  double calculate(double left, double right) {
    return left + right;
  }
}

class Subtract implements Operation {
  @override
  double calculate(double left, double right) {
    return left - right;
  }
}

class Multiply implements Operation {
  @override
  double calculate(double left, double right) {
    return left * right;
  }
}

class Divide implements Operation {
  @override
  double calculate(double left, double right) {
    return left / right;
  }
}

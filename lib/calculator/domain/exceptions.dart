abstract class CalculatorException implements Exception {
  final String message;

  const CalculatorException(this.message);

  @override
  String toString() => message;
}

class DivideByZeroException extends CalculatorException {
  DivideByZeroException() : super('0으로 나누실 수 없습니다.');
}

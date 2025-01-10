abstract class CalculatorException implements Exception {
  final String message;

  const CalculatorException(
    this.message,
  );

  @override
  String toString() => message;
}

class ExitCalculatorException extends CalculatorException {
  ExitCalculatorException()
      : super(
          '계산기를 종료합니다.',
        );
}

class DivideByZeroException extends CalculatorException {
  DivideByZeroException()
      : super(
          '0으로 나누실 수 없습니다.',
        );
}

class InvalidNumberFormat extends CalculatorException {
  InvalidNumberFormat()
      : super(
          '올바른 숫자를 입력해주세요.',
        );
}

class UnsupportedOperationException extends CalculatorException {
  UnsupportedOperationException()
      : super(
          '! 지원하지 않는 연산자입니다. +, -, *, / 중 하나를 사용해주세요.',
        );
}

class CalculationException extends CalculatorException {
  CalculationException()
      : super(
          '계산 중 오류가 발생했습니다',
        );
}

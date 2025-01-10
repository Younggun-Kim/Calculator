import 'package:conduit_coding_test/calculator/domain/calculator.dart';
import 'package:conduit_coding_test/calculator/domain/exceptions.dart';
import 'package:conduit_coding_test/calculator/type/operation_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Calculator calculator;

  setUp(() {
    calculator = CalculatorImpl();
  });

  group('기본 산술 연산 테스트', () {
    // 1.1 덧셈 테스트
    group('덧셈 연산', () {
      test('정수 덧셈', () {
        expect(
          calculator.calculate('5', '3', OperationType.add),
          '8',
        );
        expect(
          calculator.calculate('0', '0', OperationType.add),
          '0',
        );
        expect(
          calculator.calculate('999', '1', OperationType.add),
          '1000',
        );
      });

      test('소수점 덧셈', () {
        expect(
          calculator.calculate('5.5', '3.3', OperationType.add),
          '8.8',
        );
        expect(
          calculator.calculate('0.1', '0.2', OperationType.add),
          '0.3',
        );
      });
    });

    // 1.2 뺄셈 테스트
    group('뺄셈 연산', () {
      test('정수 뺄셈', () {
        expect(
          calculator.calculate('5', '3', OperationType.subtract),
          '2',
        );
        expect(
          calculator.calculate('3', '5', OperationType.subtract),
          '-2',
        );
        expect(
          calculator.calculate('0', '0', OperationType.subtract),
          '0',
        );
      });

      test('소수점 뺄셈', () {
        expect(
          calculator.calculate('5.5', '3.3', OperationType.subtract),
          '2.2',
        );
        expect(
          calculator.calculate('0.3', '0.1', OperationType.subtract),
          '0.2',
        );
      });
    });

    // 1.3 곱셈 테스트
    group('곱셈 연산', () {
      test('정수 곱셈', () {
        expect(
          calculator.calculate('5', '3', OperationType.multiply),
          '15',
        );
        expect(
          calculator.calculate('0', '5', OperationType.multiply),
          '0',
        );
        expect(
          calculator.calculate('-2', '3', OperationType.multiply),
          '-6',
        );
      });

      test('소수점 곱셈', () {
        expect(
          calculator.calculate('5.5', '2', OperationType.multiply),
          '11',
        );
        expect(
          calculator.calculate('0.1', '0.2', OperationType.multiply),
          '0.02',
        );
      });
    });

    // 1.4 나눗셈 테스트
    group('나눗셈 연산', () {
      test('정수 나눗셈', () {
        expect(
          calculator.calculate('6', '2', OperationType.divide),
          '3',
        );
        expect(
          calculator.calculate('5', '2', OperationType.divide),
          '2.5',
        );
        expect(
          calculator.calculate('0', '5', OperationType.divide),
          '0',
        );
      });

      test('소수점 나눗셈', () {
        expect(
          calculator.calculate('5.5', '2', OperationType.divide),
          '2.75',
        );
        expect(
          calculator.calculate('1', '0.5', OperationType.divide),
          '2',
        );
      });

      test('0으로 나누기 예외처리', () {
        expect(
            () => calculator.calculate('5', '0', OperationType.divide),
          throwsA(isA<DivideByZeroException>()),
        );
      });
    });
  });

  // 2. 피연산자(Operand) 형식 테스트
  group('피연산자 형식 테스트', () {
    test('올바른 정수 형식', () {
      expect(
        calculator.calculate('123', '456', OperationType.add),
        '579',
      );
      expect(
        calculator.calculate('0', '0', OperationType.multiply),
        '0',
      );
    });

    test('올바른 소수점 형식', () {
      expect(
        calculator.calculate('123.456', '456.789', OperationType.add),
        '580.245',
      );
      expect(
        calculator.calculate('0.1', '0.2', OperationType.add),
        '0.3',
      );
    });
  });
}

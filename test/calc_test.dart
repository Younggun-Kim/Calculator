import 'package:flutter_test/flutter_test.dart';

void main() {
  late Calculator calculator;

  setUp(() {
    calculator = Calculator();
  });

  group('기본 산술 연산 테스트', () {
    // 1.1 덧셈 테스트
    group('덧셈 연산', () {
      test('정수 덧셈', () {
        expect(calculator.calculate('5', '3', '+'), '8');
        expect(calculator.calculate('0', '0', '+'), '0');
        expect(calculator.calculate('999', '1', '+'), '1000');
      });

      test('소수점 덧셈', () {
        expect(calculator.calculate('5.5', '3.3', '+'), '8.8');
        expect(calculator.calculate('0.1', '0.2', '+'), '0.3');
      });
    });

    // 1.2 뺄셈 테스트
    group('뺄셈 연산', () {
      test('정수 뺄셈', () {
        expect(calculator.calculate('5', '3', '-'), '2');
        expect(calculator.calculate('3', '5', '-'), '-2');
        expect(calculator.calculate('0', '0', '-'), '0');
      });

      test('소수점 뺄셈', () {
        expect(calculator.calculate('5.5', '3.3', '-'), '2.2');
        expect(calculator.calculate('0.3', '0.1', '-'), '0.2');
      });
    });

    // 1.3 곱셈 테스트
    group('곱셈 연산', () {
      test('정수 곱셈', () {
        expect(calculator.calculate('5', '3', '*'), '15');
        expect(calculator.calculate('0', '5', '*'), '0');
        expect(calculator.calculate('-2', '3', '*'), '-6');
      });

      test('소수점 곱셈', () {
        expect(calculator.calculate('5.5', '2', '*'), '11.0');
        expect(calculator.calculate('0.1', '0.2', '*'), '0.02');
      });
    });

    // 1.4 나눗셈 테스트
    group('나눗셈 연산', () {
      test('정수 나눗셈', () {
        expect(calculator.calculate('6', '2', '/'), '3');
        expect(calculator.calculate('5', '2', '/'), '2.5');
        expect(calculator.calculate('0', '5', '/'), '0');
      });

      test('소수점 나눗셈', () {
        expect(calculator.calculate('5.5', '2', '/'), '2.75');
        expect(calculator.calculate('1', '0.5', '/'), '2');
      });

      test('0으로 나누기 예외처리', () {
        expect(() => calculator.calculate('5', '0', '/'),
            throwsA(isA<DivisionByZeroException>()));
      });
    });
  });

  // 2. 피연산자(Operand) 형식 테스트
  group('피연산자 형식 테스트', () {
    test('올바른 정수 형식', () {
      expect(calculator.calculate('123', '456', '+'), '579');
      expect(calculator.calculate('0', '0', '+'), '0');
    });

    test('올바른 소수점 형식', () {
      expect(calculator.calculate('123.456', '456.789', '+'), '580.245');
      expect(calculator.calculate('0.1', '0.2', '+'), '0.3');
    });

    test('잘못된 형식 예외처리', () {
      expect(calculator.calculate('12,345', '67,890', '+'),
          throwsA(isA<InvalidOperandFormatException>()));
      expect(calculator.calculate('abc', '123', '+'),
          throwsA(isA<InvalidOperandFormatException>()));
    });
  });

  // 3. 입력 형식 테스트
  group('입력 형식 테스트', () {
    test('올바른 입력 형식', () {
      expect(calculator.calculate('5', '3', '+'), '8');
      expect(calculator.calculate('10.5', '3.2', '-'), '7.3');
    });

    test('잘못된 입력 형식 예외처리', () {
      expect(calculator.calculate('5', '3 + 2'),
          throwsA(isA<InvalidInputFormatException>()));
      expect(calculator.calculate('5', '3', '++'),
          throwsA(isA<InvalidInputFormatException>()));
      expect(calculator.calculate('5', '', '+'),
          throwsA(isA<InvalidInputFormatException>()));
    });
  });

  // 4. 출력 형식 테스트
  group('출력 형식 테스트', () {
    test('천단위 구분자 없음 확인', () {
      expect(calculator.calculate('1000', '234', '+'), '1234');
      expect(calculator.calculate('9999', '1', '+'), '10000');
      expect(calculator.calculate('20', '200', '*'), '4000');
    });
  });
}

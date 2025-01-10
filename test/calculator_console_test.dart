import 'dart:collection';
import 'dart:io';

import 'package:conduit_coding_test/calculator/domain/calculator.dart';
import 'package:conduit_coding_test/calculator/domain/calculator_console.dart';
import 'package:conduit_coding_test/calculator/domain/exceptions.dart';
import 'package:conduit_coding_test/calculator/type/operation_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStdin extends Mock implements Stdin {}

class MockStdout extends Mock implements Stdout {}

class MockCalculator extends Mock implements CalculatorImpl {}

void main() {
  group('CalculatorConsole', () {
    late Calculator calculator;
    late CalculatorConsole console;
    late MockStdin mockStdin;
    late MockStdout mockStdout;

    setUp(() {
      calculator = MockCalculator();
      mockStdin = MockStdin();
      mockStdout = MockStdout();
      console = CalculatorConsoleImpl(
        calculator: calculator,
        input: mockStdin,
        output: mockStdout,
      );
    });

    group('왼쪽 입력값 검증', () {
      test('정상적인 숫자 입력시 입력한 숫자가 반환된다.', () {
        // Given
        when(() => mockStdin.readLineSync()).thenReturn('1000');

        // When & Then
        expect(
          console.getLeftOperand(),
          '1000',
        );
      });

      test('숫자가 아닌 입력 시 InvalidNumberFormat 예외 발생', () {
        // Given
        when(() => mockStdin.readLineSync()).thenReturn('abc');

        // When & Then
        expect(
          () => console.getLeftOperand(),
          throwsA(isA<InvalidNumberFormat>()),
        );
      });

      test('빈 입력 시 InvalidNumberFormat 예외 발생', () {
        // Given
        when(() => mockStdin.readLineSync()).thenReturn('');

        // When & Then
        expect(
          () => console.getLeftOperand(),
          throwsA(isA<InvalidNumberFormat>()),
        );
      });

      test('q 입력시 ExitCalculatorException 예외 발생', () {
        // Given
        when(() => mockStdin.readLineSync()).thenReturn('q');

        // When & Then
        expect(
          () => console.getLeftOperand(),
          throwsA(isA<ExitCalculatorException>()),
        );
      });

      test('숫자 입력시 "," 가 포함되면 InvalidNumberFormat 예외 발생 ', () {
        // Given
        when(() => mockStdin.readLineSync()).thenReturn('1,000');

        // When & Then
        expect(
          () => console.getLeftOperand(),
          throwsA(isA<InvalidNumberFormat>()),
        );
      });
    });

    group('오른쪽 입력값 검증', () {
      test('정상적인 숫자 입력시 입력한 숫자가 반환된다.', () {
        // Given
        when(() => mockStdin.readLineSync()).thenReturn('1000');

        // When & Then
        expect(
          console.getRightOperand(),
          '1000',
        );
      });

      test('숫자가 아닌 입력 시 InvalidNumberFormat 예외 발생', () {
        // Given
        when(() => mockStdin.readLineSync()).thenReturn('abc');

        // When & Then
        expect(
          () => console.getRightOperand(),
          throwsA(isA<InvalidNumberFormat>()),
        );
      });

      test('빈 입력 시 InvalidNumberFormat 예외 발생', () {
        // Given
        when(() => mockStdin.readLineSync()).thenReturn('');

        // When & Then
        expect(
          () => console.getRightOperand(),
          throwsA(isA<InvalidNumberFormat>()),
        );
      });

      test('q 입력시 ExitCalculatorException 예외 발생', () {
        // Given
        when(() => mockStdin.readLineSync()).thenReturn('q');

        // When & Then
        expect(
          () => console.getRightOperand(),
          throwsA(isA<ExitCalculatorException>()),
        );
      });

      test('숫자 입력시 "," 가 포함되면 InvalidNumberFormat 예외 발생 ', () {
        // Given
        when(() => mockStdin.readLineSync()).thenReturn('1,000');

        // When & Then
        expect(
          () => console.getRightOperand(),
          throwsA(isA<InvalidNumberFormat>()),
        );
      });
    });

    group('연산자 검증', () {
      test('유효한 연산자 입력시 올바른 OperationType 반환', () {
        // Given
        when(() => mockStdin.readLineSync()).thenReturn('+');

        // When & Then
        expect(
          console.getOperation(),
          equals(OperationType.add),
        );
      });

      test('유효하지 않은 연산자 입력시 UnsupportedOperationException 발생', () {
        // Given
        when(() => mockStdin.readLineSync()).thenReturn('++');

        // When & Then
        expect(
          () => console.getOperation(),
          throwsA(isA<UnsupportedOperationException>()),
        );
      });

      test('빈 연산자 입력시 UnsupportedOperationException 발생', () {
        // Given
        when(() => mockStdin.readLineSync()).thenReturn('');

        // When & Then
        expect(
          () => console.getOperation(),
          throwsA(isA<UnsupportedOperationException>()),
        );
      });
    });

    group('계산 프로세스', () {
      test('10 + 5 는 15로 계산된다.', () {
        // Given
        when(
          () => calculator.calculate('10', '5', OperationType.add),
        ).thenReturn('15');

        // When
        console.calculate('10', '5', OperationType.add);

        // Then
        verify(
          () => calculator.calculate('10', '5', OperationType.add),
        ).called(1);

        verify(() => mockStdout.writeln('\n계산 결과 >>> 15')).called(1);
      });

      test('0으로 나누기 시 DivideByZeroException 발생', () {
        // Given
        when(
          () => calculator.calculate('10', '0', OperationType.divide),
        ).thenThrow(DivideByZeroException());

        // When & Then
        expect(
          () => console.calculate('10', '0', OperationType.divide),
          throwsA(isA<DivideByZeroException>()),
        );
        verify(
          () => calculator.calculate('10', '0', OperationType.divide),
        ).called(1);
      });

      test('계산 중 예외 발생시 CalculationException으로 변환', () {
        // Given
        when(
          () => calculator.calculate('10', '+', OperationType.divide),
        ).thenThrow(CalculationException());

        // When & Then
        expect(
          () => console.calculate('10', '+', OperationType.divide),
          throwsA(isA<CalculationException>()),
        );
        verify(
          () => calculator.calculate('10', '+', OperationType.divide),
        ).called(1);
      });
    });

    group('통합 테스트', () {
      test('정상적인 덧셈 시나리오', () {
        // Given
        final responses = Queue<String>.from(['10', '+', '20']);

        when(() => mockStdin.readLineSync())
            .thenAnswer((_) => responses.removeFirst());

        when(() => calculator.calculate('10', '20', OperationType.add))
            .thenReturn('30');

        // When
        console.start();

        // Then
        verify(() => calculator.calculate('10', '20', OperationType.add))
            .called(1);

        verifyInOrder([
          () => mockStdout.writeAll(
                [
                  '안녕하세요. 계산기를 시작합니다.',
                  "종료하려면 'q'를 입력해주세요.",
                ],
                "\n",
              ),
          () => mockStdout.writeAll(
                [
                  '',
                  '첫 번째 숫자를 입력해주세요.',
                  '> ',
                ],
                "\n",
              ),
          () => mockStdout.writeAll(
                [
                  '',
                  '연산자를 입력해주세요.',
                  "연산자는 +, -, *, / 중 하나를 사용해주세요.",
                  '> ',
                ],
                "\n",
              ),
          () => mockStdout.writeAll(
                [
                  '',
                  '두 번째 숫자를 입력해주세요.',
                  '> ',
                ],
                "\n",
              ),
          () => mockStdout.writeln("\n계산 결과 >>> ${30}"),
        ]);
      });

      test('종료 명령어 입력 시나리오', () {
        // Given
        final responses = Queue<String>.from(['10', '+', 'q']);

        when(() => mockStdin.readLineSync())
            .thenAnswer((_) => responses.removeFirst());

        console.start();
        // When & Then
        verifyInOrder([
          () => mockStdout.writeAll(
                [
                  '안녕하세요. 계산기를 시작합니다.',
                  "종료하려면 'q'를 입력해주세요.",
                ],
                "\n",
              ),
          () => mockStdout.writeAll(
                [
                  '',
                  '첫 번째 숫자를 입력해주세요.',
                  '> ',
                ],
                "\n",
              ),
          () => mockStdout.writeAll(
                [
                  '',
                  '연산자를 입력해주세요.',
                  "연산자는 +, -, *, / 중 하나를 사용해주세요.",
                  '> ',
                ],
                "\n",
              ),
          () => mockStdout.writeAll(
                [
                  '',
                  '두 번째 숫자를 입력해주세요.',
                  '> ',
                ],
                "\n",
              ),
          () => mockStdout.writeln("계산기를 종료합니다."),
        ]);
      });
    });
  });
}

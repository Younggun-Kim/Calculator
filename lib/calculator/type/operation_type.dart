/// 연산자 타입
enum OperationType {
  none(''),
  add('+'),
  subtract('-'),
  multiply('*'),
  divide('/');

  final String symbol;

  const OperationType(this.symbol);

  static OperationType from(String? input) => values.firstWhere(
        (value) => value.symbol == input,
        orElse: () => none,
      );
}

extension OperationTypeEx on OperationType {
  bool get isNone => this == OperationType.none;
}

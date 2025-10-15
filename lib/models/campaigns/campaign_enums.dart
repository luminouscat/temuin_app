enum RequirementOperator {
  greaterThan('>'),
  greaterThanOrEqual('>='),
  lessThan('<'),
  lessThanOrEqual('<='),
  equal('=='),
  inList('in');

  const RequirementOperator(this.symbol);
  final String symbol;

  static RequirementOperator fromString(String op) {
    switch (op) {
      case '>=':
        return RequirementOperator.greaterThanOrEqual;
      case '<=':
        return RequirementOperator.lessThanOrEqual;
      case '>':
        return RequirementOperator.greaterThan;
      case '<':
        return RequirementOperator.lessThan;
      case '==':
        return RequirementOperator.equal;
      case 'in':
        return RequirementOperator.inList;
      default:
        throw Exception('Unknown operator: $op');
    }
  }

  @override
  String toString() => symbol;
}

enum RequirementType {
  ageMin('age_min', 'Minimum Age'),
  language('language', 'Language'),
  postFrequencyMin('post_frequency_min', 'Minimum Posts per week');

  const RequirementType(this.value, this.displayName);
  final String value;
  final String displayName;

  static RequirementType fromString(String type) {
    return RequirementType.values.firstWhere(
      (t) => t.value == type,
      orElse: () => throw Exception('Unknown requirement type: $type'),
    );
  }

  @override
  String toString() => value;
}

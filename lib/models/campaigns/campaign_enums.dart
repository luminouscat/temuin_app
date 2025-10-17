enum RequirementOperator {
  greaterThan('>'),
  greaterThanOrEqual('>='),
  lessThan('<'),
  lessThanOrEqual('<='),
  equalEqual('=='),
  equal('='),
  inList('in'),
  contains('contains');

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
        return RequirementOperator.equalEqual;
      case '=':
        return RequirementOperator.equal;
      case 'in':
        return RequirementOperator.inList;
      case 'contains':
        return RequirementOperator.contains;
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
  postFrequencyMin('post_frequency_min', 'Minimum Posts per week'),
  engagementRateMin('engagement_rate_min', 'Minimum Engagement Rate'),
  nicheCategory('niche_category', 'Niche Category'),
  followersMin('followers_min', 'Followers Minimal'),
  ageMax('age_max', 'Maximum Age'),
  location('location', 'Lokasi'),
  businessAccount('business_account', 'Business Account'),
  verifiedAccount('verified_account', 'Verified Account'),
  followersMax('followers_max', 'Maximum Followers'),
  gender('gender', 'Gender');

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

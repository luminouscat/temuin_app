import 'package:temuin_app/models/campaigns/campaign_enums.dart';

class Requirement {
  const Requirement({
    required this.id,
    required this.campaignId,
    required this.requirementType,
    required this.requirementValue,
    required this.operator,
    required this.description,
  });

  final int id;
  final int campaignId;
  final RequirementType requirementType;
  final String requirementValue;
  final RequirementOperator operator;
  final String description;

  factory Requirement.fromJson(Map<String, dynamic> json) {
    return Requirement(
      id: json['id'],
      campaignId: json['campaign_id'],
      requirementType: RequirementType.fromString((json['requirement_type'])),
      requirementValue: json['requirement_value'],
      operator: RequirementOperator.fromString(json['operator']),
      description: json['description'],
    );
  }

  bool get isAgeMinRequirement => requirementType == RequirementType.ageMin;
  bool get isLangugageRequirement =>
      requirementType == RequirementType.language;
  bool get isPostFrequencyRequirement =>
      requirementType == RequirementType.postFrequencyMin;
  bool get isEngagementMinRequirement =>
      requirementType == RequirementType.postFrequencyMin;
  bool get isNicheCategoryRequirement =>
      requirementType == RequirementType.nicheCategory;
  bool get isFollowersMinRequirement =>
      requirementType == RequirementType.followersMin;
  bool get isFollowersMaxRequirement =>
      requirementType == RequirementType.followersMax;
  bool get isAgeMax => requirementType == RequirementType.ageMax;
  bool get isLocation => requirementType == RequirementType.location;
  bool get isBusinessAccount =>
      requirementType == RequirementType.businessAccount;
  bool get isVerifiedAccount =>
      requirementType == RequirementType.verifiedAccount;
  bool get isGender => requirementType == RequirementType.gender;

  // display in UI
  String get displayText {
    switch (requirementType) {
      case RequirementType.ageMin:
        return 'Age ${operator.symbol} $requirementValue years';
      case RequirementType.language:
        return 'Langugage $requirementValue';
      case RequirementType.postFrequencyMin:
        return 'Posts ${operator.symbol} $requirementValue per week';
      case RequirementType.engagementRateMin:
        return 'Engagement ${operator.symbol} $requirementValue minimal';
      case RequirementType.nicheCategory:
        return 'Category ${operator.symbol} $requirementValue';
      case RequirementType.followersMin:
        return 'Followers ${operator.symbol} $requirementValue followers';
      case RequirementType.followersMax:
        return 'Followers ${operator.symbol} $requirementValue';
      case RequirementType.ageMax:
        return 'Age ${operator.symbol} $requirementValue years';
      case RequirementType.location:
        return 'Location ${operator.symbol} $requirementValue';
      case RequirementType.businessAccount:
        return 'Account ${operator.symbol} $requirementValue';
      case RequirementType.verifiedAccount:
        return 'Account ${operator.symbol} $requirementValue';
      case RequirementType.gender:
        return 'Gender ${operator.symbol} $requirementValue';
    }
  }
}

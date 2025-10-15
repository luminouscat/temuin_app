import 'package:temuin_app/models/campaigns/campaign_enums.dart';

class Requirement {
  const Requirement({
    required this.id,
    required this.campaignId,
    required this.requirementType,
    required this.requirementValue,
    required this.operator,
    required this.description,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final int campaignId;
  final RequirementType requirementType;
  final String requirementValue;
  final RequirementOperator operator;
  final String description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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

  bool get isAgeRequirement => requirementType == RequirementType.ageMin;
  bool get isLangugageRequirement =>
      requirementType == RequirementType.language;
  bool get isPostFrequencyRequirement =>
      requirementType == RequirementType.postFrequencyMin;

  // display in UI
  String get displayText {
    switch (requirementType) {
      case RequirementType.ageMin:
        return 'Age ${operator.symbol} $requirementValue years';
      case RequirementType.language:
        return 'Langugage $requirementValue';
      case RequirementType.postFrequencyMin:
        return 'Posts ${operator.symbol} $requirementValue per week';
    }
  }
}

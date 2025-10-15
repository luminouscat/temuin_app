import 'package:temuin_app/models/campaigns/country.dart';
import 'package:temuin_app/models/campaigns/currency.dart';
import 'package:temuin_app/models/campaigns/requirement.dart';
import 'package:temuin_app/models/user.dart';

class Campaign {
  const Campaign({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.budgetMin,
    required this.budgetMax,
    required this.currencyId,
    required this.countryId,
    this.startDate,
    this.endDate,
    required this.applicationDeadline,
    required this.status,
    required this.maxParticipants,
    required this.location,
    required this.category,
    required this.targetAudience, //list
    required this.deliverables,
    required this.brandGuidelines,
    required this.applicationCount,
    this.createdAt,
    this.updatedAt,
    required this.owner,
    required this.requirements,
    required this.currency,
    required this.country,
  });

  final int id;
  final int userId;
  final String title;
  final String description;
  final String budgetMin;
  final String budgetMax;
  final int currencyId;
  final int countryId;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime applicationDeadline;
  final String status;
  final int maxParticipants;
  final String location;
  final String category;
  final List<String> targetAudience;
  final String deliverables;
  final String brandGuidelines;
  final int applicationCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // other models
  final User owner;
  final List<Requirement> requirements;
  final Currency currency;
  final Country country;

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      budgetMin: json['budget_min'],
      budgetMax: json['budget_max'],
      currencyId: json['currency_id'],
      countryId: json['country_id'],
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,
      applicationDeadline: DateTime.parse(json['application_deadlinec']),
      status: json['status'],
      maxParticipants: json['max_participants'],
      location: json['location'],
      category: json['category'],
      targetAudience: json['target_audience'],
      deliverables: json['deliverables'],
      brandGuidelines: json['brand_guidelines'],
      applicationCount: json['application_count'],
      owner: User.fromJson(json['owner']),
      requirements: (json['requirements'] as List)
          .map((req) => Requirement.fromJson(req))
          .toList(),
      currency: Currency.fromJson(json['currency']),
      country: Country.fromJson(json['country']),
    );
  }

  // converting deliverables
  List<String> get deliverablesList {
    return deliverables
        .split("\n")
        .where((line) => line.trim().isNotEmpty)
        .map((line) => line.replaceFirst('• ', '').trim())
        .toList();
  }

  // convert brand guidelines
  List<String> get guidelinesList {
    return brandGuidelines
        .split("\n")
        .where((line) => line.trim().isNotEmpty)
        .map((line) => line.replaceFirst('• ', '').trim())
        .toList();
  }

  // getters
  bool get isActive => status == "active";
  bool get isExpired => DateTime.now().isAfter(applicationDeadline);

  String get formattedBudget {
    final min = double.parse(budgetMin);
    final max = double.parse(budgetMax);
    return '${currency.formatAmount(min)} - ${currency.formatAmount(max)}';
  }

  int get daysUntilDeadline {
    return applicationDeadline.difference(DateTime.now()).inDays;
  }

  String get deadlineText {
    final days = daysUntilDeadline;
    if (days < 0) return 'Expired';
    if (days == 0) return 'Due today';
    if (days == 1) return '1 day left';
    return '$days days left';
  }

  Requirement? get ageRequirement {
    try {
      return requirements.firstWhere((req) => req.isAgeRequirement);
    } catch (e) {
      return null;
    }
  }

  List<Requirement> get languageRequirements {
    return requirements.where((req) => req.isLangugageRequirement).toList();
  }

  Requirement? get postFrequencyMin {
    try {
      return requirements.firstWhere((req) => req.isPostFrequencyRequirement);
    } catch (e) {
      return null;
    }
  }
}

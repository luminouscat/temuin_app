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
    required this.startDate,
    required this.endDate,
    required this.applicationDeadline,
    required this.status,
    required this.maxParticipants,
    required this.location,
    required this.category,
    required this.targetAudience,
    required this.deliverables,
    required this.brandGuidelines,
    required this.applicationsCount,
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
  final DateTime startDate;
  final DateTime endDate;
  final DateTime applicationDeadline;
  final String status;
  final int maxParticipants;
  final String location;
  final String category;
  final List<String> targetAudience;
  final String deliverables;
  final String brandGuidelines;
  final int applicationsCount;

  final User owner;
  final List<Requirement> requirements;
  final Currency currency;
  final Country country;

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      budgetMin: json['budget_min'] as String,
      budgetMax: json['budget_max'] as String,
      currencyId: json['currency_id'] as int,
      countryId: json['country_id'] as int,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      applicationDeadline: DateTime.parse(
        json['application_deadline'] as String,
      ),
      status: json['status'] as String,
      maxParticipants: json['max_participants'] as int,
      location: json['location'] as String,
      category: json['category'] as String,
      targetAudience:
          (json['target_audience'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          ["None"],

      deliverables: json['deliverables'] as String,
      brandGuidelines: json['brand_guidelines'] as String,
      applicationsCount: json['applications_count'] as int,

      // Parse nested models
      owner: User.fromJson(json['owner']),

      // ✨ SAFE LIST PARSING for requirements
      requirements:
          (json['requirements'] as List?)
              ?.map((req) => Requirement.fromJson(req as Map<String, dynamic>))
              .toList() ??
          [],

      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>),
      country: Country.fromJson(json['country'] as Map<String, dynamic>),
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

  // search helpers
  List<Requirement> get ageMinRequirement {
    return requirements.where((req) => req.isAgeMinRequirement).toList();
  }

  List<Requirement> get languageRequirements {
    return requirements.where((req) => req.isLangugageRequirement).toList();
  }

  List<Requirement> get postFrequencyMin {
    return requirements.where((req) => req.isPostFrequencyRequirement).toList();
  }

  List<Requirement> get engagementRateMin {
    return requirements.where((req) => req.isEngagementMinRequirement).toList();
  }

  List<Requirement> get nicheCategory {
    return requirements.where((req) => req.isNicheCategoryRequirement).toList();
  }

  List<Requirement> get followersMin {
    return requirements.where((req) => req.isFollowersMinRequirement).toList();
  }

  List<Requirement> get followersMax {
    return requirements.where((req) => req.isFollowersMaxRequirement).toList();
  }

  List<Requirement> get ageMax {
    return requirements.where((req) => req.isAgeMax).toList();
  }

  List<Requirement> get reqLocation {
    return requirements.where((req) => req.isLocation).toList();
  }

  List<Requirement> get businessAccount {
    return requirements.where((req) => req.isBusinessAccount).toList();
  }

  List<Requirement> get verifiedAccount {
    return requirements.where((req) => req.isVerifiedAccount).toList();
  }

  List<Requirement> get reqGender {
    return requirements.where((req) => req.isGender).toList();
  }
}

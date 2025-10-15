import 'package:dio/dio.dart';
import 'package:temuin_app/models/campaigns/campaign.dart';

class CampaignRepository {
  final Dio _dio;

  CampaignRepository(this._dio);

  // get all public (api/campaigns/)
  Future<List<Campaign>> getAllCampaigns() async {
    try {
      final response = await _dio.get('campaigns/');
      final List data = response.data is List
          ? response.data
          : response.data['data'] ?? [];

      return data.map((json) => Campaign.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // get one
  Future<Campaign> getOneCampaign(int id) async {
    try {
      final response = await _dio.get("campaigns/$id");
      return Campaign.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // influencers
  // apply to campaign
  Future<void> applyCampaign(int campaignId) async {
    try {
      await _dio.post(
        'campaigns/applications',
        data: {'campaigns_id': campaignId},
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // get influencer's applications
  Future<List<Campaign>> getMyApplications() async {
    try {
      final response = await _dio.get('campaigns/applications');
      final List data = response.data is List
          ? response.data
          : response.data['data'] ?? [];

      return data.map((json) => Campaign.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // // brands (no auth token for brands yet so cannot be tested)
  // // create campaigns
  // Future<Campaign> createCampaign({
  //   required String title,
  //   required String description,
  //   required String budgetMin,
  //   required String budgetMax,
  //   required int currencyId,
  //   required int countryId,
  //   required DateTime startDate,
  //   required DateTime endDate,
  //   required DateTime applicationDeadline,
  //   required int maxParticipants,
  //   required String location,
  //   required String category,
  //   required List<String> targetAudience,
  //   required String deliverables,
  //   required String brandGuidelines,
  //   required List<Map<String, dynamic>> requirements,
  // }) async {
  //   try {
  //     final response = await _dio.post(
  //       'campaigns/',
  //       data: {
  //         'title': title,
  //         'description': description,
  //         'budget_min': budgetMin,
  //         'budget_max': budgetMax,
  //         'currency_id': currencyId,
  //         'country_id': countryId,
  //         'start_date': startDate,
  //         'end_date': endDate,
  //         'application_deadline': applicationDeadline,
  //         'max_participants': maxParticipants,
  //         'location': location,
  //         'category': category,
  //         'target_audience': targetAudience,
  //         'deliverables': deliverables,
  //         'brand_guidelines': brandGuidelines,
  //         'requirements': requirements,
  //       },
  //     );
  //     return Campaign.fromJson(response.data);
  //   } on DioException catch (e) {
  //     throw _handleError(e);
  //   }
  // }

  // // update campaigns
  // Future<Campaign> updateCampaign({
  //   required int id,
  //   required String? title,
  //   required String? description,
  //   required String? budgetMin,
  //   required String? budgetMax,
  //   required int? currencyId,
  //   required int? countryId,
  //   required DateTime? startDate,
  //   required DateTime? endDate,
  //   required DateTime? applicationDeadline,
  //   required int? maxParticipants,
  //   required String? location,
  //   required String? category,
  //   required List<String>? targetAudience,
  //   required String? deliverables,
  //   required String? brandGuidelines,
  //   required List<Map<String, dynamic>>? requirements,
  //   String? status,
  // }) async {
  //   try {
  //     final data = <String, dynamic>{};
  //     if (title != null) data['title'] = title;
  //     if (description != null) data['desciprition'] = description;
  //     if (budgetMin != null) data['budget_min'] = budgetMin;
  //     if (budgetMax != null) data['budget_max'] = budgetMax;
  //     if (currencyId != null) data['currency_id'] = currencyId;
  //     if (countryId != null) data['country_id'] = countryId;
  //     if (startDate != null) data['start_date'] = startDate.toIso8601String();
  //     if (endDate != null) data['end_date'] = endDate.toIso8601String();
  //     if (applicationDeadline != null) {
  //       data['application_deadline'] = applicationDeadline.toIso8601String();
  //     }
  //     if (maxParticipants != null) data['max_participants'] = maxParticipants;
  //     if (location != null) data['location'] = location;
  //     if (category != null) data['category'] = category;
  //     if (targetAudience != null) data['target_audience'] = targetAudience;
  //     if (deliverables != null) data['deliverables'] = deliverables;
  //     if (brandGuidelines != null) data['brand_guidelines'] = brandGuidelines;
  //     if (requirements != null) data['requirements'] = requirements;
  //     if (status != null) data['status'] = status;

  //     final response = await _dio.put('campaigns/$id', data: data);
  //     return Campaign.fromJson(response.data);
  //   } on DioException catch (e) {
  //     throw _handleError(e);
  //   }
  // }

  // // delete campaign
  // Future<void> deleteCampaign(int id) async {
  //   try {
  //     await _dio.delete('campaigns/$id');
  //   } on DioException catch (e) {
  //     throw _handleError(e);
  //   }
  // }

  // // get my campaigns

  // // get my status

  // handleError
  Exception _handleError(DioException e) {
    if (e.response != null) {
      throw Exception(
        e.response?.data['message'] ?? 'Failed to load campaigns',
      );
    } else {
      throw Exception('Network error. Please check your connection');
    }
  }
}

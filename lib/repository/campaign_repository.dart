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
      print("Fetched campaigns raw data: ${response.data}");
      print("Parsed campaigns: ${data.length}");
      final result = data
          .map((json) => Campaign.fromJson(json as Map<String, dynamic>))
          .toList();
      print("Resulting campaign count: ${result.length}");
      return result;
    } on DioException catch (e, stackTrace) {
      print("❌ DioException in getAllCampaigns: ${e.message}");
      print("🔍 Stack trace:\n$stackTrace");
      throw _handleError(e);
    } catch (e, stackTrace) {
      print("💥 Unexpected error in getAllCampaigns: $e");
      print("🔍 Stack trace:\n$stackTrace");
      rethrow;
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

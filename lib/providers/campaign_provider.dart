import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:temuin_app/models/campaigns/campaign.dart';
import 'package:temuin_app/providers/dio_provider.dart';
import 'package:temuin_app/repository/campaign_repository.dart';
import 'package:temuin_app/state/campaign_state.dart';

final campaignRepositoryProvider = Provider<CampaignRepository>((ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return CampaignRepository(dio);
});

class CampaignNotifier extends StateNotifier<CampaignState> {
  CampaignNotifier(this._repository) : super(const CampaignState());

  final CampaignRepository _repository;

  // provide all campaigns
  Future<void> loadCampaigns() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final campaigns = await _repository.getAllCampaigns();
      state = CampaignState(campaigns: campaigns, isLoading: false);
    } catch (e) {
      state = CampaignState(isLoading: false, errorMessage: e.toString());
      print(e.toString());
    }
  }

  // provide one campaign detail
  Future<void> loadCampaignDetail(int id) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final campaign = await _repository.getOneCampaign(id);
      state = CampaignState(selectedCampaign: campaign, isLoading: false);
    } catch (e) {
      state = CampaignState(isLoading: false, errorMessage: e.toString());
    }
  }

  // apply campaign
  Future<bool> applyCampaign(int campaignId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.applyCampaign(campaignId);
      await loadCampaigns();
      return true;
    } catch (e) {
      state = CampaignState(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }
}

final campaignProvider = StateNotifierProvider<CampaignNotifier, CampaignState>(
  (ref) {
    final repository = ref.watch(campaignRepositoryProvider);
    return CampaignNotifier(repository);
  },
);

final campaignListsProvider = Provider<List<Campaign>>((ref) {
  return ref.watch(campaignProvider).campaigns;
});

final selectedCampaignProvider = Provider<Campaign?>((ref) {
  return ref.watch(campaignProvider).selectedCampaign;
});

// // later, not developed yet
// class BrandCampaignNotifier extends StateNotifier<CampaignState> {
//   BrandCampaignNotifier(this._repository) : super(const CampaignState());

//   final CampaignRepository _repository;
// }

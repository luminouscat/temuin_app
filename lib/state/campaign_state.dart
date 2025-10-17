import 'package:temuin_app/models/campaigns/campaign.dart';

class CampaignState {
  const CampaignState({
    this.campaigns = const <Campaign>[],
    this.selectedCampaign,
    this.isLoading = false,
    this.errorMessage,
  });

  final List<Campaign> campaigns;
  final Campaign? selectedCampaign;
  final bool isLoading;
  final String? errorMessage;

  // // getters
  // bool get hasCampaigns => campaigns.isNotEmpty;
  // bool get hasError => errorMessage != null;

  // copywith
  CampaignState copyWith({
    List<Campaign>? campaigns,
    Campaign? selectedCampaign,
    bool? isLoading,
    String? errorMessage,
    bool clearSelectedCampaign = false,
  }) {
    return CampaignState(
      campaigns: campaigns ?? this.campaigns,
      selectedCampaign: clearSelectedCampaign
          ? null
          : selectedCampaign ?? this.selectedCampaign,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  // clear error state
  CampaignState clearError() {
    return CampaignState(
      campaigns: campaigns,
      selectedCampaign: selectedCampaign,
      isLoading: isLoading,
      errorMessage: null,
    );
  }
}

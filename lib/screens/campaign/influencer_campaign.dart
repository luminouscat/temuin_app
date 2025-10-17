import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temuin_app/providers/campaign_provider.dart';
import 'package:temuin_app/shared/styled_cards.dart';
import 'package:temuin_app/state/campaign_state.dart';

class InfluencerCampaign extends ConsumerStatefulWidget {
  const InfluencerCampaign({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InfluencerCampaignState();
}

class _InfluencerCampaignState extends ConsumerState<InfluencerCampaign> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(campaignProvider.notifier).loadCampaigns();
    });
  }

  @override
  Widget build(BuildContext context) {
    final campaignState = ref.watch(campaignProvider);
    print('Campaign state in campaign screen: $campaignState ');

    ref.listen(campaignProvider, (prev, next) {
      if (next.errorMessage != null) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("There's an error!"),
              content: Text(next.errorMessage!),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok"),
                ),
              ],
            );
          },
        );
      }
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // search bolck
            Container(
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(Icons.search),
            ),
            const SizedBox(height: 25),
            Expanded(child: _buildBody(campaignState, ref)),
          ],
        ),
      ),
    );
  }
}

Widget _buildBody(CampaignState campaignState, WidgetRef ref) {
  if (campaignState.isLoading) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  if (campaignState.campaigns.isEmpty) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Icon(Icons.campaign_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('No campaigns available'),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                ref.read(campaignProvider.notifier).loadCampaigns();
              },
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
  return ListView.builder(
    itemCount: campaignState.campaigns.length,
    itemBuilder: (context, index) {
      final campaign = campaignState.campaigns[index];
      return HomeCampaignCard(
        title: campaign.title,
        brand: campaign.owner.name,
        deadline: campaign.deadlineText,
        onTap: () {},
      );
    },
  );
}

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temuin_app/models/user.dart';
import 'package:temuin_app/providers/auth_provider.dart';
import 'package:temuin_app/providers/campaign_provider.dart';
import 'package:temuin_app/screens/auth/login.dart';
import 'package:temuin_app/screens/campaign/influencer_campaign.dart';
import 'package:temuin_app/shared/styled_cards.dart';
import 'package:temuin_app/state/campaign_state.dart';
import 'package:temuin_app/theme.dart';

class InfluencerHome extends ConsumerStatefulWidget {
  const InfluencerHome({super.key});

  @override
  ConsumerState<InfluencerHome> createState() => _InfluencerHomeState();
}

class _InfluencerHomeState extends ConsumerState<InfluencerHome> {
  int _bottomNavIndex = -1;

  final List<IconData> iconLists = [
    Icons.analytics_outlined,
    Icons.work,
    Icons.post_add_sharp,
    Icons.message,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _bottomNavIndex = -1;
          });
        },
        backgroundColor: _bottomNavIndex == -1 ? Colors.blue : Colors.grey,
        child: Icon(Icons.home),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconLists.length,
        tabBuilder: (int index, bool isActive) {
          Widget icon = Icon(
            iconLists[index],
            size: 24,
            color: isActive ? Colors.blue : Colors.grey,
          );

          if (index == 3) {
            return Center(
              child: Badge(
                label: Text('6'),
                backgroundColor: Colors.red,
                child: icon,
              ),
            );
          }
          return Center(child: icon);
        },
        activeIndex: _bottomNavIndex == -1 ? 5 : _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() {
          _bottomNavIndex = index;
        }),
      ),
      body: SafeArea(child: _getBodyWidget(_bottomNavIndex, context, ref)),
    );
  }
}

Widget _getBodyWidget(int index, BuildContext context, WidgetRef ref) {
  // Use keys to maintain widget state when switching
  switch (index) {
    case -1:
      return HomeScreen(key: UniqueKey());
    case 0:
      return Container(key: UniqueKey(), child: Text("Analytics"));
    case 1:
      return InfluencerCampaign(key: UniqueKey());
    case 2:
      return Container(key: UniqueKey(), child: Text("Portofolio"));
    case 3:
      return Container(key: UniqueKey(), child: Text("Message"));
    default:
      return HomeScreen(key: UniqueKey());
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(campaignProvider.notifier).loadCampaigns();
    });
  }

  // mock grid
  final List<Map<String, dynamic>> gridItems = [
    {
      'icon': Icons.remove_red_eye_sharp,
      'label': 'Views',
      'color': CustomColors.primaryPurple,
    },
    {
      'icon': Icons.work,
      'label': 'Opportunities',
      'color': CustomColors.darkPrimaryColor,
    },
    {
      'icon': Icons.attach_money,
      'label': 'Earnings',
      'color': CustomColors.primaryGreen,
    },
    {
      'icon': Icons.chat,
      'label': 'Response rate',
      'color': CustomColors.primaryYellow,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // user from provider
    final user = ref.watch(currentUserProvider);
    final campaignState = ref.watch(campaignProvider);
    print('Campaign state: ${campaignState.campaigns} ');

    ref.listen(authProvider, (prev, next) {
      if (!next.isAuthenticated && mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => Login()),
          (route) => false,
        );
      }
    });

    ref.listen(campaignProvider, (prev, next) {
      if (next.errorMessage != null) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("There's an error in the campaign!"),
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

    void _handleLogout(WidgetRef ref) {
      ref.read(authProvider.notifier).logout();
    }

    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(child: _buildHeader(user)),

        // Gridview
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: _buildGrid(gridItems),
        ),

        // List view header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Available Campaigns',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                // temp logout button
                TextButton(
                  onPressed: () {
                    _handleLogout(ref);
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // List view
        _buildCampaignsList(campaignState, ref),
      ],
    );
  }
}

Widget _buildHeader(User? user) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              width: 60,
              height: 60,
              child: GestureDetector(
                onTap: () {},
                child: Image.asset('assets/images/default_pfp.jpg'),
              ),
            ),
            const SizedBox(width: 12),

            // user info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hello,",
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
                Text(
                  user?.name ?? 'No name',
                  style: const TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        // action buttons
        IconButton(
          onPressed: () {},
          icon: Badge(
            label: Text('5'),
            child: Icon(
              Icons.notifications,
              color: CustomColors.darkPrimaryColor,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildGrid(dynamic items) {
  return SliverGrid(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.2,
    ),
    delegate: SliverChildBuilderDelegate((context, index) {
      final item = items[index];
      return HomeGridCard(
        onTap: () {},
        titleText: item['label'] as String,
        icon: item['icon'] as IconData,
        color: item['color'] as Color,
      );
    }, childCount: 4),
  );
}

Widget _buildCampaignsList(CampaignState campaignState, WidgetRef ref) {
  if (campaignState.isLoading) {
    return const SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  if (campaignState.campaigns.isEmpty) {
    return SliverToBoxAdapter(
      child: Center(
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
      ),
    );
  }
  return SliverPadding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    sliver: SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final campaign = campaignState.campaigns[index];
          return HomeCampaignCard(
            title: campaign.title,
            brand: campaign.owner.name,
            deadline: campaign.deadlineText,
            onTap: () {},
          );
        },
        childCount: campaignState.campaigns.length > 5
            ? 5
            : campaignState.campaigns.length,
      ),
    ),
  );
}

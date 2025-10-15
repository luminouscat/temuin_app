import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temuin_app/providers/auth_provider.dart';
import 'package:temuin_app/screens/login/login.dart';
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
      body: SafeArea(child: _getBodyWidget(_bottomNavIndex)),
    );
  }
}

Widget _getBodyWidget(int index) {
  switch (index) {
    case -1:
      return HomeScreen();
    case 0:
      return Container(child: Text("Analytics"));
    case 1:
      return Container(child: Text("Campaign"));
    case 2:
      return Container(child: Text("Portofolio"));
    case 3:
      return Container(child: Text("Message"));
    default:
      return HomeScreen();
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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

  // mock campaign data
  final List<Map<String, dynamic>> mockCampaigns = [
    {
      'title': 'Summer Fashion Campaign',
      'brand': 'Fashion Brand Co.',
      'budget': '\$500',
      'deadline': '2 days left',
    },
    {
      'title': 'Tech Product Review',
      'brand': 'Tech Gadgets Inc.',
      'budget': '\$800',
      'deadline': '5 days left',
    },
    {
      'title': 'Food & Beverage Promo',
      'brand': 'Tasty Foods',
      'budget': '\$350',
      'deadline': '1 week left',
    },
    {
      'title': 'Travel Vlog Collab',
      'brand': 'Travel Agency',
      'budget': '\$1200',
      'deadline': '3 days left',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // user from provider
    final user = ref.watch(currentUserProvider);
    print(user!.uid);
    // logout
    ref.listen(authProvider, (prev, next) {
      if (!next.isAuthenticated && mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => Login()),
          (route) => false,
        );
      }
    });

    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
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
                      child: Image.asset('assets/images/default_pfp.jpg'),
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
                          user.name,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // action buttons
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Clicked!"),
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
                  },
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
          ),
        ),

        // Gridview
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = gridItems[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Clicked!"),
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
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Text(
                              item['label'] as String,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              item['icon'] as IconData,
                              size: 25,
                              color: item['color'] as Color,
                            ),
                          ],
                        ),
                        Text("Random numbers"),
                        Text("Random icon"),
                      ],
                    ),
                  ),
                ),
              );
            }, childCount: 4),
          ),
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
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Clicked!"),
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
                  },
                  child: const Text('See All'),
                ),
              ],
            ),
          ),
        ),

        // List view
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final campaign = mockCampaigns[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Clicked!"),
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
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.blue.withAlpha(10),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.work,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                campaign['title']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                campaign['brand']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.yellowAccent.withAlpha(25),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  campaign['deadline']!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }, childCount: mockCampaigns.length),
          ),
        ),
      ],
    );
  }
}

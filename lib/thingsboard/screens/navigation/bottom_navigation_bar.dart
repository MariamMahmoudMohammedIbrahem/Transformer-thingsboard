import '../../commons.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 1;
  final List<Widget> _screens = [
    const RealtimeGraphScreen(),
    const DashboardScreen(),
    const SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.transparent,
        color: MyColors.blueDark,
        buttonBackgroundColor: Colors.transparent,
        height: 60,
        items: const [
          Icon(Icons.auto_graph_rounded),
          Icon(Icons.hub_outlined),
          Icon(Icons.settings_rounded),
        ],
      ),
    );
  }
}

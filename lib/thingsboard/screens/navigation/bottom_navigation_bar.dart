/*

import '../../commons.dart';

class NavigationController extends GetxController {
  Rx<int> selectedIndex = 1.obs;

  final screens = [
    const HistoryScreen(),
    const DashboardScreen(),
    const SettingsScreen(),
  ];
}

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          shadowColor: Colors.grey,
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => {
            controller.selectedIndex.value = index,
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.history_toggle_off),
              label: 'History',
            ),
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_rounded),
              label: 'Settings',
            ),
          ],
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.screens,
        ),
      ),
    );
  }
}
*/


import '../../commons.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 1;
  final List<Widget> _screens = [
    // const HistoricalGraphScreen(),
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
        color: const Color(0xFF305680),
        buttonBackgroundColor: Colors.transparent,
        height: 60,
        items: const [
          // Icon(Icons.history_toggle_off),
          Icon(Icons.auto_graph_rounded),
          Icon(Icons.hub_outlined),
          Icon(Icons.settings_rounded),
        ],
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (newIndex){
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history_toggle_off),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hub_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),*/
    );
  }
}

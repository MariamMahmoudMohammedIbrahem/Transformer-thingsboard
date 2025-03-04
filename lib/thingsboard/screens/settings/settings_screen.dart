import '../../commons.dart';

part 'settings_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  createState() => _SettingsScreen();
}

class _SettingsScreen extends SettingsController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text(
              'Dark Theme',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.blueDark,
              ),
            ),
            trailing: Consumer<AppProvider>(
              builder: (context, darkLight, child) {
                return Switch(
                    value: darkLight.isDarkMode,
                    onChanged: (value) {
                      darkLight.setTheme(value);
                    });
              },
            ),
          ),
          ListTile(
            title: const Text(
              'Notifications',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.blueDark,
              ),
            ),
            trailing: Switch(
                value: notificationEnable,
                onChanged: (value) {
                  controlNotification();
                },
            ),
          ),
          ListTile(
            title: const Text(
              'LogOut',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.blueDark,
              ),
            ),
            trailing: const Icon(Icons.logout_rounded, color: MyColors.blueDark),
            onTap: logOut,
          ),
        ],
      ),
    );
  }
}
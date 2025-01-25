/*


import '../commons.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(
              0xFF305680,
            ),
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
                color: Color(
                  0xFF305680,
                ),
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
              'LogOut',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(
                  0xFF305680,
                ),
              ),
            ),
            trailing: const Icon(Icons.logout_rounded, color: Color(0xFF305680),),
            onTap: () {
              tbClient.logout();
            },
          ),
        ],
      ),
    );
  }
}
*/

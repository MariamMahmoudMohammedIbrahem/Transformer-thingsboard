
import '../commons.dart';
// Custom Light Theme

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF305680),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF305680),
    secondary: Color(0xFF305680),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF305680),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  textTheme: TextTheme(
    bodyMedium: const TextStyle(color: Color(0xFF305680), fontSize: 14),
    bodySmall: TextStyle(color: Colors.grey[700]),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(const Color(0xFF305680)),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return const Color(0xFF305680).withOpacity(0.5);
      }
      return Colors.grey.shade300;
    }),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Color(0xFF305680),),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: const Color(0xFF4A6380),
      backgroundColor: const Color(0xFF164980),
      disabledForegroundColor: const Color(0xFF164980),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
);

// Custom Dark Theme
/*ThemeData darkTheme = ThemeData(
  // brightness: Brightness.dark,
  primaryColor: const Color(0xFF305680),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF305680),
    onPrimary: Colors.black,
    secondary: Color(0xFF305680),
  ),
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    titleTextStyle: TextStyle(color: Colors.grey, fontSize: 20),
  ),
  textTheme: TextTheme(
    bodyMedium: const TextStyle(color: Color(0xFF305680), fontSize: 14),
    bodySmall: TextStyle(color: Colors.grey[300]),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black12,
  ),
);*/
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF305680),
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF305680),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(const Color(0xFF305680)),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return const Color(0xFF305680).withOpacity(0.5);
      }
      return Colors.grey;
    }),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Color(0xFF305680),),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: const Color(0xFF4A6380),
      backgroundColor: const Color(0xFF164980),
      disabledForegroundColor: const Color(0xFF164980),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
);
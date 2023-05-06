import 'package:exp_parking/provider/approved_list_provider.dart';
import 'package:exp_parking/provider/available_Slot_count_provider.dart';
import 'package:exp_parking/provider/login_provider.dart';
import 'package:exp_parking/provider/schedule_by_id_provider.dart';
import 'package:exp_parking/provider/schedule_list_provider.dart';
import 'package:exp_parking/provider/schedule_provider.dart';
import 'package:exp_parking/provider/signup_provider.dart';
import 'package:exp_parking/provider/update_AvailableSlout_provider.dart';
import 'package:exp_parking/provider/update_schedule_provider.dart';
import 'package:exp_parking/provider/user_schedule_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
        ChangeNotifierProvider(create: (_) => ScheduleListProvider()),
        ChangeNotifierProvider(create: (_) => UserScheduleListProvider()),
        ChangeNotifierProvider(create: (_) => ScheduleById()),
        ChangeNotifierProvider(create: (_) => UpdateScheduleProvider()),
        ChangeNotifierProvider(create: (_) => ApprovedListProvider()),
        ChangeNotifierProvider(create: (_) => AvailableSlotCountProvider()),
        ChangeNotifierProvider(
            create: (_) => UpdateAvailableSloutCountProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

ColorScheme defaultColorScheme = const ColorScheme(
  primary: Color(0xffff6666),
  secondary: Color(0xff03DAC6),
  surface: Color(0xff181818),
  background: Color(0xff121212),
  error: Color(0xffCF6679),
  onPrimary: Color(0xff000000),
  onSecondary: Color(0xff000000),
  onSurface: Color(0xffffffff),
  onBackground: Color(0xffffffff),
  onError: Color(0xff000000),
  brightness: Brightness.dark,
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: defaultColorScheme,
      ),
      // home: const LoginPage(title: 'Login UI'),
      home: const LoginPage(),
      // routes: {
      //   '/': (context) => const LoginPage(),
      //   '/register': (context) => const RegisterPage()
      // },
    );
  }
}

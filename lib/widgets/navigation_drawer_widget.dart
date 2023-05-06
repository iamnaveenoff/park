import 'package:exp_parking/screens/home_screen.dart';
import 'package:exp_parking/screens/login_screen.dart';
import 'package:exp_parking/screens/admin%20Screens/request_screen.dart';
import 'package:exp_parking/screens/moderator%20screen/approved_list_screen.dart';
import 'package:exp_parking/screens/schedule_screen.dart';
import 'package:exp_parking/screens/status_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawerWidget extends StatefulWidget {
  NavigationDrawerWidget({super.key});

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  bool? isAdmin;
  bool? isModerator;
  String? username;

  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  void initState() {
    getDetails().whenComplete(() {
      setState(() {});
    });
    super.initState();
  }

  getDetails() async {
    final prefs = await SharedPreferences.getInstance();
    isAdmin = prefs.getBool('isAdmin');
    isModerator = prefs.getBool('isModerator');
    username = prefs.getString('username');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.black,
        child: ListView(
          children: <Widget>[
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Home',
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Schedule Parking',
                    icon: Icons.update,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Check Status',
                    icon: Icons.info,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 24),
                  if (isAdmin ?? true) ...[
                    // const Divider(color: Colors.white70),
                    const Text(
                      'ADMIN',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    buildMenuItem(
                      text: 'Parking Request',
                      icon: Icons.read_more,
                      onClicked: () => selectedItem(context, 4),
                    ),
                  ],
                  if (isModerator ?? true) ...[
                    // const Divider(color: Colors.white70),
                    const SizedBox(height: 10),
                    const Text(
                      'MODERATOR',
                      style: TextStyle(
                          color: Colors.yellow, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    buildMenuItem(
                      text: 'Approved Request',
                      icon: Icons.read_more,
                      onClicked: () => selectedItem(context, 5),
                    ),
                  ],
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.logout,
                    onClicked: () => selectedItem(context, 3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  Future<void> selectedItem(BuildContext context, int index) async {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ScheduleScreen(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StatusPage(
            username: username!,
          ),
        ));
        break;
      case 3:
        final prefs = await SharedPreferences.getInstance();
        prefs.clear();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RequestScreen(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ApprovedListScreen(),
        ));
        break;
    }
  }
}

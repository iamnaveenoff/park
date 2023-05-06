import 'package:exp_parking/model/home_model.dart';
import 'package:exp_parking/screens/admin%20Screens/request_screen.dart';
import 'package:exp_parking/screens/moderator%20screen/approved_list_screen.dart';
import 'package:exp_parking/screens/schedule_screen.dart';
import 'package:exp_parking/screens/status_screen.dart';
import 'package:exp_parking/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedService = -1;
  String? name;
  String? username;
  bool? isAdmin;
  bool? isModerator;
  @override
  void initState() {
    getDetails().whenComplete(() {
      setState(() {});
    });
    super.initState();
  }

  getDetails() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    username = prefs.getString('username');
    isAdmin = prefs.getBool('isAdmin');
    isModerator = prefs.getBool('isModerator');
  }

  DateTime? currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    List<Home> homeNavigation = [
      Home('Schedule', 'images/Schedule.svg'),
      Home('Check Status', 'images/Status.svg'),
      if (isAdmin ?? true) ...[
        Home('Requests', 'images/Request.svg'),
      ],
      if (isModerator ?? true) ...[
        Home('Approved List', 'images/Approve.svg'),
      ],
    ];
    Future<bool> onWillPop() async {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Double Tab to close the App',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey,
        ));
        return Future.value(false);
      }
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      return Future.value(true);
    }

    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          drawer: NavigationDrawerWidget(),
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            foregroundColor: Colors.black,
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, right: 20.0, left: 20.0),
                    child: Text(
                      'Welcome \n $name',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                      ),
                      itemCount: homeNavigation.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return homeContainer(homeNavigation[index].imageURL,
                            homeNavigation[index].name, index);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectedItem(BuildContext context, int index) async {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ScheduleScreen(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StatusPage(
            username: username!,
          ),
        ));
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RequestScreen(),
          ),
        );
        break;
      case 3:
        final prefs = await SharedPreferences.getInstance();
        prefs.clear();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ApprovedListScreen(),
        ));
        break;
    }
  }

  homeContainer(String image, String name, int index) {
    return GestureDetector(
      onTap: () {
        selectedItem(context, index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          border: Border.all(
            color: Colors.purple,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image.network(image, height: 80),
            SvgPicture.asset(image, width: 100, height: 100),
            const SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

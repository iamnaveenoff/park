import 'package:exp_parking/provider/user_schedule_list_provider.dart';
import 'package:exp_parking/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatefulWidget {
  final String username;
  StatusPage({Key? key, required this.username}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  void initState() {
    var fetchData =
        Provider.of<UserScheduleListProvider>(context, listen: false);
    fetchData.getAllUserScheduleListData(widget.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<UserScheduleListProvider>()
        .getAllUserScheduleListData(widget.username);
    return SafeArea(
      child: Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Status'),
          centerTitle: true,
        ),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: Center(
            child: Consumer<UserScheduleListProvider>(
              builder: (context, value, child) {
                return value.scheduleList.isEmpty
                    ? const CircularProgressIndicator()
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.builder(
                          itemCount: value.scheduleList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                textColor: Colors.black,
                                tileColor: Colors.white,
                                trailing: Text(
                                  value.scheduleList[index].status!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: (value
                                                  .scheduleList[index].status ==
                                              'Pending'
                                          ? Colors.deepPurple
                                          : value.scheduleList[index].status ==
                                                  'Rejected'
                                              ? Colors.red
                                              : Colors.green)),
                                ),
                                title: Text(
                                  '\n${value.scheduleList[index].username!}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    '${value.scheduleList[index].email!}\n${value.scheduleList[index].scheduledDate}\n'),
                                onTap: () {},
                              ),
                            );
                          },
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    await context
        .read<UserScheduleListProvider>()
        .getAllUserScheduleListData(widget.username);

    setState(() {});
  }
}

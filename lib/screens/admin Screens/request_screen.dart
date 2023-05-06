import 'dart:ui';

import 'package:exp_parking/provider/schedule_list_provider.dart';
import 'package:exp_parking/screens/admin%20Screens/update_request.dart';
import 'package:exp_parking/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatefulWidget {
  RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  void initState() {
    var fetchData = Provider.of<ScheduleListProvider>(context, listen: false);
    fetchData.getAllScheduleListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ScheduleListProvider>().getAllScheduleListData();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text("Parking Requests"),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: Center(
            child: Consumer<ScheduleListProvider>(
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
                                        color:
                                            (value.scheduleList[index].status ==
                                                    'Pending'
                                                ? Colors.deepPurple
                                                : value.scheduleList[index]
                                                            .status ==
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
                                  onTap: () async {
                                    String refresh = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdateRequest(
                                          scheduleListModel:
                                              (value.scheduleList[index]),
                                        ),
                                      ),
                                    );
                                    if (refresh == 'refresh') {
                                      _onRefresh();
                                    }
                                  },
                                ),
                              );
                            }),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    // await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    await context.read<ScheduleListProvider>().getAllScheduleListData();

    setState(() {});
  }
}

import 'package:exp_parking/model/schedule_list_model.dart';
import 'package:exp_parking/model/schedule_model.dart';
import 'package:exp_parking/provider/update_schedule_provider.dart';
import 'package:exp_parking/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateRequest extends StatefulWidget {
  ScheduleListModel? scheduleListModel;
  UpdateRequest({Key? key, this.scheduleListModel}) : super(key: key);

  @override
  State<UpdateRequest> createState() => _UpdateRequestState();
}

class _UpdateRequestState extends State<UpdateRequest> {
  String? message;

  String? loggedinUser;
  TextEditingController statusController = TextEditingController();
  TextEditingController empIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController scheduleController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  @override
  void initState() {
    super.initState();
    empIdController.text = widget.scheduleListModel!.username!;
    emailController.text = widget.scheduleListModel!.email!;
    scheduleController.text = widget.scheduleListModel!.scheduledDate!;
    statusController.text = widget.scheduleListModel?.status == ""
        ? widget.scheduleListModel!.status = "Pending"
        : widget.scheduleListModel!.status!;
    getloggedinuserdetails();
  }

  getloggedinuserdetails() async {
    final prefs = await SharedPreferences.getInstance();
    loggedinUser = prefs.getString('username');
  }

  Future<void> _updateSchedule() async {
    String remarks = remarksController.text.trim();
    String status = statusController.text.trim();
    ScheduleModel updateSchedule = ScheduleModel(
        remarks: remarks, status: status, updatedBy: loggedinUser);
    print(updateSchedule.updatedBy);
    var provider = Provider.of<UpdateScheduleProvider>(context, listen: false);
    await provider
        .updateScheduleById(widget.scheduleListModel!.id, updateSchedule)
        .then((value) => message = value);
    if (provider.isBack) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Success: $message',
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ));
      // ignore: use_build_context_synchronously
      Navigator.pop(context, 'refresh');
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Error: $message',
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    const List<String> statusList = <String>['Pending', 'Approved', 'Rejected'];
    String statusValue = widget.scheduleListModel!.status!;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, 'refresh');
          return true;
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          drawer: NavigationDrawerWidget(),
          appBar: AppBar(
            title: const Text("Update Schedule Request"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: empIdController,
                    style: const TextStyle(color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      hintStyle: const TextStyle(color: Colors.black),
                      hintText: 'Emp Id',
                      prefixIcon: const Icon(Icons.person, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: emailController,
                    style: const TextStyle(color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      hintStyle: const TextStyle(color: Colors.black),
                      hintText: 'Email Id',
                      prefixIcon: const Icon(Icons.email, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: scheduleController,
                    style: const TextStyle(color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      hintStyle: const TextStyle(color: Colors.black),
                      hintText: 'Schedule Date',
                      prefixIcon:
                          const Icon(Icons.calendar_month, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.white,
                    value: statusValue,
                    icon: const Icon(Icons.arrow_downward, color: Colors.black),
                    style: const TextStyle(color: Colors.black),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        statusValue = value!;
                        statusController.text = value;
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items: statusList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: remarksController,
                    style: const TextStyle(color: Colors.black),
                    maxLines: 1,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      hintStyle: const TextStyle(color: Colors.black),
                      hintText: 'Remarks',
                      prefixIcon:
                          const Icon(Icons.note_add, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 43, vertical: 20),
                    ),
                    child: const Text(
                      'UPDATE',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _updateSchedule();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

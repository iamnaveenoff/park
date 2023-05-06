import 'package:awesome_calendar/awesome_calendar.dart';
import 'package:exp_parking/model/available_slot_model.dart';
import 'package:exp_parking/model/schedule_model.dart';
import 'package:exp_parking/provider/available_Slot_count_provider.dart';
import 'package:exp_parking/provider/schedule_provider.dart';
import 'package:exp_parking/screens/home_screen.dart';
import 'package:exp_parking/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleScreen extends StatefulWidget {
  ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final GlobalKey<FormState> _scheduleScreen = GlobalKey<FormState>();

  String? message;
  int? availableSlotCount;
  List<DateTime>? multiOrRangeSelect;
  DateTime? singleSelect;
  String? loggedinUser;
  TextEditingController empIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController scheduleController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(DateTime.now());
    final prefs = await SharedPreferences.getInstance();
    loggedinUser = prefs.getString('username');
    empIdController.text = loggedinUser!;
    emailController.text = prefs.getString('email')!;
    phoneController.text = prefs.getString('phone')!;
    scheduleController.text = formatted;
    availableSlotCount = prefs.getInt('availableSlot');
    print(availableSlotCount);
    final data =
        Provider.of<AvailableSlotCountProvider>(context, listen: false);
    data.fetchData(context);
  }

  Future<void> _saveSchedule() async {
    // print(availableSlotCount as int);
    String username = empIdController.text.trim();
    String email = emailController.text.trim();
    String scheduleDate = scheduleController.text.trim();
    String remarks = remarksController.text.trim();
    String phone = phoneController.text.trim();
    ScheduleModel saveSchedule = ScheduleModel(
        username: username,
        email: email,
        scheduledDate: scheduleDate,
        createdBy: loggedinUser,
        phoneNumber: phone,
        remarks: remarks);
    AvailableSlotCountModel updateAvailableSlotCount = AvailableSlotCountModel(
        availableSlotCount: availableSlotCount.toString());
    var provider = Provider.of<ScheduleProvider>(context, listen: false);
    await provider.scheduleData(saveSchedule).then((value) => message = value);
    if (provider.isBack) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Success: $message',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
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
    final data = Provider.of<AvailableSlotCountProvider>(context);
    // availableSlotCount = data.dataModel.availableSlotCount;
    return SafeArea(
      child: Scaffold(
        drawer: NavigationDrawerWidget(),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        appBar: AppBar(
          title: const Text("Schedule Parking"),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _scheduleScreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${data.dataModel.availableSlotCount} / ${data.dataModel.providedSlotCount}',
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Parking Schedule Form',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      readOnly: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: empIdController,
                      autofocus: true,
                      style: const TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your EmpId';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[300],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintStyle: const TextStyle(color: Colors.black),
                        hintText: 'Enter Your EMP ID',
                        prefixIcon:
                            const Icon(Icons.person, color: Colors.black),
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      style: const TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email Id';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[300],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintStyle: const TextStyle(color: Colors.black),
                        hintText: 'Enter Your Email',
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onTap: () async {
                        final DateTime? picked = await showDialog<DateTime>(
                          context: context,
                          builder: (BuildContext context) {
                            return const AwesomeCalendarDialog(
                              selectionMode: SelectionMode.single,
                            );
                          },
                        );
                        if (picked != null) {
                          setState(() {
                            singleSelect = picked;
                            final DateFormat formatter =
                                DateFormat('dd-MM-yyyy');
                            final String formatted =
                                formatter.format(singleSelect!);
                            scheduleController.text = formatted;
                          });
                        }
                      },
                      controller: scheduleController,
                      style: const TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid Date';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintStyle: const TextStyle(color: Colors.black),
                        hintText: 'Enter Your Schedule',
                        prefixIcon: const Icon(Icons.calendar_month,
                            color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneController,
                      style: const TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Phone Number';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintStyle: const TextStyle(color: Colors.black),
                        hintText: 'Phone Number',
                        prefixIcon:
                            const Icon(Icons.phone, color: Colors.black),
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
                        disabledForegroundColor: Colors.amber.withOpacity(0.38),
                        disabledBackgroundColor: Colors.amber.withOpacity(0.12),
                      ),
                      child: const Text(
                        'SCHEDULE',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_scheduleScreen.currentState!.validate()) {
                          _saveSchedule();
                        } else {
                          const Text("Sorry There is no Available Slot");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

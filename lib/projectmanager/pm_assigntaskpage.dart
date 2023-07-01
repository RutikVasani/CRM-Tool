import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AssignTaskPage extends StatefulWidget {
  final String team;
  final String idno;

  const AssignTaskPage({super.key, required this.team, required this.idno});

  @override
  State<AssignTaskPage> createState() => _AssignTaskPageState();
}

class _AssignTaskPageState extends State<AssignTaskPage> {
  String date = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String day = DateFormat.EEEE().format(DateTime.now());
  String AssignDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String DueDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String tasktime = DateFormat('dd-MM-yyyy').format(DateTime.now());

  late String student;
  late String task;
  late String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 250, 251),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 13, 110, 189),
        title: Text(
          "Assign Task",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, letterSpacing: 2),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 13, 110, 189),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "$date" + " - $day",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Student',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 16, 121, 174)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 16, 121, 174)),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onChanged: (value) {
                      student = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Task',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 16, 121, 174)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 16, 121, 174)),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onChanged: (value) {
                      task = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 16, 121, 174)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 16, 121, 174)),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Assign Date",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Color.fromARGB(255, 16, 121, 174)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime(2000, 1, 1),
                      maxTime: DateTime(2100, 12, 31),
                      onConfirm: (date) {
                        print('confirm $date');
                        AssignDate = '${date.day}/${date.month}/${date.year}';
                        setState(() {});
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 16, 121, 174)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AssignDate,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 16, 121, 174),
                                  fontSize: 18),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "  Change",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Due Date",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Color.fromARGB(255, 16, 121, 174)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      theme: const DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime(2000, 1, 1),
                      maxTime: DateTime(2100, 12, 31),
                      onConfirm: (date) {
                        print('confirm $date');
                        DueDate = '${date.day}/${date.month}/${date.year}';
                        setState(() {});
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 16, 121, 174)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              DueDate,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 16, 121, 174),
                                  fontSize: 18),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "  Change",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: InkWell(
                    onTap: () {
                      Map<String, dynamic> Assigntask = {
                        'Student': student,
                        'Task': task,
                        'Description': description,
                        'Assign Date': AssignDate,
                        'Due Date': DueDate,
                        'Progress': "Assign",
                      };
                      FirebaseFirestore.instance
                          .collection(widget.team)
                          .doc("Task")
                          .collection("Assign")
                          .doc()
                          .set(Assigntask);
                      FirebaseFirestore.instance
                          .collection(widget.team)
                          .doc("Task")
                          .collection("Task")
                          .doc()
                          .set(Assigntask);
                      FirebaseFirestore.instance
                          .collection("CLDC")
                          .doc(student)
                          .collection("Task")
                          .doc()
                          .set(Assigntask);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 110, 189),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TeamDailyReportPage extends StatefulWidget {
  final String idno;
  final String team;

  const TeamDailyReportPage(
      {super.key, required this.idno, required this.team});

  @override
  State<TeamDailyReportPage> createState() => _TeamDailyReportPageState();
}

class _TeamDailyReportPageState extends State<TeamDailyReportPage> {
  late String task;
  late String issue;
  late String solution;

  String date = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String day = DateFormat.EEEE().format(DateTime.now());
  String reporttime = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 250, 251),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 13, 110, 189),
        title: Text(
          "Daily Report",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, letterSpacing: 2),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 450,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
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
                    labelText: 'Issue',
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
                    issue = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Solution',
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
                    solution = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: InkWell(
                  onTap: () {
                    Map<String, dynamic> Report = {
                      'Task': task,
                      'Issue': issue,
                      'Solution': solution,
                      'Date': date,
                      'Day': day
                    };
                    FirebaseFirestore.instance
                        .collection(widget.team)
                        .doc("Report")
                        .collection("Report")
                        .doc(reporttime)
                        .collection(reporttime)
                        .doc(widget.idno)
                        .set(Report);
                    FirebaseFirestore.instance
                        .collection("CLDC")
                        .doc(widget.idno)
                        .collection("Report")
                        .doc(reporttime)
                        .set(Report);
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
    );
  }
}

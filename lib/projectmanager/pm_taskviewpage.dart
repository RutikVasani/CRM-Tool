import 'package:cldc/projectmanager/pm_assigntaskpage.dart';
import 'package:cldc/projectmanager/pm_dailyreport.dart';
import 'package:cldc/projectmanager/pm_report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PmTaskViewPage extends StatefulWidget {
  final String team;
  final String idno;
  const PmTaskViewPage({super.key, required this.team, required this.idno});

  @override
  State<PmTaskViewPage> createState() => _PmTaskViewPageState();
}

class _PmTaskViewPageState extends State<PmTaskViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 250, 251),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 13, 110, 189),
        title: Text(
          "Task View",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, letterSpacing: 2),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PmDailyReportPage(
                    team: widget.team,
                    idno: widget.idno,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.dataset,
              size: 30,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PmReportPage(
                      team: widget.team,
                      idno: widget.idno,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.data_saver_on_outlined,
                size: 35,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.output_rounded,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 13, 110, 189),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AssignTaskPage(
                team: widget.team,
                idno: widget.idno,
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.team)
            .doc("Task")
            .collection("Task")
            .orderBy('Assign Date', descending: true)
            .snapshots(),
        builder:
            (__, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (___, int index) {
                    Map<String, dynamic> docTaskData =
                        snapshot.data!.docs[index].data();
                    String uid = snapshot.data!.docs[index].id;
                    if (docTaskData.isEmpty) {
                      return const SizedBox(
                        child: Center(
                          child: Text("Document is Empty"),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  docTaskData["Student"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: Text(
                                  docTaskData["Task"],
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Row(
                                children: [
                                  Text(
                                    docTaskData["Assign Date"],
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    docTaskData["Progress"],
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return const SizedBox(width: 0, height: 0);
            }
          } else {
            return const Center(
                child: SizedBox(
              width: 200,
              height: 100,
              child: Center(
                child: Text(
                  "Work Done",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ));
          }
        },
      ),
    );
  }
}

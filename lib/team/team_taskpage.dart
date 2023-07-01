import 'package:cldc/team/team_dailyreportpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TeamTaskPage extends StatefulWidget {
  final String idno;
  final String team;

  const TeamTaskPage({super.key, required this.idno, required this.team});

  @override
  State<TeamTaskPage> createState() => _TeamTaskPageState();
}

class _TeamTaskPageState extends State<TeamTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 250, 251),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 13, 110, 189),
        title: Text(
          "Today Task",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, letterSpacing: 2),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TeamDailyReportPage(idno: widget.idno, team: widget.team),
              ),
            );
          },
          icon: Icon(
            Icons.data_saver_on_outlined,
            size: 35,
          ),
        ),
        actions: [
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Today's Work",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15)),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(widget.team)
                      .doc("Task")
                      .collection("Assign")
                      .orderBy('Assign Date', descending: true)
                      .snapshots(),
                  builder: (__,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      if (snapshot.data!.docs.isNotEmpty) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (___, int index) {
                              Map<String, dynamic> docTaskData =
                                  snapshot.data!.docs[index].data();
                              String uid = snapshot.data!.docs[index].id;
                              var Task = index + 1;
                              if (docTaskData.isEmpty) {
                                return const SizedBox(
                                  child: Center(
                                    child: Text("Document is Empty"),
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 236, 250, 251),
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "$Task",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  150,
                                              height: 50,
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      docTaskData["Task"],
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      docTaskData["Student"],
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Divider(
                                          thickness: 1,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection(widget.team)
                                                    .doc("Task")
                                                    .collection("In Progress")
                                                    .doc(uid)
                                                    .set(docTaskData);
                                                FirebaseFirestore.instance
                                                    .collection(widget.team)
                                                    .doc("Task")
                                                    .collection("Assign")
                                                    .doc(uid)
                                                    .delete();
                                              },
                                              child: Text(
                                                "In Progress",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 20),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection(widget.team)
                                                    .doc("Task")
                                                    .collection("Completed")
                                                    .doc(uid)
                                                    .set(docTaskData);
                                                FirebaseFirestore.instance
                                                    .collection(widget.team)
                                                    .doc("Task")
                                                    .collection("Assign")
                                                    .doc(uid)
                                                    .delete();
                                              },
                                              child: Text(
                                                "Complete",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 20),
                                              )),
                                        ],
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
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("In Progress",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15)),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(widget.team)
                      .doc("Task")
                      .collection("In Progress")
                      .orderBy('Assign Date', descending: true)
                      .snapshots(),
                  builder: (__,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      if (snapshot.data!.docs.isNotEmpty) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (___, int index) {
                              Map<String, dynamic> docTaskData =
                                  snapshot.data!.docs[index].data();
                              String uid = snapshot.data!.docs[index].id;
                              var Task = index + 1;
                              if (docTaskData.isEmpty) {
                                return const SizedBox(
                                  child: Center(
                                    child: Text("Document is Empty"),
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 236, 250, 251),
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "$Task",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  150,
                                              height: 50,
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      docTaskData["Task"],
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      docTaskData["Student"],
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Divider(
                                          thickness: 1,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection(widget.team)
                                                    .doc("Task")
                                                    .collection("Assign")
                                                    .doc(uid)
                                                    .set(docTaskData);
                                                FirebaseFirestore.instance
                                                    .collection(widget.team)
                                                    .doc("Task")
                                                    .collection("In Progress")
                                                    .doc(uid)
                                                    .delete();
                                              },
                                              child: Text(
                                                "Assign",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 20),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection(widget.team)
                                                    .doc("Task")
                                                    .collection("Completed")
                                                    .doc(uid)
                                                    .set(docTaskData);
                                                FirebaseFirestore.instance
                                                    .collection(widget.team)
                                                    .doc("Task")
                                                    .collection("In Progress")
                                                    .doc(uid)
                                                    .delete();
                                              },
                                              child: Text(
                                                "Complete",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 20),
                                              )),
                                        ],
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
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Completed",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15)),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(widget.team)
                      .doc("Task")
                      .collection("Completed")
                      .orderBy('Assign Date', descending: true)
                      .snapshots(),
                  builder: (__,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      if (snapshot.data!.docs.isNotEmpty) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (___, int index) {
                              Map<String, dynamic> docTaskData =
                                  snapshot.data!.docs[index].data();
                              String uid = snapshot.data!.docs[index].id;
                              var Task = index + 1;
                              if (docTaskData.isEmpty) {
                                return const SizedBox(
                                  child: Center(
                                    child: Text("Document is Empty"),
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 236, 250, 251),
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "$Task",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  150,
                                              height: 50,
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      docTaskData["Task"],
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      docTaskData["Student"],
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Divider(
                                          thickness: 1,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection(widget.team)
                                                    .doc("Task")
                                                    .collection("Assign")
                                                    .doc(uid)
                                                    .set(docTaskData);
                                                FirebaseFirestore.instance
                                                    .collection(widget.team)
                                                    .doc("Task")
                                                    .collection("Completed")
                                                    .doc(uid)
                                                    .delete();
                                              },
                                              child: Text(
                                                "Assign",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 20),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection(widget.team)
                                                    .doc("Task")
                                                    .collection("In Progress")
                                                    .doc(uid)
                                                    .set(docTaskData);
                                                FirebaseFirestore.instance
                                                    .collection(widget.team)
                                                    .doc("Task")
                                                    .collection("Completed")
                                                    .doc(uid)
                                                    .delete();
                                              },
                                              child: Text(
                                                "In Progress",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 20),
                                              )),
                                        ],
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

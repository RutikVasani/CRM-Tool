import 'package:cldc/projectmanager/pm_teamreportviewpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PmDailyReportPage extends StatefulWidget {
  final String team;
  final String idno;

  const PmDailyReportPage({super.key, required this.team, required this.idno});

  @override
  State<PmDailyReportPage> createState() => _PmDailyReportPageState();
}

class _PmDailyReportPageState extends State<PmDailyReportPage> {
  String date = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String day = DateFormat.EEEE().format(DateTime.now());

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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.team)
            .doc("Report")
            .collection("Report")
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllReportViewPage(
                                date: uid,
                                team: widget.team,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                uid,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
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
                  "No Report Avalible",
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



// Padding(
//         padding: const EdgeInsets.all(10),
//         child: InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => AllReportViewPage(),
//               ),
//             );
//           },
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: 60,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Text(
//                   "$date" + " - $day",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 25),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
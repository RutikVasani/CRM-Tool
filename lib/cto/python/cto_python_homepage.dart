import 'package:cldc/coreteam/reportviewpage.dart';
import 'package:cldc/coreteam/taskviewpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CtoPythonHomePage extends StatefulWidget {
  const CtoPythonHomePage({super.key});

  @override
  State<CtoPythonHomePage> createState() => _CtoPythonHomePageState();
}

class _CtoPythonHomePageState extends State<CtoPythonHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 250, 251),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 13, 110, 189),
        title: Text(
          "CTO - Python",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, letterSpacing: 2),
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
      body: Column(
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Python Team",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            letterSpacing: 2),
                      ),
                    ),
                  ),
                  Divider(thickness: 1.5, color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          String Team = "Python";
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskViewPage(team: Team),
                            ),
                          );
                        },
                        child: Text(
                          "Task",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          String Team = "Python";
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReportViewPage(team: Team),
                            ),
                          );
                        },
                        child: Text(
                          "Report",
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Cloud Team",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            letterSpacing: 2),
                      ),
                    ),
                  ),
                  Divider(thickness: 1.5, color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          String Team = "Cloud";
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskViewPage(team: Team),
                            ),
                          );
                        },
                        child: Text(
                          "Task",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          String Team = "Cloud";
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReportViewPage(team: Team),
                            ),
                          );
                        },
                        child: Text(
                          "Report",
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

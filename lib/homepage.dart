import 'package:cldc/coreteam/core_homepage.dart';
import 'package:cldc/cto/dev/cto_dev_homepage.dart';
import 'package:cldc/cto/python/cto_python_homepage.dart';
import 'package:cldc/projectmanager/pm_taskviewpage.dart';
import 'package:cldc/team/team_taskpage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  final String uid;
  const Home({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream:
          FirebaseFirestore.instance.collection('CLDC').doc(uid).snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            return checkRole(snapshot);
        }
      },
    );
  }

  Widget checkRole(AsyncSnapshot<DocumentSnapshot> snapshot) {
    if (snapshot.data!["Position"] == 'Project Manager') {
      return PmTaskViewPage(
        team: snapshot.data!["Team"],
        idno: snapshot.data!["ID Number"],
      );
    } else if (snapshot.data!["Position"] == 'Team Member') {
      return TeamTaskPage(
        team: snapshot.data!["Team"],
        idno: snapshot.data!["ID Number"],
      );
    } else if (snapshot.data!["Position"] == 'CTO-Python') {
      return CtoPythonHomePage();
    } else if (snapshot.data!["Position"] == 'CTO-Dev') {
      return CtoDevHomePage();
    } else {
      return CoreHomePage();
    }
  }
}

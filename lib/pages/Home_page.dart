import 'dart:js';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/pages/daily_form.dart';
import 'package:fluttertest/pages/calendar.dart';
import 'package:fluttertest/pages/main_page.dart';

import '../components/drawer_header.dart';
import 'notifications.dart';
import 'privacy_policy.dart';
import 'settings.dart';
import 'userprofile_info.dart';

import 'Trends.dart';

// For testing:
String userID = "3";
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentPage = DrawerSections.Home_page;

  int _selectedIndex = 0;
  DateTime now = DateTime.now();

  List pages = [
    DailyForm(),
    HeadacheFormMenu(),
    HeadTrackerPage.async(key: ValueKey(DateTime.now()),userID:userID),
    Trends()
  ];
  List<Color> colors1 = [Colors.white, Colors.black, Colors.white, Colors.white];
  List<Color> colors2 = [Colors.lightBlueAccent, Colors.white, Colors.lightBlueAccent, Colors.lightBlueAccent];


  int currentIndex = 0;
  void OnTap(int index) {
    setState(() {
      currentIndex= index;
      // So that page 3 can update dynamically
      now = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
      var container;
      if (currentPage == DrawerSections.Home_page) {
        container = MyHomePage();
      } else if (currentPage == DrawerSections.daily_form) {
        container = DailyForm();
      } else if (currentPage == DrawerSections.Trends) {
        container = Trends();
      } else if (currentPage == DrawerSections.userprofile_info) {
        container = userprofile_info();
      } else if (currentPage == DrawerSections.settings) {
        container = SettingsPage();
      } else if (currentPage == DrawerSections.notifications) {
        container = NotificationsPage();
      } else if (currentPage == DrawerSections.privacy_policy) {
        container = PrivacyPolicyPage();
      }

      return Scaffold(
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  MyHeaderDrawer(),
                  MyDrawerList(),
                ],
              ),
            ),
          ),
        ),

        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
      //        Container(
      //          child: IconButton(
      //            onPressed: () {
      //              // Impletement goto page here!
      //            },
      //            icon: Icon(
      //              Icons.person_pin,
      //              size: 25.0,
      //            ),
      //            color: colors1[currentIndex],
      //          ),
      //        ),

              Container(
                child: Text("Hi Kimmie!",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'handrawn',
                    color: colors1[currentIndex],
                  ),
                ),
              ),

              Container(
                child: IconButton(
                  onPressed: () {
                    // Impletement goto page here!
                  },
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    size: 25.0,
                  ),
                  color: colors1[currentIndex],
                ),
              ),


            ],
          ),
          // Text("Headache Form"),
          // centerTitle: true,
          backgroundColor: colors2[currentIndex]
      ),


      body: currentIndex == 0
          ? SingleChildScrollView(child: pages[currentIndex])
          : currentIndex == 2
          ? HeadTrackerPage.async(key: ValueKey(now),userID:userID)
          : pages[currentIndex],




      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: colors2[currentIndex],
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outlined),
            label: 'Daily Form',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'lib/images/headache.png',
              height: 40,

            ),
            label: 'Headache',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined,
                ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph,
            ),
            label: 'Trends',
          ),
        ],
        selectedItemColor: colors1[currentIndex],
        onTap: OnTap,
        type: BottomNavigationBarType.fixed,
      ),


    );
  }
}
Widget MyDrawerList() {
  var currentPage;
  return Container(
    padding: EdgeInsets.only(
      top: 15,
    ),
    child: Column(
      // shows the list of menu drawer
      children: [
        menuItem(1, "Home", Icons.home,
            currentPage == DrawerSections.Home_page ? true : false),
        menuItem(2, "Daily Form", Icons.file_copy_outlined,
            currentPage == DrawerSections.daily_form ? true : false),
        menuItem(3, "Trends", Icons.event,
            currentPage == DrawerSections.Trends ? true : false),
        menuItem(4, "Profile", Icons.person,
            currentPage == DrawerSections.userprofile_info ? true : false),
        Divider(),
        menuItem(5, "Settings", Icons.settings_outlined,
            currentPage == DrawerSections.settings ? true : false),
        menuItem(6, "Notifications", Icons.notifications_outlined,
            currentPage == DrawerSections.notifications ? true : false),
        Divider(),
        menuItem(7, "Privacy Policy", Icons.privacy_tip_outlined,
            currentPage == DrawerSections.privacy_policy ? true : false),
      ],
    ),
  );
}
Widget menuItem(int id, String title, IconData icon, bool selected) {
  return Material(
    color: selected ? Colors.grey[300] : Colors.transparent,
    child: InkWell(
      onTap: () {
        //Navigator.canPop(context);

        setState(() {
          if (id == 1) {
            var currentPage = DrawerSections.Home_page;
          } else if (id == 2) {
            var currentPage = DrawerSections.daily_form;
          } else if (id == 3) {
            var currentPage = DrawerSections.Trends;
          } else if (id == 4) {
            var currentPage = DrawerSections.userprofile_info;
          } else if (id == 5) {
            var currentPage = DrawerSections.settings;
          } else if (id == 6) {
            var currentPage = DrawerSections.notifications;
          } else if (id == 7) {
            var currentPage = DrawerSections.privacy_policy;
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                icon,
                size: 20,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void setState(Null Function() param0) {
}

enum DrawerSections {
  Home_page,
  daily_form,
  Trends,
  userprofile_info,
  settings,
  notifications,
  privacy_policy,
}
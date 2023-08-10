import 'package:flutter/material.dart';
import '../../utils/MyRoutes.dart';

class NavEP extends StatefulWidget {
  const NavEP({super.key});

  @override
  State<NavEP> createState() => _NavEPState();
}

class _NavEPState extends State<NavEP> {
  int currentIndex = 0;
  void changePage(BuildContext context, pageNum) {
    if (pageNum == 0) {
      Navigator.pushNamed(context, MyRoutes.homeEPPage);
    }
    if (pageNum == 1) {
      // Navigator.pushNamed(context, MyRoutes.loginpage);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Under Development"),
            content: Text("The 'Settings' page is not developed yet."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
       
    }
    if (pageNum == 2) {
      Navigator.pushNamed(context, MyRoutes.loginpage);
    }
    currentIndex = pageNum;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      fixedColor: Colors.white,
      backgroundColor: Color.fromRGBO(43, 98, 102, 1),
      currentIndex: currentIndex,
      iconSize: 25,
      onTap: (index) => setState(() {
        changePage(context, index);
      }),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          label: "Settings",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: Colors.white,
          ),
          label: "Logout",
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}

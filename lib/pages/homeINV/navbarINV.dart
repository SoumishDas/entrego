import 'package:flutter/material.dart';
import '../../utils/MyRoutes.dart';

class NavINV extends StatefulWidget {
  const NavINV({super.key});

  @override
  State<NavINV> createState() => _NavINVState();
}

class _NavINVState extends State<NavINV> {
  int currentIndex = 0;
  void changePage(BuildContext context, pageNum) {
    if (pageNum == 0) {
      Navigator.pushNamed(context, MyRoutes.homeINVPage);
    }
    if (pageNum == 2) {
      Navigator.pushNamed(context, MyRoutes.loginpage);
    }
    if (pageNum == 1) {
      // Show a dialog or Snackbar to indicate that the page is not developed yet
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
    currentIndex = pageNum;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      fixedColor: Colors.white,
      backgroundColor: const Color.fromRGBO(43, 98, 102, 1),
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
          backgroundColor: Colors.white,
          label: "Logout",
        )
      ],
    );
  }
}

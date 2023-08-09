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
    if (pageNum == 2) {
      // Navigator.pushNamed(context, MyRoutes.loginpage);
    }
    if (pageNum == 3) {
      // Navigator.pushNamed(context, MyRoutes.profilepage);
    }
    currentIndex = pageNum;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(43, 98, 102, 1),
      currentIndex: currentIndex,
      iconSize: 25,
      onTap: (index) => setState(() {
        changePage(context, index);
      }),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          backgroundColor: Colors.white,
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          backgroundColor: Colors.white,
          label: "Login",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          backgroundColor: Colors.white,
          label: "Profile",
        ),
      ],
    );
  }
}

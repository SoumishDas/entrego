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
    if (pageNum == 3) {
      // Navigator.pushNamed(context, MyRoutes.profilepage);
    }
    currentIndex = pageNum;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      iconSize: 35,
      onTap: (index) => setState(() {
        changePage(context, index);
      }),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          backgroundColor: Colors.amber,
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          backgroundColor: Colors.amber,
          label: "Login",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          backgroundColor: Colors.amber,
          label: "Profile",
        ),
      ],
    );
  }
}

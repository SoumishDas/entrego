import 'package:flutter/material.dart';
import '../utils/MyRoutes.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool onChanged = false;

  moveToHome(BuildContext context) async {
    setState(() {
      onChanged = true;
    });
    var myroutes = MyRoutes();
    await Future.delayed(const Duration(milliseconds: 2000));
    await Navigator.pushNamed(context, myroutes.loginpage);
    setState(() {
      onChanged = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                width: onChanged ? 50 : 150,
                height: onChanged ? 50 : 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(onChanged ? 50 : 8)),
                child: onChanged
                    ? const Icon(
                        Icons.arrow_forward_sharp,
                        color: Colors.white,
                      )
                    : const Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                width: onChanged ? 50 : 150,
                height: onChanged ? 50 : 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(onChanged ? 50 : 8)),
                child: onChanged
                    ? const Icon(
                        Icons.arrow_forward_sharp,
                        color: Colors.white,
                      )
                    : const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

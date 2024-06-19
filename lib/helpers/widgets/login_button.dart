import 'package:flutter/material.dart';

import '../constants/color.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(100)),
          child: const Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Text('Login',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
          ),
        ),
      ),
    );
  }
}

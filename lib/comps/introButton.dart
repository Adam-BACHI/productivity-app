import 'package:flutter/material.dart';

class introButton extends StatelessWidget {
  final String title;

  const introButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset(
            'lib/images/button.png',
            width: 300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(225, 253, 253, 252),
                    fontSize: 30,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_right,
                size: 45,
                color: Color.fromARGB(225, 253, 253, 252),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

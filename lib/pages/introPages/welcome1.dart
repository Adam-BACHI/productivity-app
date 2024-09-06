import 'package:flutter/material.dart';

class Welcome1 extends StatelessWidget {
  const Welcome1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 170),
        Center(
          child: Image.asset(
            'lib/images/image1.png',
            width: 180,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Center(
          child: Text(
            'Gagnez du temps!',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 253, 253, 252)),
          ),
        ),
        Center(
          child: Text(
            'Lorem ipsum Lorem ipsumLorem ipsumLorem\n                          ipsumLorem ipsum',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 253, 253, 252)),
          ),
        ),
      ],
    );
  }
}

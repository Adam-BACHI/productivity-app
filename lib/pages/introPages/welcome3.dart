import 'package:flutter/material.dart';

class Welcome3 extends StatelessWidget {
  const Welcome3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 170),
        Center(
          child: Image.asset(
            'lib/images/image3.png',
            width: 180,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        const Center(
          child: Text(
            'Finish all your tasks',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 253, 253, 252)),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Center(
          child: Text(
            'Lorem ipsum Lorem ipsumLorem ipsumLorem\nipsumLorem ipsum',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 253, 253, 252)),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

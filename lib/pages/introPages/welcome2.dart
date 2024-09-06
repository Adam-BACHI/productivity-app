import 'package:flutter/material.dart';

class Welcome2 extends StatelessWidget {
  const Welcome2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 170),
        Center(
          child: Image.asset(
            'lib/images/image2.png',
            width: 180,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        const Center(
          child: Text(
            'Obtenez un plan personnalise!',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 253, 253, 252)),
          ),
        ),
        const Center(
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

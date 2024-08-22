import 'package:flutter/material.dart';

class percentTask extends StatefulWidget {
  const percentTask({super.key});

  @override
  State<percentTask> createState() => _percentTaskState();
}

class _percentTaskState extends State<percentTask> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hier',
              style: TextStyle(
                  color: Color.fromARGB(255, 252, 252, 253),
                  fontFamily: 'Open',
                  fontSize: 11,
                  fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                Container(
                  height: 6,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 255, 222, 125),
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('70%',
                      style: TextStyle(
                          color: Color.fromARGB(255, 252, 252, 253),
                          fontFamily: 'Open',
                          fontSize: 11,
                          fontWeight: FontWeight.w400)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

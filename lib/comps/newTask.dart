import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  String dropValue =
      'one'; // Set this to a value that exists in the DropdownMenuItem list

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 18, 26, 39),
      content: Container(
        height: 200,
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Task name..."),
            ),
            DropdownButton<String>(
              value: dropValue,
              icon: const Icon(
                Icons.arrow_downward,
              ),
              style: const TextStyle(color: Colors.white),
              dropdownColor: const Color.fromARGB(
                  255, 18, 26, 39), // Optional: match dropdown color to dialog
              onChanged: (String? newValue) {
                setState(() {
                  dropValue = newValue!;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 'one',
                  child: Text('one'),
                ),
                DropdownMenuItem(
                  value: 'two',
                  child: Text('two'),
                ),
                DropdownMenuItem(
                  value: 'three',
                  child: Text('three'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

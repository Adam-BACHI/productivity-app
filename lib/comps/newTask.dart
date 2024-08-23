import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  final controller;
  final VoidCallback save;
  final VoidCallback cancel;
  final ValueChanged<String> onDropValueChanged;
  final ValueChanged onDateSelection;

  NewTask({
    super.key,
    required this.controller,
    required this.save,
    required this.cancel,
    required this.onDropValueChanged,
    required this.onDateSelection,
  });

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  String dropValue = 'categorie';

  DateTime date = DateTime.now();

  void _datePick() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2026))
        .then((selectedDate) {
      setState(() {
        date = selectedDate!;
      });
      widget.onDateSelection(date);
    });
  } // Set this to a value that exists in the DropdownMenuItem list

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 18, 26, 39),
      content: SizedBox(
        height: 230,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: widget.controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Task name...",
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: DropdownButton<String>(
                value: dropValue,
                icon: const Icon(
                  Icons.arrow_downward,
                ),
                style: const TextStyle(color: Colors.white),
                dropdownColor: const Color.fromARGB(255, 18, 26,
                    39), // Optional: match dropdown color to dialog
                onChanged: (String? newValue) {
                  setState(() {
                    dropValue = newValue!;
                  });
                  widget.onDropValueChanged(newValue!);
                },
                items: const [
                  DropdownMenuItem(
                    value: 'categorie',
                    child: Text('categorie'),
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  onPressed: _datePick,
                  child: const Text(
                    "choose date",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text(
                  '${date.day} - ${date.month} - ${date.year}',
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: widget.save,
                    color: const Color.fromARGB(255, 0, 184, 169),
                    child: const Text('ajouter'),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  MaterialButton(
                    onPressed: widget.cancel,
                    color: const Color.fromARGB(255, 0, 184, 169),
                    child: const Text('annuler'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

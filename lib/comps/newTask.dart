import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:productivity_app/dataBase/TaskList.dart';

class NewTask extends StatefulWidget {
  final controller;
  final VoidCallback save;
  final VoidCallback cancel;
  final ValueChanged<String> onDropValueChanged;
  final ValueChanged onTimeSelection;

  const NewTask({
    super.key,
    required this.controller,
    required this.save,
    required this.cancel,
    required this.onDropValueChanged,
    required this.onTimeSelection,
  });

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  DataBase db = DataBase();
  final _myBase = Hive.box("TaskBase");

  @override
  void initState() {
    //if it's the first time the app is launched
    //then crate Default list
    if (_myBase.get("TODOLIST") == null) {
      db.DefaultData();
    } else {
      db.LoadData();
    }

    db.UpdateData();

    super.initState();
  }

  String dropValue = 'categorie';

  TimeOfDay time = TimeOfDay.now();

  void _timePick() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((selectedTime) {
      setState(() {
        time = selectedTime!;
      });
      widget.onTimeSelection(time);
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
                  items: db.categories.map((cat) {
                    return DropdownMenuItem(
                      value: cat,
                      child: Text(cat),
                    );
                  }).toList()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  onPressed: _timePick,
                  child: const Text(
                    "choose date",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text(
                  time.format(context).toString(),
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

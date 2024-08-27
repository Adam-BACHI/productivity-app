import 'package:flutter/material.dart';

class NewCat extends StatefulWidget {
  final controller;
  final VoidCallback save;
  final VoidCallback cancel;
  const NewCat(
      {super.key,
      required this.controller,
      required this.save,
      required this.cancel});

  @override
  State<NewCat> createState() => _NewCatState();
}

class _NewCatState extends State<NewCat> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 18, 26, 39),
        content: SizedBox(
            height: 130,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    controller: widget.controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Categorie name...",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
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
                ])));
  }
}

import 'package:flutter/material.dart';

class ProgressSlide extends StatefulWidget {
  final ValueChanged onProgressChanged;
  final double progress;

  const ProgressSlide({
    super.key,
    required this.onProgressChanged,
    required this.progress,
  });

  @override
  State<ProgressSlide> createState() => _ProgressSlideState();
}

class _ProgressSlideState extends State<ProgressSlide> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: SizedBox(
            height: 10.0,
            width: 300.0,
            child: Slider(
                value: widget.progress,
                min: 0,
                max: 100,
                onChanged: (value) {
                  setState(() {
                    widget.onProgressChanged(value);
                  });
                },
                inactiveColor: Color.fromARGB(255, 50, 60, 72),
                activeColor: widget.progress < 25
                    ? Color.fromARGB(255, 246, 65, 108)
                    : widget.progress < 50
                        ? Color.fromARGB(255, 255, 160, 45)
                        : widget.progress < 75
                            ? Color.fromARGB(255, 255, 222, 125)
                            : Color.fromARGB(255, 104, 217, 195))),
      ),
    );
  }
}

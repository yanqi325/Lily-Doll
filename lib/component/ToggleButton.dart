import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final bool? isSwitched;
  Function? onChanged;

  ToggleButton({required this.isSwitched, this.onChanged});

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  late bool isSwitch;
  Function? onChange;

  @override
  void initState() {
    super.initState();
    isSwitch = widget.isSwitched!;
    onChange = widget.onChanged;

  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Switch(
        value: isSwitch,
        activeColor: Colors.lightGreenAccent,
        onChanged: (value) {
          setState(() {
            isSwitch = value;
            onChange;
          });
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class educator_textField extends StatefulWidget {
  final String? title;
  final String? hintText;
  final void Function(String)? onChanged;
  bool isSelection = false;
  List<Map<String,dynamic>>? popupItems;

  educator_textField ({
    this.title,
    this.hintText,
    this.onChanged,
    required this.isSelection,
    this.popupItems,
  });

  @override
  _EducatorTextFieldState createState() => _EducatorTextFieldState();
}

class _EducatorTextFieldState extends State<educator_textField > {
  String userEnteredValue = "";
  TextEditingController _controller = TextEditingController();

  // Function to show the popup menu
  void showPopup(BuildContext context) async {
    if (widget.popupItems != null) {
      final String? selectedItem = await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(0, 0, 0, 0),
        items: widget.popupItems!.map((item) {
          return PopupMenuItem<String>(
            value: item["Username"],
            child: Text(item["Username"]),
          );
        }).toList(),
      );
      if (selectedItem != null) {
        // Handle the selected item
        setState(() {
          userEnteredValue = selectedItem;
          changeTextFieldText(selectedItem);
        });
        if (widget.onChanged != null) {
          widget.onChanged!(selectedItem);
        }
      }
    }
  }

  void changeTextFieldText(String newText) {
    _controller.text = newText; // Set the text using the controller
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title!,
            style: kTextFieldLabelStyle.copyWith(fontSize: 15),
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              setState(() {
                userEnteredValue = value;
              });
              // Call the callback function
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            onTap: (){
              if(widget.isSelection){
                //enable pop up box
                showPopup(context);

              }
              //open popup box
            },
            controller: _controller,
            decoration: kTextFieldDecoration.copyWith(
              hintText: widget.hintText!,
              hintStyle: TextStyle(
                fontFamily: fontFamily2,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
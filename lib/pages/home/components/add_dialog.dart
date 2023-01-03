import 'package:flutter/material.dart';
import 'package:to_do_app/constants.dart';
import 'package:to_do_app/pages/home/components/dialog_button.dart';

class AddDialog extends StatelessWidget{
  final TextEditingController textFieldController = TextEditingController();
  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        width: screenSize.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: textFieldController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add a new task",
                focusedBorder: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black)
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DialogButton("Save", () => textFieldController.text.isEmpty ? null : Navigator.pop(context, textFieldController)),
                SizedBox(width: kDefaultPadding,),
                DialogButton("Cancel", Navigator.of(context).pop),
              ],
            )
          ],
        ),
      ),
    );
  }
}

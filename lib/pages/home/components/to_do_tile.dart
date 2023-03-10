import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/constants.dart';

class ToDoTile extends StatelessWidget {
  final Function(BuildContext) onDelete;
  final VoidCallback onSelected;
  final bool isSelected;
  final String title;

  const ToDoTile(
      {Key? key,
      required this.title,
      required this.isSelected,
      required this.onSelected,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onDelete,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(kBorderRadius),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(kDefaultPadding),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(kBorderRadius),
              border: Border.all(color: Colors.black26),
          ),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Transform.scale(
                    scale: 1.1,
                    child: Checkbox(
                        value: isSelected,
                        checkColor: Colors.white,
                        activeColor: Colors.black,
                        onChanged: (_) => onSelected()),
                  ),
                  Flexible(
                      child: Text(
                    title,
                    style: TextStyle(
                        fontSize: kFontSize,
                        decoration: isSelected
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ))
                ],
              )),
              SizedBox(
                width: kDefaultPadding,
              ),
              Icon(
                Icons.dehaze_sharp,
                color: Colors.grey[600],
              )
            ],
          ),
        ),
      ),
    );
  }
}

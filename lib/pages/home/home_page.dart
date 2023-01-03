import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:to_do_app/constants.dart';
import 'package:to_do_app/pages/home/components/add_dialog.dart';
import 'package:to_do_app/pages/home/components/to_do_tile.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List toDolist = [
    ["Make to do", false],
    ["Have crush", true]
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text("TO DO"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: kDefaultPadding),
        child: ReorderableListView(
          onReorder: (oldIndex, newIndex) => reorderTiles(oldIndex, newIndex),
          children: List<Widget>.generate(
              toDolist.length,
              (index) => ToDoTile(
                    title: toDolist[index][0],
                    isSelected: toDolist[index][1],
                    onSelected: () => onSelectedCheckbox(index),
                    onDelete: (context) => DeleteTask(index),
                    key: UniqueKey(),
                  )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          createNewTask(context);
        },
      ),
    );
  }

  void createNewTask(BuildContext context) async {
    TextEditingController tempTextController =
        await showDialog(context: context, builder: (context) => AddDialog());
    if (tempTextController != null) {
      setState(() {
        toDolist.add([tempTextController.text, false]);
      });
    }
  }

  void DeleteTask(int index) {
    setState(() {
      toDolist.removeAt(index);
    });
  }

  void reorderTiles(int oldIndex, int newIndex)
  {
    setState(() {
      if (oldIndex < newIndex)
        newIndex--;
      final tile = toDolist.removeAt(oldIndex);
      toDolist.insert(newIndex, tile);
    });
  }

  void onSelectedCheckbox(int index)
  {
    setState(() {
      toDolist[index][1] = !toDolist[index][1];
    });
  }
}

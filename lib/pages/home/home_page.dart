import 'package:flutter/material.dart';
import 'package:to_do_app/constants.dart';
import 'package:to_do_app/pages/home/components/add_dialog.dart';
import 'package:to_do_app/pages/home/components/to_do_tile.dart';
import 'package:to_do_app/utils/hive_helper.dart';
import 'package:to_do_app/utils/proxy_decorator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HiveHelper hiveHelper = HiveHelper();
  late List toDoList;
  @override
  void initState() {
    super.initState();
    toDoList = hiveHelper.getToDoList();
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
          proxyDecorator: ProxyDecorator,
          onReorder: (oldIndex, newIndex) => reorderTiles(oldIndex, newIndex),
          children: List<Widget>.generate(
              toDoList.length,
              (index) => ToDoTile(
                    title: toDoList[index][0],
                    isSelected: toDoList[index][1],
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
        toDoList.add([tempTextController.text, false]);
      });
    }
    hiveHelper.saveToDoList(toDoList);
  }

  void DeleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
    hiveHelper.saveToDoList(toDoList);
  }

  void reorderTiles(int oldIndex, int newIndex)
  {
    setState(() {
      if (oldIndex < newIndex)
        newIndex--;
      final tile = toDoList.removeAt(oldIndex);
      toDoList.insert(newIndex, tile);
    });
    hiveHelper.saveToDoList(toDoList);
  }

  void onSelectedCheckbox(int index)
  {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
    hiveHelper.saveToDoList(toDoList);
  }
}

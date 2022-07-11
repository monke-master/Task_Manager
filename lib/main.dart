import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:task_manager/categories_list.dart';
import 'package:task_manager/category_page.dart';
import 'package:task_manager/data.dart';
import 'package:task_manager/task.dart';

void main() {
  Data.categories.add("no category");
  Data.categories.add("Baumanka");
  // Data.categories.add("Hoe tasks");
  Data.tasks["no category"] = [];
  Data.tasks["no category"]!.add(Task("Vlad Gay", "no category"));
  Data.tasks["no category"]!.add(Task("Vlad Gay", "no category"));
  Data.tasks["no category"]!.add(Task("Vlad Gay", "no category"));
  Data.tasks["Baumanka"] = [];
  Data.tasks["Baumanka"]!.add(Task("Gay sex", "Baumanka"));
  runApp(Application());
}


class Application extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task manager',
      home: Scaffold(
        body: MainPage(),
      )
    );
  }
}


class MainPage extends StatefulWidget {

  String _category = "no category";

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }

}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: double.maxFinite,
              child: CategoriesList(
                onCategoryChanged: (String category) =>
                    setState(() => widget._category = category),
              ),
            )
            //addCategoryBtn(context),
          ],
        ),
        Expanded(
          child: CategoryPage(widget._category)),
      ],
    );
  }

  Widget addCategoryBtn(BuildContext context) {
    return TextButton(
      onPressed: () => showAddCategoryDialog(context),
      child: Text("+"),
    );
  }

  void showAddCategoryDialog(BuildContext context) {
    TextEditingController textController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("New category"),
            content: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Create a task"
              ), controller: textController,
            ),
            actions: [
              TextButton(
                child: Text("Enter"),
                onPressed: () {
                  String newCategory = textController.text;
                  if (!Data.categories.contains(newCategory)) {
                    Data.categories.add(newCategory);
                    Data.tasks[newCategory] = [];
                  }
                  setState(() {});
                },
              )
            ],
          );
        });
  }

}


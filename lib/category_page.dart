import 'package:flutter/material.dart';
import 'package:task_manager/data.dart';
import 'package:task_manager/task.dart';
import 'package:task_manager/task_widget.dart';


// TODO make active and completed tasks in one list view with header

// Page with tasks of selected category
class CategoryPage extends StatefulWidget {
  String? _category;

  CategoryPage(this._category, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CategoryPageState();
  }

}

class _CategoryPageState extends State<CategoryPage> {
  String _newTaskCategory = "no category";


  @override
  Widget build(BuildContext context) {
    String category = widget._category!;
    // Getting task from selected category
    List<Task> tasks = [];
    if (category == "no category") {
      for (String cat in Data.categories) {
        tasks.addAll(Data.tasks[cat]!);
      }
    } else {
      tasks.addAll(Data.tasks[category]!);
    }
    // Sorting task for active and completed
    List<Task> activeTasks = [];
    List<Task> completedTask = [];
    for (Task task in tasks) {
      if (task.complete) {
        completedTask.add(task);
      } else {
        activeTasks.add(task);
      }
    }
    // Creating Task Lists
    return Column(children: [
      Expanded(
        child: SizedBox(
          height: 200,
          child: TasksList(
            activeTasks,
            onListChanged: () => setState(() => widget._category = widget._category),
          ),
        ),
      ),
      Text("completed tasks"),
      Expanded(
        child: SizedBox(
          height: 200,
          child: TasksList(
            completedTask,
            onListChanged: () => setState(() => widget._category = widget._category),
          ),
        ),
      ),
      Container(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(bottom: 10),
        child: IconButton(icon: Image.asset('assets/buttons/add.png'),
          onPressed: () => showTaskDialog(context),
        ),
      )
    ],
    );
  }

  // Creating new task dialog
  void showTaskDialog(BuildContext context) {
    List<String> categories = [];
    categories.addAll(Data.categories);
    TextEditingController textController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                // Input the task's name
                content: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Create a task"
                  ), controller: textController,
                ),
                actions: [
                  // Dropdown list of categories
                  DropdownButton(
                    value: _newTaskCategory,
                    items: Data.categories.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(
                          value: value,
                          child: Text(value)
                      );
                    }).toList(),
                    onChanged: (String? value) =>
                        setState(() => _newTaskCategory = value!),
                  ),
                  // Enter button
                  TextButton(
                      onPressed: () {
                        Data.tasks[_newTaskCategory]!.
                        add(Task(textController.text, _newTaskCategory));
                        setChanges();
                        Navigator.pop(context);
                      },
                      child: Text("Enter")),
                ],
              );
        });
    });
  }


  void setChanges() {
    setState(() {});
  }


}


import 'package:flutter/material.dart';
import 'package:task_manager/data.dart';
import 'package:task_manager/task.dart';
import 'package:task_manager/task_list.dart';



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

  @override
  Widget build(BuildContext context) {
    String category = widget._category!;
    // Getting task from selected category
    List<Task> tasks = [];
    if (category == "no category") {
      for (String cat in Data.tasks.keys) {
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
          child: TasksList(activeTasks, completedTask, onListChanged: () => setState(() {}),)
      ),

    ],
    );
  }


}

